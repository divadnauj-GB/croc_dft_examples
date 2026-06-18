set_app_var hdlin_enable_upf_compatible_naming true
set_app_var hdlin_mux_size_only 2

# From in-memory design source dictionary

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/dft_inserted_designs/NV_NVDLA_partition_o_gate3.dft_inserted_design/NV_NVDLA_partition_o.vg_graybox" \
   } 

 
