define_design_lib work -path work

set tessent_hierarchy_separator /
  # The instances must be preserved in the post-synthesis netlist in order to perform further actions on it:
  #   add_core_instances
  #   scan_insertion       superset of 'add_core_instances' list
  #   icl_extract          superset of 'scan_insertion' list
set preserve_type icl_extract

## Edit to cater to your design_name and design_id
set design_name croc_soc
set design_id rtl2

source ../2.insert_htklb_occ/for_dc_synthesis.tcl
read_verilog ../../../tech/tessent/memories/RM_IHPSG13_1P_256x64_c2_bm_bist.v_interface
set_dont_touch RM_IHPSG13_1P_256x64_c2_bm_bist

elaborate ${design_name}
link
check_design

#define functional clock 
create_clock -period 10.0 clk_i
create_clock -period 100.0 jtag_tck_i



## Reading in the sdc written out from the  insertion pass
source ../tsdb_outdir/dft_inserted_designs/${design_name}_${design_id}.dft_inserted_design/${design_name}.sdc
#source ../rtl/processor_core_design.sdc
#define tessent_lbist_shift_clock_src for lbist sdc 
set tessent_lbist_shift_clock_src(lbist_inst0) clk_i
tessent_set_default_variables
tessent_constrain_${design_name}_non_modal

## Do not perform boundary optimization on tessent_get_preserve_instances
set preserve_instances [tessent_get_preserve_instances ${preserve_type}]
set_boundary_optimization  $preserve_instances false
set_ungroup $preserve_instances false
# DC ultra only
# set_compile_directives $preserve_instances -delete_unloaded_gate false
# For DC Shell only
set compile_seqmap_enable_output_inversion true
set compile_seqmap_propagate_high_effort false
set compile_delete_unloaded_sequential_cells false


set optimize_instances [tessent_get_optimize_instances]
set_boundary_optimization $optimize_instances true
set size_only_instances [tessent_get_size_only_instances]
set_size_only -all_instances $size_only_instances


# compile -boundary_optimization -exact_map 
## Synthesize
compile 
remove_design RM_IHPSG13_1P_256x64_c2_bm_bist

## Write the synthesized netlist out
write -f verilog -hierarchy -output croc_soc_synthesized.vg

##
write_sdc croc_soc.sdc
exit

