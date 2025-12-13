set_app_var hdlin_enable_upf_compatible_naming true
set_app_var hdlin_mux_size_only 2

# From file ../tsdb_outdir/dft_inserted_designs/croc_soc_rtl2.dft_inserted_design/croc_soc.design_source_dictionary

analyze -format sverilog -library work \
      -vcs [list  \
        +define+TARGET_ASIC \
        +define+TARGET_FLIST \
        +define+TARGET_IHP13 \
        +define+TARGET_RTL \
        +define+TARGET_SYNTHESIS \
        +define+VERILATOR=1 \
        +define+SYNTHESIS=1 \
        +define+COMMON_CELLS_ASSERTS_OFF=1 \
        +incdir+{/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb/include} \
        +incdir+{/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/include} \
        +incdir+{/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/include} \
        +incdir+{/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/include} \
        +incdir+{/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/register_interface/include} ] { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/binary_to_gray.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cb_filter_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cc_onehot.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cdc_reset_ctrlr_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cf_math_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/clk_int_div.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/credit_counter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/delta_counter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/ecc_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/edge_propagator_tx.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/exp_backoff.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/fifo_v3.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/gray_to_binary.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/isochronous_4phase_handshake.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/isochronous_spill_register.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/lfsr.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/lfsr_16bit.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/lfsr_8bit.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/lossy_valid_to_stream.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/mv_filter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/onehot_to_bin.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/plru_tree.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/passthrough_stream_fifo.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/popcount.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/rr_arb_tree.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/dft_inserted_designs/croc_soc_rtl2.dft_inserted_design/modified_rtl_files/croc/rtl/common_cells/rstgen_bypass.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/serial_deglitch.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/shift_reg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/shift_reg_gated.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/spill_register_flushable.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_demux.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_filter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_fork.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_intf.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_join_dynamic.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_mux.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_throttle.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/sub_per_hash.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/sync.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/sync_wedge.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/unread.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/read.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/addr_decode_dync.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cdc_2phase.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cdc_4phase.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/clk_int_div_static.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/addr_decode.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/addr_decode_napot.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/multiaddr_decode.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cb_filter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cdc_fifo_2phase.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/clk_mux_glitch_free.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/counter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/ecc_decode.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/ecc_encode.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/edge_detect.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/lzc.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/max_counter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/dft_inserted_designs/croc_soc_rtl2.dft_inserted_design/modified_rtl_files/croc/rtl/common_cells/rstgen.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/spill_register.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_delay.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_fifo.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_fork_dynamic.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_join.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cdc_reset_ctrlr.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cdc_fifo_gray.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/fall_through_register.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/id_queue.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_to_mem.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_arbiter_flushable.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_fifo_optimal_wrap.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_register.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_xbar.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cdc_fifo_gray_clearable.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/cdc_2phase_clearable.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/mem_to_banks_detailed.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_arbiter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/stream_omega_net.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/common_cells/mem_to_banks.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb/apb_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/register_interface/reg_intf.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/register_interface/lowrisc_opentitan/prim_subreg_arb.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/register_interface/lowrisc_opentitan/prim_subreg_ext.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/register_interface/periph_to_reg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/register_interface/reg_to_apb.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/register_interface/lowrisc_opentitan/prim_subreg_shadow.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/register_interface/lowrisc_opentitan/prim_subreg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/slib_clock_div.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/slib_counter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/slib_edge_detect.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/slib_fifo.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/slib_input_filter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/slib_input_sync.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/slib_mv_filter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/uart_baudgen.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/uart_interrupt.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/uart_receiver.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/uart_transmitter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/apb_uart.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/apb_uart_wrap.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/apb_uart/reg_uart_wrap.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_alu.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_compressed_decoder.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_controller.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_counter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_csr.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_decoder.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_fetch_fifo.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_load_store_unit.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_multdiv_fast.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_multdiv_slow.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_pmp.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_register_file_ff.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_wb.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_cs_registers.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_ex_block.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_id_stage.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_prefetch_buffer.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_if_stage.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/cve2/cve2_core.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/obi_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/obi_intf.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/obi_rready_converter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/obi_atop_resolver.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/obi_demux.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/obi_err_sbr.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/obi_mux.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/obi_sram_shim.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/obi/obi_xbar.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/dm_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/debug_rom/debug_rom.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/debug_rom/debug_rom_one_scratch.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/dm_csrs.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/dm_mem.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/dmi_cdc.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/dmi_jtag_tap.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/dm_sba.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/dm_top.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/dmi_jtag.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/riscv-dbg/dm_obi_top.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/timer_unit/timer_unit_counter.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/timer_unit/timer_unit_counter_presc.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/timer_unit/apb_timer_unit.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/timer_unit/timer_unit.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/ihp13/tc_clk.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/dft_inserted_designs/croc_soc_rtl1.dft_inserted_design/modified_rtl_files/ihp13/tc_sram_impl.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/croc_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/user_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/soc_ctrl/soc_ctrl_reg_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/gpio/gpio_reg_pkg.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/core_wrap.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/soc_ctrl/soc_ctrl_reg_top.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/gpio/gpio_reg_top.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/gpio/gpio.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/dft_inserted_designs/croc_soc_rtl1.dft_inserted_design/modified_rtl_files/rtl/croc_domain.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/user_domain.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/dft_inserted_designs/croc_soc_rtl2.dft_inserted_design/modified_rtl_files/croc_soc/tsdb_outdir/dft_inserted_designs/croc_soc_rtl1.dft_inserted_design/modified_rtl_files/rtl/croc_soc.sv" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc/rtl/croc_chip.sv" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl1_cells.instrument/croc_soc_rtl1_tessent_posedge_synchronizer_reset.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl1_ijtag.instrument/croc_soc_rtl1_tessent_sib_1.v" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl1_ijtag.instrument/croc_soc_rtl1_tessent_sib_2.v" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl1_ijtag.instrument/croc_soc_rtl1_tessent_sib_3.v" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl1_ijtag.instrument/croc_soc_rtl1_tessent_sib_4.v" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl1_ijtag.instrument/croc_soc_rtl1_tessent_tdr_sri_ctrl.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl1_mbist.instrument/croc_soc_rtl1_tessent_mbist_bap.v" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl1_mbist.instrument/croc_soc_rtl1_tessent_mbist_c1_controller.v" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl1_mbist.instrument/croc_soc_rtl1_tessent_mbist_c1_interface_m1.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl2_cells.instrument/croc_soc_rtl2_tessent_posedge_synchronizer_reset.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl2_ijtag.instrument/croc_soc_rtl2_tessent_sib_1.v" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl2_ijtag.instrument/croc_soc_rtl2_tessent_tdr_sri_ctrl.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl2_occ.instrument/croc_soc_rtl2_tessent_occ.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl2_edt_lbist.instrument/croc_soc_rtl2_tessent_edt_lbist_c1.v" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl2_edt_lbist.instrument/croc_soc_rtl2_tessent_edt_lbist_c1_tdr.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl2_lbist_ncp_index_decoder.instrument/croc_soc_rtl2_tessent_lbist_ncp_index_decoder.v" \
   } 

analyze -format verilog -library work { \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl2_lbist.instrument/croc_soc_rtl2_tessent_lbist.v" \
      "/home/jd.guerrero/Documents/croc_dft_examples/3.croc_soc-mbist-tk_lbist_hier/croc_soc/tsdb_outdir/instruments/croc_soc_rtl2_lbist.instrument/croc_soc_rtl2_tessent_single_chain_mode_logic.v" \
   } 

 
