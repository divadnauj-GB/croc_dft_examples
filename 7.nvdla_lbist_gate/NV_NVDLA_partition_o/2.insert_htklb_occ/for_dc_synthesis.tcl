set_app_var hdlin_enable_upf_compatible_naming true
set_app_var hdlin_mux_size_only 2

# From in-memory design source dictionary

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_cells.instrument/NV_NVDLA_partition_o_gate2_tessent_posedge_synchronizer_reset.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_ijtag.instrument/NV_NVDLA_partition_o_gate2_tessent_sib_lbist.v" \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_ijtag.instrument/NV_NVDLA_partition_o_gate2_tessent_sib_edt.v" \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_ijtag.instrument/NV_NVDLA_partition_o_gate2_tessent_sib_occ.v" \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_ijtag.instrument/NV_NVDLA_partition_o_gate2_tessent_sib_sri_ctrl.v" \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_ijtag.instrument/NV_NVDLA_partition_o_gate2_tessent_tdr_sri_ctrl.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_occ.instrument/NV_NVDLA_partition_o_gate2_tessent_occ_nvdla_core_clk.v" \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_occ.instrument/NV_NVDLA_partition_o_gate2_tessent_occ_nvdla_falcon_clk.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_edt_lbist.instrument/NV_NVDLA_partition_o_gate2_tessent_edt_lbist_c1.v" \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_edt_lbist.instrument/NV_NVDLA_partition_o_gate2_tessent_edt_lbist_c1_tdr.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_lbist_ncp_index_decoder.instrument/NV_NVDLA_partition_o_gate2_tessent_lbist_ncp_index_decoder.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_lbist.instrument/NV_NVDLA_partition_o_gate2_tessent_lbist.v" \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/instruments/NV_NVDLA_partition_o_gate2_lbist.instrument/NV_NVDLA_partition_o_gate2_tessent_single_chain_mode_logic.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/dft_examples/7.nvdla_lbist_gate/NV_NVDLA_partition_o/tsdb_outdir/dft_inserted_designs/NV_NVDLA_partition_o_gate2.dft_inserted_design/NV_NVDLA_partition_o.vg_no_instruments" \
   } 

 
