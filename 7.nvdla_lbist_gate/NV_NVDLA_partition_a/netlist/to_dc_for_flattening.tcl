define_design_lib work -path work
set MODULE NV_NVDLA_partition_a

read_verilog -netlist ../tsdb_outdir/dft_inserted_designs/${MODULE}_gate3.dft_inserted_design/${MODULE}.vg

current_design ${MODULE}

read_sdc ../../nv_small/nvdla/cons/${MODULE}.sdc
source ../tsdb_outdir/dft_inserted_designs/${MODULE}_gate2.dft_inserted_design/${MODULE}.sdc
tessent_set_default_variables
tessent_set_ltest_disable all_test_on

set_case_analysis 0 [get_ports test_mode]
set_case_analysis 0 [get_ports scan_enable]
set_case_analysis 0 [get_ports edt_update]
set_case_analysis 0 [get_ports test_clock]

set_wire_load_model  -name "50k"
set_wire_load_mode   top

## To flatten
set_dont_touch [get_cells tessent_persistent_* -hier -filter "is_hierarchical==true"]
set_size_only [get_cells tessent_persistent_* -hier -filter "is_hierarchical==false"]
## This needs a compile, this is what layout tools use
##set_flatten true
ungroup -all 
#compile

check_design

set syn_report_max_paths               50
set syn_report_nworst                  5
set syn_report_simple                  0
set path_graph_max_paths 10000
set syn_report_flags   "-input_pins -nets"
set timing_flags [concat -nosplit -nworst $syn_report_nworst -max_paths $syn_report_max_paths -significant_digits 4 -attribute]
set module_report ./logfiles/${MODULE}.report
suppress_message [list "TIM-175"]
redirect $module_report { report_qor -significant_digits 4 }
unsuppress_message [list "TIM-175"]
redirect -append $module_report { eval { report_timing } $timing_flags }
## Write the flatenned netlist out
write -f verilog -hierarchy -output ${MODULE}.vg

exit
