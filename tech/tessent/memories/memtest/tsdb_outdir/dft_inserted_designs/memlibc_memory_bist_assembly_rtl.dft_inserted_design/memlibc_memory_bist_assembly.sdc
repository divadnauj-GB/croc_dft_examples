#--------------------------------------------------------------------------
#
#  Unpublished work. Copyright 2021 Siemens
#
#  This material contains trade secrets or otherwise confidential 
#  information owned by Siemens Industry Software Inc. or its affiliates 
#  (collectively, SISW), or its licensors. Access to and use of this 
#  information is strictly limited as set forth in the Customer's 
#  applicable agreements with SISW.
#
#--------------------------------------------------------------------------
#  File created by: Tessent Shell
#          Version: 2022.3
#       Created on: Sat Nov 15 20:33:34 EST 2025
#--------------------------------------------------------------------------

#
#  Procs table of content:
#
#    tessent_set_default_variables
#    tessent_create_functional_clocks
#    tessent_set_ijtag_non_modal
#    tessent_set_non_modal
#    set_ijtag_retargeting_options
#    tessent_set_memory_bist_non_modal
#    tessent_set_memory_bist_modal
#    tessent_get_cells
#    tessent_get_flops
#    tessent_get_pins
#    tessent_get_ports
#    tessent_map_to_verilog
#    tessent_remap_vhdl_path_list
#    tessent_remove_clock_groups
#    tessent_get_clock_source
#    tessent_set_clock_sense_stop_propagation
#    tessent_kill_functional_paths
#    tessent_get_mem_cells
#    tessent_get_clocks
#    tessent_get_preserve_instances
#    tessent_get_size_only_instances
#    tessent_get_optimize_instances
#
proc tessent_set_default_variables {} {
  global time_unit_multiplier tessent_tck_period tessent_tck_clocks_list tessent_clock_mapping tessent_input_delay_percentage tessent_output_delay_percentage tessent_tck_clocks_group_created tessent_mbist_create_bap_tck_generated_clock mbist_info tessent_hierarchy_separator tessent_path_cache tessent_timing_tool tessent_test_inst_regexp tessent_unmapped_functional_clocks
  #
  # This proc defines the default value of the variables used in instrument timing constraints
  #

  # Time units assumed ns
  set time_unit_multiplier 1.0

  set tessent_tck_period 100.0

  set tessent_tck_clocks_list [list tessent_tck]

  # Override these array elements to map to your clock names if you define your own clocks
  array set tessent_clock_mapping {
    tessent_tck tessent_tck
    BIST_CLK BIST_CLK
  }

  set tessent_input_delay_percentage 0.25

  set tessent_output_delay_percentage 0.25

  set tessent_tck_clocks_group_created 0

  # You can set this variable to 0 if you do not want to create a generated clock inside the MemoryBist BAP instances.
  #  The drawback of doing this will be that clock tree synthesis will have to balance TCK from the BAP to the controllers and interfaces.
  set tessent_mbist_create_bap_tck_generated_clock 1

  # Use this mapping to find which unique identifier maps to which controller or interface instance.
  set mbist_info {
    bap1 {
      shift_en_port ijtag_se
      inst memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst
      tck_type port
      tck ijtag_tck
      to_bist toBist_reg
      from_bist fromBist_retime_reg
    }
    mbist1 {
      inst mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst
      bap_id bap1
      bist_port 0
      async_interface_present false
    }
    mbist1_m1 {inst mem_container_inst/m1_mem_inst_interface_inst}
    mbist1_m1_memory {inst mem_container_inst/m1_mem_inst}
  }

  set tessent_hierarchy_separator /

  array set tessent_path_cache {
  }

  switch -glob [file tail [info nameofexecutable]] {
    common_shell_exec {set tessent_timing_tool dc_shell}
    oasys*            {set tessent_timing_tool oasys}
    rc                {set tessent_timing_tool encounter}
    genus             {set tessent_timing_tool genus}
    default           {set tessent_timing_tool pt_shell}
  }
  

  set tessent_test_inst_regexp {(.*_tessent_mbist_.*|.*_interface_inst.*)}

  # Default set of unmapped functional clocks. To be mapped with tessent_clock_mapping array for real clock names.
  # Populated by tessent_create_functional_clocks.
  set tessent_unmapped_functional_clocks [list ]

}
proc tessent_create_functional_clocks {} {
global time_unit_multiplier tessent_clock_mapping tessent_unmapped_functional_clocks
  create_clock [tessent_get_ports [list {BIST_CLK}]]  \
    -period [expr 10.0*$time_unit_multiplier] \
    -name $tessent_clock_mapping(BIST_CLK) -add


  set tessent_unmapped_functional_clocks [lsort -unique [concat $tessent_unmapped_functional_clocks [list BIST_CLK]]]
}
proc tessent_set_ijtag_non_modal {} {  
  
  global time_unit_multiplier tessent_tck_period tessent_tck_clocks_list tessent_tck_clocks_group_created
  global tessent_clock_mapping tessent_input_delay tessent_input_delay_percentage tessent_output_delay tessent_output_delay_percentage
  
  if {[info exists tessent_input_delay]} {
    set local_input_delay $tessent_input_delay
  } else {
    set local_input_delay [expr {$tessent_input_delay_percentage*$tessent_tck_period*$time_unit_multiplier}]
  }
  if {[info exists tessent_output_delay]} {
    set local_output_delay $tessent_output_delay
  } else {
    set local_output_delay [expr {$tessent_output_delay_percentage*$tessent_tck_period*$time_unit_multiplier}]
  }
    
  if {[sizeof_collection [tessent_get_clocks $tessent_clock_mapping(tessent_tck) -quiet]] == 0} {
    create_clock [tessent_get_ports [list {ijtag_tck}]]  \
      -period [expr $tessent_tck_period*$time_unit_multiplier] \
      -name $tessent_clock_mapping(tessent_tck) -add
  
  }
  set mapped_tck_clock_list [list]
  foreach tck_clock $tessent_tck_clocks_list {
    lappend mapped_tck_clock_list $tessent_clock_mapping($tck_clock)
  }
  if {[sizeof_collection [tessent_get_clocks $mapped_tck_clock_list -quiet]] > 0} {
    tessent_remove_clock_groups -asynchronous tessent_tck_clock_group
    set_clock_groups -asynchronous -group [tessent_get_clocks $mapped_tck_clock_list] -name tessent_tck_clock_group
    set tessent_tck_clocks_group_created 1
  }
  set_false_path -from [tessent_get_ports [list {ijtag_reset}]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_ports [list {ijtag_sel}]] 
  set_multicycle_path -hold 2 \
      -from [tessent_get_ports [list {ijtag_sel}]] 
  set_input_delay  $local_input_delay -clock $tessent_clock_mapping(tessent_tck) [tessent_get_ports {ijtag_ce}]  -clock_fall
  set_input_delay  $local_input_delay -clock $tessent_clock_mapping(tessent_tck) [tessent_get_ports {ijtag_se}]  -clock_fall
  set_input_delay  $local_input_delay -clock $tessent_clock_mapping(tessent_tck) [tessent_get_ports {ijtag_ue}] 
  set_input_delay  $local_input_delay -clock $tessent_clock_mapping(tessent_tck) [tessent_get_ports {ijtag_sel}]  -clock_fall
  set_input_delay  $local_input_delay -clock $tessent_clock_mapping(tessent_tck) [tessent_get_ports {ijtag_si}]  -clock_fall
  set_output_delay $local_output_delay -clock $tessent_clock_mapping(tessent_tck) [tessent_get_ports {ijtag_so}] 
  
  set scan_resource_sib_list {
    memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst/to_enable_int*
  }
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $scan_resource_sib_list] 
  set_multicycle_path -hold 2 \
      -from [tessent_get_cells $scan_resource_sib_list] 
  
}
proc tessent_set_non_modal {} {
  tessent_set_ijtag_non_modal
  tessent_set_memory_bist_non_modal
}
proc set_ijtag_retargeting_options {args} {  
  
    # Issue the set_ijtag_retargeting_options command from within your master timing 
    # script in order establish the settings requirements for pattern generation.
    # Tessent Shell supports the same command with the same syntax, allowing you
    # to consistently specify these settings across your simulations, synthesis 
    # and STA runs. You may want to place the calls to this command into a file
    # and source it from Tessent Shell and your synthesis/timing tools.
    array set tessent_timing_option2var_mapping {
      -tck_period tessent_tck_period
    }
    foreach key [array names tessent_timing_option2var_mapping] {
      global [subst $tessent_timing_option2var_mapping($key)]
    }
    # Parse options, assuming default value from tessent_set_default_variables.
    foreach {key value} $args {
      if {![info exists tessent_timing_option2var_mapping($key)]} {
        set warning_list [list]
        lappend warning_list "Tessent SDC Warning: The option '$key' is not supported by the SDC version of set_ijtag_retargeting_options."
        lappend warning_list "                     Supported arguments are: [join [lsort [array get tessent_timing_option2var_mapping]]{, }]."
        puts [join $warning_list "\n"]
        continue
      }
      if {$key eq "-tck_period"} {
        #get only the number from -tck_period
        set value [regexp -inline {^[0-9]+(?:.[0-9]+)?} $value]
      }
      set [subst $tessent_timing_option2var_mapping($key)] $value
    }
  
}
proc tessent_set_memory_bist_non_modal {} {  
  
  global mbist_info tessent_clock_mapping tessent_apply_mbist_mux_constraints tessent_mbist_create_bap_tck_generated_clock tessent_tck_clocks_list tessent_tck_clocks_group_created 
  
    set bap1_interfaces_tck_name bap1_interfaces_tck
    set bap1_tck_name bap1_tck
  if {$tessent_mbist_create_bap_tck_generated_clock} {
    create_generated_clock [tessent_get_pins [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BUF_C_TCK/y]  \
      -name $bap1_tck_name \
      -source [tessent_get_ports [list {ijtag_tck}]]  \
      -add -master_clock $tessent_clock_mapping(tessent_tck) \
      -divide_by 1 \
      -combinational
    create_generated_clock [tessent_get_pins [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BUF_I_TCK/y]  \
      -name $bap1_interfaces_tck_name \
      -source [tessent_get_ports [list {ijtag_tck}]]  \
      -add -master_clock $tessent_clock_mapping(tessent_tck) \
      -divide_by 1 \
      -combinational
    set bap1_tck_clocks [tessent_get_clocks [list $bap1_interfaces_tck_name $bap1_tck_name]]
    # Update the TCK asynchronous clock group
    set tessent_clock_mapping(bap1_tck) bap1_tck
    lappend tessent_tck_clocks_list bap1_tck
    set tessent_clock_mapping(bap1_interfaces_tck) bap1_interfaces_tck
    lappend tessent_tck_clocks_list bap1_interfaces_tck
    set mapped_tck_clock_list [list]
    foreach tck_clock $tessent_tck_clocks_list {
      lappend mapped_tck_clock_list $tessent_clock_mapping($tck_clock)
    }
    tessent_remove_clock_groups -asynchronous tessent_tck_clock_group
    set_clock_groups -asynchronous -name tessent_tck_clock_group -group [tessent_get_clocks $mapped_tck_clock_list]
    set tessent_tck_clocks_group_created 1
    # TCK from the BAP must only constrain the shift path, block false same-edge paths, they are constrained with functional clock
    set_false_path -rise_from [tessent_get_clocks $bap1_tck_name] -rise_to [tessent_get_clocks $bap1_interfaces_tck_name]
    set_false_path -rise_from [tessent_get_clocks $bap1_interfaces_tck_name] -rise_to [tessent_get_clocks $bap1_tck_name]
    set_false_path -fall_from [tessent_get_clocks $bap1_tck_name] -fall_to [tessent_get_clocks $bap1_interfaces_tck_name]
    set_false_path -fall_from [tessent_get_clocks $bap1_interfaces_tck_name] -fall_to [tessent_get_clocks $bap1_tck_name]
  } else {
    set bap1_tck_clocks [tessent_get_clocks $tessent_clock_mapping(tessent_tck)]
  }
  
  # BIST_EN, BIST_HOLD are MCP by protocol
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_bistEn_0/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_HOLD/y]] 
  set_multicycle_path -hold 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_bistEn_0/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_HOLD/y]] 
  # TDR bits are MCP by protocol to controller
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_2_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ASYNC_RESET/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_TCK_MODE/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_ENABLE_MEM_RESET_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_REDUCED_ADDRESS_COUNT_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SELECT_TEST_DATA_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ALGO_MODE0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ALGO_MODE1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_DIAG_EN_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_FL_CNT_MODE0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_FL_CNT_MODE1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_INCLUDE_MEM_RESULTS_REG_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_CHAIN_BYPASS_EN_buf/y]] 
  set_multicycle_path -hold 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_2_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ASYNC_RESET/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_TCK_MODE/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_ENABLE_MEM_RESET_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_REDUCED_ADDRESS_COUNT_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SELECT_TEST_DATA_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ALGO_MODE0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ALGO_MODE1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_DIAG_EN_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_FL_CNT_MODE0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_FL_CNT_MODE1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_INCLUDE_MEM_RESULTS_REG_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_CHAIN_BYPASS_EN_buf/y]] 
  
  set bap1_go_buffers_l [list]
  lappend bap1_go_buffers_l [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_MBISTPG_GO/y
  set bap1_done_buffers_l [list]
  lappend bap1_done_buffers_l [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_MBISTPG_DONE/y
  
  # Same edge (p->p) timing paths through these controller buffers are false path by protocol
  set_false_path -rise_from $bap1_tck_clocks -rise_to [tessent_get_clocks $tessent_clock_mapping(tessent_tck)]\
         -through [tessent_get_pins [concat $bap1_go_buffers_l $bap1_done_buffers_l]]
  # Opposite edge (n->p) timing paths through these controller buffers are MCP 2 by protocol
  set_multicycle_path 2 -setup -fall_from [tessent_get_clocks $tessent_clock_mapping(tessent_tck)] -rise_to [tessent_get_clocks $tessent_clock_mapping(tessent_tck)]\
         -through [tessent_get_pins [concat $bap1_go_buffers_l]]
  set_multicycle_path 1 -hold  -fall_from [tessent_get_clocks $tessent_clock_mapping(tessent_tck)] -rise_to [tessent_get_clocks $tessent_clock_mapping(tessent_tck)]\
         -through [tessent_get_pins [concat $bap1_go_buffers_l]]
  
  ## Constraints for memory_bist controller 'mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst'
  
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] 
  set_multicycle_path -setup 3 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_RUN/y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_RUN/y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?5? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?4? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?2? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?1? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?0?]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?11? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?10? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?9? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?8? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?7? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?6?]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?5? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?4? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?2? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?1? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?0?]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?11? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?10? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?9? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?8? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?7? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?6?]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?5? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?4? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?2? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?1? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?0?]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?11? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?10? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?9? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?8? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?7? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?6?]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?5? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?4? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?2? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?1? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?0?]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?11? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?10? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?9? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?8? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?7? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?6?]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/JCNT* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_X1_MINMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_Y1_MINMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_LOOPCOUNTMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER3/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER4/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER5/y]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/JCNT* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_X1_MINMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_Y1_MINMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_LOOPCOUNTMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER3/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER4/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER5/y]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE**] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/EDATA_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/WDATA_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE**] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/EDATA_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/WDATA_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_3/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_4/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_5/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_6/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_7/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_8/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_3/y]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_3/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_4/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_5/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_6/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_7/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_8/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_3/y]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT_REG1* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT_REG1* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/BIST_EN_RETIME2*] \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_ON/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_AND_DEFAULT_MODE/y]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/BIST_EN_RETIME2*] \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_ON/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_AND_DEFAULT_MODE/y]] 
  set_disable_timing  [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_CLK_INT/s] 
  
  ## Constraints for memory_bist interface 'mem_container_inst/m1_mem_inst_interface_inst'
  ##   of controller 'mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst'
  
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1_m1 inst]/BIST_INPUT_SELECT*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1_m1 inst]/tessent_persistent_cell_BIST_INPUT_SELECT_INT/y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1_m1 inst]/BIST_INPUT_SELECT*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1_m1 inst]/tessent_persistent_cell_BIST_INPUT_SELECT_INT/y] 
  set_multicycle_path -setup 2 -start \
      -from [tessent_get_cells [list [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT**]] \
      -to   [tessent_get_cells [dict get $mbist_info mbist1_m1 inst]/A_DOUT_SCAN_IN*]  
  set_multicycle_path -hold  1 -end \
      -from [tessent_get_cells [list [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT**]] \
      -to   [tessent_get_cells [dict get $mbist_info mbist1_m1 inst]/A_DOUT_SCAN_IN*]  
  
  set_multicycle_path -setup 2 -start \
      -from [tessent_get_cells [list  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?3?]] \
      -to   [tessent_get_cells  [dict get $mbist_info mbist1_m1 inst]/MBISTPG_STATUS/GO_ID_REG*]  
  set_multicycle_path -hold  1 -end   \
      -from [tessent_get_cells [list  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?3?]] \
      -to   [tessent_get_cells  [dict get $mbist_info mbist1_m1 inst]/MBISTPG_STATUS/GO_ID_REG*]  
  
  set_disable_timing  [tessent_get_pins [dict get $mbist_info mbist1_m1 inst]/tessent_persistent_cell_BIST_CLK_OR_TCK/s] 
  # Stop TCK propagation on functional path.
  set tck_injection_pins [tessent_get_pins {tessent_persistent_cell_tck_mux_*/b} -hierarchical -silent]
  if {[sizeof_collection $tck_injection_pins] > 0} {
    set_disable_timing $tck_injection_pins
  }
  
}
proc tessent_set_memory_bist_modal {} {  
  
  global mbist_info tessent_clock_mapping tessent_apply_mbist_mux_constraints tessent_mbist_create_bap_tck_generated_clock tessent_tck_clocks_list tessent_tck_clocks_group_created 
  
  # Functional top level pins aren't used here.
  set_false_path -from [remove_from_collection [all_inputs] [tessent_get_ports [list BIST_CLK ijtag_ce ijtag_se ijtag_si ijtag_tck ijtag_ue]] ] 
  set_false_path -to [remove_from_collection [all_outputs] [tessent_get_ports [list ijtag_so]] ] 
    set bap1_interfaces_tck_name bap1_interfaces_tck
    set bap1_tck_name bap1_tck
  if {$tessent_mbist_create_bap_tck_generated_clock} {
    create_generated_clock [tessent_get_pins [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BUF_C_TCK/y]  \
      -name $bap1_tck_name \
      -source [tessent_get_ports [list {ijtag_tck}]]  \
      -add -master_clock $tessent_clock_mapping(tessent_tck) \
      -divide_by 1 \
      -combinational
    create_generated_clock [tessent_get_pins [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BUF_I_TCK/y]  \
      -name $bap1_interfaces_tck_name \
      -source [tessent_get_ports [list {ijtag_tck}]]  \
      -add -master_clock $tessent_clock_mapping(tessent_tck) \
      -divide_by 1 \
      -combinational
    set bap1_tck_clocks [tessent_get_clocks [list $bap1_interfaces_tck_name $bap1_tck_name]]
    # Update the TCK asynchronous clock group
    set tessent_clock_mapping(bap1_tck) bap1_tck
    lappend tessent_tck_clocks_list bap1_tck
    set tessent_clock_mapping(bap1_interfaces_tck) bap1_interfaces_tck
    lappend tessent_tck_clocks_list bap1_interfaces_tck
    set mapped_tck_clock_list [list]
    foreach tck_clock $tessent_tck_clocks_list {
      lappend mapped_tck_clock_list $tessent_clock_mapping($tck_clock)
    }
    tessent_remove_clock_groups -asynchronous tessent_tck_clock_group
    set_clock_groups -asynchronous -name tessent_tck_clock_group -group [tessent_get_clocks $mapped_tck_clock_list]
    set tessent_tck_clocks_group_created 1
    # TCK from the BAP must only constrain the shift path, block false same-edge paths, they are constrained with functional clock
    set_false_path -rise_from [tessent_get_clocks $bap1_tck_name] -rise_to [tessent_get_clocks $bap1_interfaces_tck_name]
    set_false_path -rise_from [tessent_get_clocks $bap1_interfaces_tck_name] -rise_to [tessent_get_clocks $bap1_tck_name]
    set_false_path -fall_from [tessent_get_clocks $bap1_tck_name] -fall_to [tessent_get_clocks $bap1_interfaces_tck_name]
    set_false_path -fall_from [tessent_get_clocks $bap1_interfaces_tck_name] -fall_to [tessent_get_clocks $bap1_tck_name]
  } else {
    set bap1_tck_clocks [tessent_get_clocks $tessent_clock_mapping(tessent_tck)]
  }
  
  # BIST_EN, BIST_HOLD are MCP by protocol
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_bistEn_0/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_HOLD/y]] 
  set_multicycle_path -hold 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_bistEn_0/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_HOLD/y]] 
  # TDR bits are MCP by protocol to controller
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_2_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ASYNC_RESET/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_TCK_MODE/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_ENABLE_MEM_RESET_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_REDUCED_ADDRESS_COUNT_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SELECT_TEST_DATA_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ALGO_MODE0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ALGO_MODE1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_DIAG_EN_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_FL_CNT_MODE0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_FL_CNT_MODE1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_INCLUDE_MEM_RESULTS_REG_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_CHAIN_BYPASS_EN_buf/y]] 
  set_multicycle_path -hold 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_2_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SETUP_0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ASYNC_RESET/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_TCK_MODE/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_ENABLE_MEM_RESET_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_REDUCED_ADDRESS_COUNT_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_SELECT_TEST_DATA_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ALGO_MODE0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ALGO_MODE1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_DIAG_EN_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_FL_CNT_MODE0_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_FL_CNT_MODE1_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_INCLUDE_MEM_RESULTS_REG_buf/y \
          [dict get $mbist_info bap1 inst]/tessent_persistent_cell_CHAIN_BYPASS_EN_buf/y]] 
  # Enable all controllers.
  set_case_analysis 1 [tessent_get_pins [dict get $mbist_info bap1 inst]/tessent_persistent_cell_bistEn_0/y] 
  # Turn memory_bist asynchronous reset OFF.
  set_case_analysis 1 [tessent_get_pins [dict get $mbist_info bap1 inst]/tessent_persistent_cell_BIST_ASYNC_RESET/y] 
  
  set bap1_go_buffers_l [list]
  lappend bap1_go_buffers_l [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_MBISTPG_GO/y
  set bap1_done_buffers_l [list]
  lappend bap1_done_buffers_l [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_MBISTPG_DONE/y
  
  # Same edge (p->p) timing paths through these controller buffers are false path by protocol
  set_false_path -rise_from $bap1_tck_clocks -rise_to [tessent_get_clocks $tessent_clock_mapping(tessent_tck)]\
         -through [tessent_get_pins [concat $bap1_go_buffers_l $bap1_done_buffers_l]]
  # Opposite edge (n->p) timing paths through these controller buffers are MCP 2 by protocol
  set_multicycle_path 2 -setup -fall_from [tessent_get_clocks $tessent_clock_mapping(tessent_tck)] -rise_to [tessent_get_clocks $tessent_clock_mapping(tessent_tck)]\
         -through [tessent_get_pins [concat $bap1_go_buffers_l]]
  set_multicycle_path 1 -hold  -fall_from [tessent_get_clocks $tessent_clock_mapping(tessent_tck)] -rise_to [tessent_get_clocks $tessent_clock_mapping(tessent_tck)]\
         -through [tessent_get_pins [concat $bap1_go_buffers_l]]
  
  ## Constraints for memory_bist controller 'mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst'
  
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MICROCODE_EN_REG*] 
  set_multicycle_path -setup 3 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/DIAG_EN_R*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MEM_SELECT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_RUN/y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_RUN/y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?5? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?4? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?2? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?1? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?0?]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?11? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?10? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?9? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?8? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?7? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?6?]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?5? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?4? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?2? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?1? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?0?]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?11? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?10? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?9? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?8? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?7? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/ERROR_CNT_REG_reg?6?]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?5? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?4? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?2? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?1? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?0?]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?11? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?10? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?9? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?8? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?7? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?6?]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?5? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?4? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?2? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?1? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?0?]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?11? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?10? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?9? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?8? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?7? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_CTL_COMP/FL_CNT_REG_reg?6?]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/JCNT* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_X1_MINMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_Y1_MINMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_LOOPCOUNTMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER3/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER4/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER5/y]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?3? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/JCNT* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_X1_MINMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_Y1_MINMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_LOOPCOUNTMAX_TRIGGER/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER3/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER4/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER5/y]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE**] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/EDATA_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/WDATA_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE**] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/EDATA_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/WDATA_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] \
      -through [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_clocks $tessent_clock_mapping(BIST_CLK)] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells [dict get $mbist_info mbist1 inst]/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_3/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_4/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_5/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_6/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_7/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_8/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_3/y]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_3/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_4/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_5/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_6/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_7/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_8/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_0/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_1/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_2/y \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_3/y]] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT_REG1* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT_REG1* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -through [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_INH_LAST_ADDR_CNT/y] \
      -to [tessent_get_cells [concat  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/BIST_EN_RETIME2*] \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_ON/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_AND_DEFAULT_MODE/y]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1 inst]/BIST_EN_RETIME2*] \
      -through [tessent_get_pins [concat  \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_ON/y \
          [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_AND_DEFAULT_MODE/y]] 
  set_disable_timing  [tessent_get_pins [dict get $mbist_info mbist1 inst]/tessent_persistent_cell_BIST_CLK_INT/s] 
  
  ## Constraints for memory_bist interface 'mem_container_inst/m1_mem_inst_interface_inst'
  ##   of controller 'mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst'
  
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [dict get $mbist_info mbist1_m1 inst]/BIST_INPUT_SELECT*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1_m1 inst]/tessent_persistent_cell_BIST_INPUT_SELECT_INT/y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [dict get $mbist_info mbist1_m1 inst]/BIST_INPUT_SELECT*] \
      -through [tessent_get_pins [dict get $mbist_info mbist1_m1 inst]/tessent_persistent_cell_BIST_INPUT_SELECT_INT/y] 
  set_multicycle_path -setup 2 -start \
      -from [tessent_get_cells [list [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT**]] \
      -to   [tessent_get_cells [dict get $mbist_info mbist1_m1 inst]/A_DOUT_SCAN_IN*]  
  set_multicycle_path -hold  1 -end \
      -from [tessent_get_cells [list [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT**]] \
      -to   [tessent_get_cells [dict get $mbist_info mbist1_m1 inst]/A_DOUT_SCAN_IN*]  
  
  set_multicycle_path -setup 2 -start \
      -from [tessent_get_cells [list  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?3?]] \
      -to   [tessent_get_cells  [dict get $mbist_info mbist1_m1 inst]/MBISTPG_STATUS/GO_ID_REG*]  
  set_multicycle_path -hold  1 -end   \
      -from [tessent_get_cells [list  \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT** \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BX_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/AY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_ADD_GEN/BY_ADD_REG* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          [dict get $mbist_info mbist1 inst]/MBISTPG_FSM/RUNTEST_EN_REG_reg?3?]] \
      -to   [tessent_get_cells  [dict get $mbist_info mbist1_m1 inst]/MBISTPG_STATUS/GO_ID_REG*]  
  
  set_disable_timing  [tessent_get_pins [dict get $mbist_info mbist1_m1 inst]/tessent_persistent_cell_BIST_CLK_OR_TCK/s] 
  
}
proc tessent_get_cells {path_list args} {
  set actualArgs [list]
  set silent 0
  set warning_list [list]
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    if { $argValue eq "-silent" } { set silent 1; continue }
    lappend actualArgs $argValue
  }
  # Quietly try verilog syntax first. If not found, try VHDL remapping
  set cell_col {}
  foreach path $path_list {
    set cell_col_tmp [get_cells [list [tessent_map_to_verilog $path]] {*}$actualArgs -quiet]
    if { [sizeof_collection $cell_col_tmp] == 0 && [regexp {%TSSEP%} $path]} {
      # try a partially ungrouped path with known markers
      set cell_col_tmp [get_cells [list [tessent_map_to_verilog $path -mappings [list {%TSSEP%} {?}]]] {*}$actualArgs -quiet]
    } 
    if { [sizeof_collection $cell_col_tmp] == 0 } {
      set cell_col_tmp [get_cells [tessent_map_to_verilog [tessent_remap_vhdl_path_list [list $path]]] {*}$actualArgs -quiet]
    } 
    if {[sizeof_collection $cell_col_tmp] > 0} {
      append_to_collection cell_col $cell_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC warning: Cell was not found with pattern '${path}'"
    }
  }
  if {[sizeof_collection $cell_col] > 0} {
    if {[llength $warning_list] > 0 && !$silent} {
      puts [join $warning_list "\n"]
    }
    return $cell_col
  } elseif {!$silent} {
    puts "Tessent SDC error: No cell found with pattern(s) '${path_list}'"
  }
  return
 
}
proc tessent_get_flops {path_list args} {
  global tessent_timing_tool
  set cell_col [tessent_get_cells $path_list {*}$args]
  
  if {[sizeof_collection $cell_col] == 0} {return {}}

  switch -- $tessent_timing_tool {
    encounter {set flop_col [filter sequential true $cell_col]}
    default   {set flop_col [filter_collection $cell_col "is_sequential == true"]}
  }

  return $flop_col
 
}
proc tessent_get_pins {path_list args} {
  global tessent_timing_tool
  set pin_col {}
  set actualArgs [list]
  set silent 0
  set hierarchical ""
  set warning_list [list]
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    if { $argValue eq "-silent" } { set silent 1; continue }
    if { [regexp {^-hier(archical)?$} $argValue] } { set hierarchical "-hierarchical"; continue }
    lappend actualArgs $argValue
  }
  switch -- $tessent_timing_tool {
    pt_shell {set pin_name_attribute "lib_pin_name"}
    default  {set pin_name_attribute "name"}
  }
  foreach path $path_list {
    set pin_sep_index [string last / $path]
    set mapped_cells [tessent_get_cells [list [string range $path 0 [expr $pin_sep_index - 1]]] -silent {*}$hierarchical]
    if {[sizeof_collection $mapped_cells] > 0} {
      set pin_col_tmp [get_pins -of_objects $mapped_cells -filter "$pin_name_attribute =~ [string range $path [expr $pin_sep_index + 1] end]" {*}$actualArgs -quiet]
    } else {
      set pin_col_tmp {}
    }
    if {[sizeof_collection $pin_col_tmp] > 0} {
      append_to_collection pin_col $pin_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC warning: Pin was not found with pattern '${path}'"
    }
  }
  if {[sizeof_collection $pin_col] > 0} {
    if {[llength $warning_list] > 0 && !$silent} {
      puts [join $warning_list "\n"]
    }
    return $pin_col
  } elseif {!$silent} {
    puts "Tessent SDC error: No pin found with pattern(s) '${path_list}'"
  }
  return
   
}
proc tessent_get_ports {port_patterns args} {
  global tessent_timing_tool
  set actualArgs [list]
  set silent 0
  set warning_list [list]
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    if { $argValue eq "-silent" } { set silent 1; continue }
    lappend actualArgs $argValue
  }
  # Quietly try verilog syntax first. If not found, try advanced remapping
  set port_col {}
  foreach port_pattern $port_patterns {
    set port_col_tmp [get_ports [list [tessent_map_to_verilog $port_pattern]] {*}$actualArgs -quiet]
    if { [sizeof_collection $port_col_tmp] == 0 } {
      set port_col_tmp [get_ports [tessent_map_to_verilog [tessent_remap_vhdl_path_list [list $port_pattern] -type ports]] {*}$actualArgs -quiet]
    } 
    if {[sizeof_collection $port_col_tmp] > 0} {
      append_to_collection port_col $port_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC warning: Port was not found with pattern '${port_pattern}'"
    }
  }
  set sc [sizeof_collection $port_col]
  if {$sc > 0} {
    if {[llength $warning_list] > 0 && !$silent} {
      puts [join $warning_list "\n"]
    }
    if {$sc == 1 && $tessent_timing_tool eq "oasys"} {
      return [index_collection $port_col 0]
    } else {
      return $port_col
    }
  } elseif {!$silent} {
    puts "Tessent SDC error: No port found with pattern(s) '${port_patterns}'"
  }
  return
  
}
proc tessent_map_to_verilog {path_list args} {
  global tessent_hierarchy_separator tessent_custom_mapping_regsub

  set ARGS(-mappings) [list]
  array set ARGS $args

  set mapped_paths $path_list
  if {[array size tessent_custom_mapping_regsub] > 0} {
    foreach custom_re [array names tessent_custom_mapping_regsub] {
      set mapped_paths [regsub -all $custom_re $mapped_paths $tessent_custom_mapping_regsub($custom_re)]
    }
  }
  array set map_array {
    [ ?
    ] ?
    ) ?
    ( ?
    . ?
    - ?
  }
  set map_array(%TSSEP%) $tessent_hierarchy_separator
  if {$tessent_hierarchy_separator ne "/"} {
    set map_array(/) $tessent_hierarchy_separator
  }
  if {[string is list $ARGS(-mappings)]} {
    array set map_array $ARGS(-mappings)
  }
  set mapped_paths [string map [array get map_array] $mapped_paths]
  return $mapped_paths
  
}
proc tessent_remap_vhdl_path_list {path_list args} {
  global tessent_path_cache
  set remapped_path_list [list]
  array set ARGS {
    -type cells
  }
  array set ARGS $args
  set type $ARGS(-type)
  set get_cmd "get_${type}"
  foreach path $path_list {
    # Check if we have that full path cached
    if {[info exists tessent_path_cache($path)]} {
      set pathMapped $tessent_path_cache($path)
    } else {
      set pathMapped ""
      set pathUnmapped ""
      foreach sub_path [split $path "/"] {
        if {$pathUnmapped eq ""} {
          set slash ""
        } else {
          set slash "/"
        }
        append pathUnmapped $slash $sub_path
        # Problematic paths are the following:
        #   - Paths with unrolled VHDL generate loops
        #   - non-standard change names that would trim the trailing underscore of multi-bit register names
        #   - Complex ports in some timing tools

        # Check if we have that hiercarchy cached
        if {[info exists tessent_path_cache($pathUnmapped)]} {
          set pathMapped $tessent_path_cache($pathUnmapped)
          continue
        }
        append pathMapped $slash $sub_path
        # If for port, go straight into Complex ports mapping
        if {$type eq "ports"} {
          # Some timing tools address complex identifiers like Tessent Shell: <id>.<id> 
          # Some other timing tools address those same complex construct like this <id>[<id>]
          # Try to exclude indexes from identifier as is bus was intact
          #     i.s. <id>.<id>[n] -> <id>[id][n]
          set pathMappedTemp [regsub -all {\.([^\.\[]+)} $pathMapped {[\1]}]
          if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
            set pathMapped $pathMappedTemp
            set tessent_path_cache($pathUnmapped) $pathMapped
            continue
          }
          # Try to include indexes as part of a full "escaped" identifier 
          #     i.e. <id>.<id>[n] -> <id>[<id>[n]]
          set pathMappedTemp [regsub -all {\.([^\.]+)} $pathMapped {[\1]}]
          if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
            set pathMapped $pathMappedTemp
            set tessent_path_cache($pathUnmapped) $pathMapped
            continue
          }
          # rest of the mappings are for cells
          continue
        }
        # Try verilog first on this hierarchy
        if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMapped]]] > 0} {
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        }
        # Unrolled VHDL loop from HDLE - closing bracket of a generate loop identifier was removed
        set pathMappedTemp [regsub {[\])]\.} $pathMapped {.}]
        if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
          set pathMapped $pathMappedTemp
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        }
        # Identifier that would simply have had its last character trimmed
        #   This would be an underscore, adding '?' to support some pre-mapped paths in constraints
        set pathMappedTemp [regsub {[\]\?]$} $pathMapped {}]
        if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
          set pathMapped $pathMappedTemp
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        }
      }
    }
    lappend remapped_path_list $pathMapped 
  }
  return $remapped_path_list

}
proc tessent_remove_clock_groups {group_type group_name_list} {
  global tessent_timing_tool tessent_tck_clocks_group_created
  if {!$tessent_tck_clocks_group_created} {return}
  switch -- $tessent_timing_tool {
    dc_shell  {remove_clock_groups $group_type $group_name_list; set tessent_tck_clocks_group_created 0}
    pt_shell  {remove_clock_groups $group_type -name $group_name_list; set tessent_tck_clocks_group_created 0}
    encounter {#remove_clock_groups command does not exist}
    genus     {#remove_clock_groups command does not exist}
    default   {#do not assume remove_clock_groups exists}
  }
 
}
proc tessent_get_clock_source {clk} {
  global tessent_timing_tool
  set clockSource0 ""
  switch -- $tessent_timing_tool {
    encounter {set clockSource0 [lindex [get_attribute sources [tessent_get_clocks $clk]] 0]}
    genus     {set clockSource0 [lindex [get_db [tessent_get_clocks $clk] .sources] 0]}
    default   {set clockSource0 [index_collection [get_attribute [tessent_get_clocks $clk] sources] 0]}
  }
  return $clockSource0
 
}
proc tessent_set_clock_sense_stop_propagation {clk pin cell} {
  global tessent_timing_tool
  if {$tessent_timing_tool in {genus encounter} || ![get_attribute $cell is_hierarchical]} {
    set target $pin
  } else {
    set target ""
    foreach_in_collection ipin [tessent_get_pins [get_attribute $cell full_name]/*/*] {
      if {[get_attribute $ipin direction] eq "in" && [get_attribute [all_connected $ipin] full_name] eq [get_attribute $pin full_name]} {
        append_to_collection target $ipin
      }
    }
    if {[sizeof_collection $target] > 0} {
      puts "Tessent SDC note: Hierarchical pin '[get_attribute $pin full_name]' maps to libcell pin(s) [join [get_attribute $target full_name] ,]."
    } else {
      puts "Tessent SDC error: Failed to map hierarchical pin '[get_attribute $pin full_name]' to libcell pin."
      return
    }
  }
  if {$tessent_timing_tool eq "pt_shell"} {
    set_sense -type clock -clocks $clk -stop_propagation $target
  } else {
    set_clock_sense -clocks $clk -stop_propagation $target
  }
 
}
proc tessent_kill_functional_paths {{verbose OFF}} {

  global ClockSeqCellModuleRegExp ClockSeqCellInstanceRegExp
  global CreateDisabledFlopsReport
  global tessent_test_inst_regexp
  global tessent_clock_mapping tessent_unmapped_functional_clocks
  set funcFlops {}
  set mapped_functional_clocks [list]
  foreach clk $tessent_unmapped_functional_clocks {
    lappend mapped_functional_clocks $tessent_clock_mapping($clk)
  }
  if {[llength $mapped_functional_clocks] == 0} {return}
  foreach_in_collection clk [tessent_get_clocks $mapped_functional_clocks] {
      set funcFlops [add_to_collection $funcFlops [all_registers -clock $clk]]
  }
  
  set funcFlops [filter_collection $funcFlops -regexp full_name!~"$tessent_test_inst_regexp"]
  
  # Exclude memory cell instances and their collar flops
  
  set funcFlops [remove_from_collection $funcFlops [ list  \
    [tessent_get_mem_cells {mem_container_inst/m1_mem_inst}] ]]

  if {[sizeof_collection $funcFlops] > 0} {
    puts "\n##################### Disabling timing to all functional registers #############################"

    set use_set_disable_timing 0
 
    # Exclude clock gating sequential cells by their module name, if needed
    if [info exists ClockSeqCellModuleRegExp] {
      set excludeRegExp "ref_name=~\"${ClockSeqCellModuleRegExp}\""
      set CScells [filter_collection $funcFlops -regexp $excludeRegExp]
      puts "\nExcluding sequential clock cells instances: "
      foreach_in_collection flop $CScells {
         set flopName [get_attribute $flop full_name]
         puts "     $flopName"
      }
      set funcFlops [remove_from_collection $funcFlops $CScells]
      set use_set_disable_timing 1
    }
 
    # Exclude clock gating sequential cells by their instance name, if needed
    if [info exists ClockSeqCellInstanceRegExp] {
      set excludeRegExp "full_name=~\"${ClockSeqCellInstanceRegExp}\""
      set ClockCells [filter_collection $funcFlops -regexp $excludeRegExp]
      puts "\nExcluding instances: "
      foreach_in_collection flop $ClockCells {
         set flopName [get_attribute $flop full_name]
         puts "     $flopName"
      }
      set funcFlops [remove_from_collection $funcFlops $ClockCells]
      set use_set_disable_timing 1
    }
 
    # Disable all flops in $funcFlops
    set funcFlops [sort_collection $funcFlops full_name]
    if {$use_set_disable_timing} {
        puts "Disabling functional registers with a set_disable_timing command:"
    } else {
        puts "Disabling functional registers with a set_false_path -to command:"
    }
    foreach_in_collection flop $funcFlops {
        set flopName [get_attribute $flop full_name]
        if {$verbose == "ON"} {
            puts "Disabling register: $flopName"
        }
        if {$use_set_disable_timing} {
            set_disable_timing [tessent_get_pins $flopName/*]
        } else {
            set_false_path -to [tessent_get_cells $flopName]
        }
    }
 

    # Create report file
    if {[info exists CreateDisabledFlopsReport]} {
        puts "\ntessent_kill_functional_paths: Creating report file \"DisabledFunctionalFlops.report\". \n"
        redirect DisabledFunctionalFlops.report {
            foreach_in_collection flop $funcFlops {
                set flopName [get_attribute $flop full_name]
                puts "$flopName"
            }
        }
    }
 
  }
  
}
proc tessent_get_mem_cells {inpath} {
  set out_cells [tessent_get_cells $inpath]
  foreach_in_collection cell $out_cells {
    if {[get_attribute $cell is_hierarchical] eq "true"} {
      set cell_path [get_attribute $cell full_name]
      if {[sizeof_collection [get_cells -quiet "$cell_path/*"]]>0} {
        set out_cells [add_to_collection $out_cells [tessent_get_mem_cells "$cell_path/*"]]
      }
    }
  }
  return [filter_collection $out_cells "is_sequential==true"]
  
}
proc tessent_get_clocks {patternList args} {
  # Genus does not support more than one <pattern> for 'get_clocks <pattern>'
  set C {}
  foreach p $patternList {
    append_to_collection C [get_clocks $p {*}$args] -unique
  }
  return $C
 
}
proc tessent_get_preserve_instances {select} {
  # The 'select' argument identifies a list of instances to be returned.
  # The instances must be preserved in the post-synthesis netlist in order to perform further actions on it:
  #   add_core_instances
  #   scan_insertion       superset of 'add_core_instances' list
  #   icl_extract          superset of 'scan_insertion' list

  set persistent_design_instance_glob_list {
    tessent_persistent_cell_*
  }

  set scan_instrument_instance_list {
  }

  set scan_related_instance_list {
    memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst
  }

  set tcd_scan_instance_list {
  }

  set non_scan_instance_list {
    mem_container_inst/m1_mem_inst
  }

  set icl_design_instance_list {
    mem_container_inst/m1_mem_inst_interface_inst
    mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst
    memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst
    memlibc_memory_bist_assembly_rtl_tessent_sib_mbist_inst
  }

  set keyList [list add_core_instances scan_insertion icl_extract]
  set concatDict {
    add_core_instances { persistent_design_instance_glob_list scan_instrument_instance_list scan_related_instance_list }
    scan_insertion     { tcd_scan_instance_list non_scan_instance_list }
    icl_extract        { icl_design_instance_list }
  }
  set instanceColl {}
  # Nothing to return when 'select' is unknown
  if { [lsearch -exact $keyList $select] < 0 } {
    return $instanceColl
  }
  # Assemble a superset list depending on the 'select' value
  # based on the list of list of variables names to concatenate
  # for each 'select' value.
  foreach {validSelect concatVarnameList} $concatDict {
    foreach concatVarname $concatVarnameList {
      set getCellsArg [expr {[string match *_glob_list $concatVarname] ? "-hierarchical" : ""}]
      foreach instancePattern [set $concatVarname] {
        append_to_collection instanceColl [tessent_get_cells $instancePattern -filter {is_hierarchical==true} $getCellsArg -silent] -unique
      }
    }
    if { $select eq $validSelect } {
      break
    }
  }
  return $instanceColl

}
proc tessent_get_size_only_instances {} {
  set persistent_cell_instance_glob_list {
    tessent_persistent_cell_*
  }

  set instanceColl {}
  foreach instancePattern $persistent_cell_instance_glob_list {
    append_to_collection instanceColl [get_cells $instancePattern -filter {is_hierarchical==false} -hierarchical -quiet] -unique
  }

  # Preserve MemoryBist scan observation logic in memory interfaces
  global mbist_info
  set mbist_interf_ids [lsearch -regexp -all -inline [dict keys $mbist_info] {^mbist[0-9]+_m[0-9]+$}]
  foreach mbist_interf_id $mbist_interf_ids {
    append_to_collection instanceColl [tessent_get_flops [list "[dict get $mbist_info $mbist_interf_id inst]/*SCAN_OBS_FLOPS*" "[dict get $mbist_info $mbist_interf_id inst]/*_SCAN_IN*"] -silent] -unique
  }

  return $instanceColl
}
proc tessent_get_optimize_instances {} {
  set optimize_instance_list {
    mem_container_inst/m1_mem_inst_interface_inst/MBISTPG_STATUS
    mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst/MBISTPG_ADD_FORMAT
    mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst/MBISTPG_ADD_GEN
    mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst/MBISTPG_CTL_COMP
    mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst/MBISTPG_DATA_GEN
    mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst/MBISTPG_FSM
    mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst/MBISTPG_POINTER_CNTRL
    mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst/MBISTPG_REPEAT_LOOP_CNTRL
    mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst/MBISTPG_SIGNAL_GEN
    memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_controller_sib_ctl_bypass_inst
    memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_controller_sib_inst0
    memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_controller_sib_tdr_bypass_inst
    memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst/tdr_inst
  }

  set instanceColl {}
  foreach instancePattern $optimize_instance_list {
    append_to_collection instanceColl [tessent_get_cells $instancePattern -silent]
  }
  return $instanceColl

}

# Provide pre-2021.2 tessent-shell plugin proc mapping to 2021.3 convention, 
# so as to maintain backward-compatibility with older customer scripts.
set tessent_old_2_new_proc_name_mapping {
  {tessent_constrain_memlibc_memory_bist_assembly_non_modal tessent_set_non_modal no}
  {tessent_constrain_memlibc_memory_bist_assembly_mentor_memory_bist_non_modal tessent_set_memory_bist_non_modal no}
  {tessent_constrain_memlibc_memory_bist_assembly_mentor_ijtag_non_modal tessent_set_ijtag_non_modal no}
  {tessent_constrain_memlibc_memory_bist_assembly_mentor_memory_bist_modal tessent_set_memory_bist_modal no}
}
foreach line $tessent_old_2_new_proc_name_mapping {
  lassign $line old_proc_name new_proc_name arguments
  if {$arguments eq "yes"} {
    proc $old_proc_name args "$new_proc_name {*}\$args"
  } else {
    proc $old_proc_name {} $new_proc_name
  }
}
    
