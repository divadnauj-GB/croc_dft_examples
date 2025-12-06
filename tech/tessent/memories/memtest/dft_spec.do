#-----------------------------------------------------------
# This file created by : memlibCertify
#     Software version : 2022.3
#           Created on : 11/15/25 20:34:17
#-----------------------------------------------------------

# --
# -- Dft Insertion
# --
set bist_clk_period 10ns
set design_name memlibc_memory_bist_assembly
set_context dft -rtl
read_core_descriptions ../RM_IHPSG13_1P_64x64_c2_bm_bist.tcd_memory
read_verilog ../../../ihp-sg13g2/libs.ref/sg13g2_sram/t-verilog/RM_IHPSG13_1P_core_behavioral_bm_bist -exclude_from_file_dictionary
read_verilog ../../../ihp-sg13g2/libs.ref/sg13g2_sram/t-verilog/RM_IHPSG13_1P_64x64_c2_bm_bist -exclude_from_file_dictionary

set assembly_file_path  [get_tsdb_output_directory]/memory_bist_assemblies/${design_name}.[get_defaults_value DftSpecification/rtl_extension]
set dft_spec_file_path  [get_tsdb_output_directory]/dft_inserted_designs/${design_name}_rtl.dft_spec
if { [file exists $assembly_file_path] } {
  file delete $assembly_file_path
}
create_memory_certification_design -design_name $design_name -clock_period $bist_clk_period
set_dft_specification_requirements -memory_test on
check_design_rules
if { [file exists ${dft_spec_file_path}] } {
  puts "## Reading DftSpecification from '${dft_spec_file_path}'"
  read_config_data ${dft_spec_file_path}
  set dft_spec [get_config_elements DftSpecification]
} else {
  set dft_spec [create_dft_specification -replace]
#
# Including custom algorithms and operation sets in DftSpecification
#
  set extra_algorithm_list [list]
  foreach_in_collection algo [get_config_elements MemoryOperationsSpecification/Algorithm -silent] {
    lappend extra_algorithm_list [get_config_value $algo -id algorithm_name]
  }
  if { [llength $extra_algorithm_list] > 0 } {
    foreach_in_collection ctrl_algo [get_config_elements MemoryBist/Controller/AdvancedOptions/extra_algorithms -in $dft_spec] {
      set_config_value $ctrl_algo $extra_algorithm_list
    }
  }
  set extra_opset_list [list]
  foreach_in_collection opset [get_config_elements MemoryOperationsSpecification/OperationSet -silent] {
    lappend extra_opset_list [get_config_value $opset -id operation_set_name]
  }
  if { [llength $extra_opset_list] > 0 } {
    foreach_in_collection extra_opset [get_config_elements MemoryBist/Controller/AdvancedOptions/extra_operation_sets -in $dft_spec] {
      set_config_value $extra_opset $extra_opset_list
    }
  }
  # Annotate memory_library_name
  foreach_in_collection mi_obj [get_config_elements -in $dft_spec MemoryBist/Controller/Step/MemoryInterface] {
    set tcd_memory_name [get_attribute_value_list -name tcd_memory_name [get_instances [get_config_value instance_name -in $mi_obj]]]
    set_config_value memory_library_name -in $mi_obj $tcd_memory_name
  }
}

report_config_data $dft_spec

process_dft_specification
extract_icl
exit
