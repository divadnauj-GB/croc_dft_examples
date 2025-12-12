define_design_lib work -path work
set tessent_hierarchy_separator /
  # The instances must be preserved in the post-synthesis netlist in order to perform further actions on it:
  #   add_core_instances
  #   scan_insertion       superset of 'add_core_instances' list
  #   icl_extract          superset of 'scan_insertion' list
set preserve_type icl_extract

set design_name croc_chip 
set design_id rtl2


set tsdb ../tsdb_outdir

source ${design_name}.dc_shell_import_script
read_verilog ../../tech/tessent/memories/RM_IHPSG13_1P_256x64_c2_bm_bist.v_interface
set_dont_touch RM_IHPSG13_1P_256x64_c2_bm_bist

source ${tsdb}/dft_inserted_designs/${design_name}_${design_id}.dft_inserted_design/${design_name}.sdc
tessent_set_default_variables

set tessent_tck_period 200.0

elaborate ${design_name}
set_app_var timing_enable_multiple_clocks_per_reg true
set tessent_lbist_shift_clock_src(lbist_inst0) clk_i
create_clock clk_i -period 10 -name clk_i
tessent_create_functional_clocks
tessent_constrain_${design_name}_non_modal
set_app_var compile_enable_constant_propagation_with_no_boundary_opt false
set preserve_instances [tessent_get_preserve_instances ${preserve_type}]
set_boundary_optimization $preserve_instances false
set_ungroup $preserve_instances false

# source ../croc/rtl/croc_soc.sdc
set compile_seqmap_enable_output_inversion true
set compile_seqmap_propagate_high_effort true
set compile_delete_unloaded_sequential_cells false

set_boundary_optimization [tessent_get_optimize_instances] true
set_size_only -all_instances [tessent_get_size_only_instances]

link
check_design
compile  
remove_design RM_IHPSG13_1P_256x64_c2_bm_bist
write_sdc ${design_name}.merged_sdc
write -format verilog -output ${design_name}.vg ${design_name} -hier

report_area > mbist_tklbist_edt_area.rpt
report_power > mbist_tklbist_edt_power.rpt
report_timing >  mbist_tklbist_edt_timing.rpt

exit
