#-----------------------------------------------------------
# This file created by : memlibCertify
#     Software version : 2022.3
#           Created on : 11/15/25 20:34:17
#-----------------------------------------------------------

# --
# -- Patterns 
# --
set_context patterns -ijtag
set design_name memlibc_memory_bist_assembly
set patterns_spec_file_path  [get_tsdb_output_directory]/patterns/${design_name}_rtl.patterns_spec_signoff
if { ! [get_resource icl_is_elaborated] } {
  read_design ${design_name} -design_id rtl -no_hdl
  set_current_design ${design_name}
}
if { [file exists ${patterns_spec_file_path}] } {
  puts "## Reading PatternsSpecification from '${patterns_spec_file_path}'"
  read_config_data ${patterns_spec_file_path}
  set patterns_spec [get_config_elements PatternsSpecification]
} else {
  set patterns_spec [create_patterns_specification -replace]
  set_config_value [get_config_elements -in $patterns_spec Patterns/TestStep/MemoryBist/reduced_address_count] off
  # Add TestStep for custom algorithms {{{
  set target_ts [get_config_elements {Patterns(MemoryBist_P[0-9]+)} -in $patterns_spec -regexp]
  foreach_in_collection tcd_controller [get_config_elements Core/MemoryBistController -partition tcd] {
    set algo_list [list]
    set opset_list [list]
    set controller_name [get_config_value -id core_name [get_config_value $tcd_controller -parent_object]]
    foreach_in_collection algo_obj [get_config_elements Algorithm -in $tcd_controller] {
      lappend algo_list [get_config_value -id algorithm_name $algo_obj]
    }
    foreach_in_collection opset_obj [get_config_elements OperationSet -in $tcd_controller] {
      lappend opset_list [get_config_value -id name $opset_obj]
    }
    set default_opset [get_config_value StepCounter(0)/DefaultOperationSet -in $tcd_controller]
    foreach_in_collection ctl_inst [get_icl_instances -of_module [get_icl_module $controller_name]] {
      set ts [add_config_element TestStep(algo[incr algo_cnt]) -in $target_ts]
      set mbist_w [add_config_element MemoryBist -in $ts]
      set ctl_w [add_config_element Controller([get_single_name $ctl_inst]) -in $mbist_w]
      set_config_value run_mode -in $mbist_w run_time_prog;
      set_config_comment [get_config_value AdvancedOptions/apply_algorithm -in $ctl_w -object] "Available algorithms : [join $algo_list ,]"
      set_config_value AdvancedOptions/apply_algorithm -in $ctl_w [lindex $algo_list 0]
      set_config_comment [get_config_value AdvancedOptions/apply_operation_set -in $ctl_w -object] "Available operation sets: [join $opset_list ,]"
      set_config_value AdvancedOptions/apply_operation_set -in $ctl_w $default_opset
      set_config_value AdvancedOptions/freeze_step -in $ctl_w off
    }
  }
  # }}}
}
report_config_data $patterns_spec
process_patterns_specification
exit
