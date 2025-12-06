//-------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2022.3
//       Created on: Sat Nov 15 20:33:34 EST 2025
//-------------------------------------------------


Module memlibc_memory_bist_assembly {
   // Created by ICL extraction
   ClockPort BIST_CLK {
      Attribute tessent_clock_domain_labels = "BIST_CLK BIST_CLK";
      Attribute tessent_clock_periods = "all 10.00ns";
   }
   CaptureEnPort ijtag_ce;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   ShiftEnPort ijtag_se;
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_so;
   }
   TCKPort ijtag_tck;
   UpdateEnPort ijtag_ue;
   ScanInterface ijtag {
      Port ijtag_ce;
      Port ijtag_reset;
      Port ijtag_se;
      Port ijtag_sel;
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_tck;
      Port ijtag_ue;
   }
   Attribute tessent_design_format = "verilog_2001";
   Attribute test_setup_procfile = "";
   Attribute icl_extraction_date = "Sat Nov 15 20:33:34 EST 2025";
   Attribute created_by_tessent_icl_extract = "true";
   Attribute tessent_design_id = "rtl";
   Attribute tessent_design_level = "sub_block";
   Instance mem_container_inst_m1_mem_inst Of RM_IHPSG13_1P_8192x32_c4 {
      InputPort A_ADDR[12] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[12];
      InputPort A_ADDR[11] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[11];
      InputPort A_ADDR[10] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[10];
      InputPort A_ADDR[9] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[9];
      InputPort A_ADDR[8] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[8];
      InputPort A_ADDR[7] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[7];
      InputPort A_ADDR[6] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[6];
      InputPort A_ADDR[5] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[5];
      InputPort A_ADDR[4] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[4];
      InputPort A_ADDR[3] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[3];
      InputPort A_ADDR[2] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[2];
      InputPort A_ADDR[1] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[1];
      InputPort A_ADDR[0] = 
          mem_container_inst_m1_mem_inst_interface_inst.A_ADDR[0];
      InputPort A_CLK = BIST_CLK;
      Attribute tessent_design_instance = "mem_container_inst/m1_mem_inst";
   }
   Instance mem_container_inst_m1_mem_inst_interface_inst Of 
       memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1 {
      InputPort BIST_CLK = BIST_CLK;
      InputPort BIST_COLLAR_EN = 
          mem_container_inst_memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst.BIST_COLLAR_EN0;

      InputPort BIST_ASYNC_RESETN = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_ASYNC_RESET;

      InputPort BIST_SI = 
          mem_container_inst_memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst.MEM0_BIST_COLLAR_SI;

      InputPort BIST_SHIFT_COLLAR = 
          mem_container_inst_memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst.BIST_SHIFT_COLLAR;

      InputPort BIST_SETUP0 = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_SETUP[0];
      InputPort MEM_BYPASS_EN = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.memory_bypass_to_en;

      InputPort MCP_BOUNDING_EN = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.mcp_bounding_to_en;

      InputPort INCLUDE_MEM_RESULTS_REG = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.INCLUDE_MEM_RESULTS_REG;

      Attribute tessent_design_instance = 
          "mem_container_inst/m1_mem_inst_interface_inst";
   }
   Instance 
       mem_container_inst_memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst 
       Of memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller {
      InputPort BIST_CLK = BIST_CLK;
      InputPort MBISTPG_EN = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.bistEn[0];
      InputPort LV_TM = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.ltest_to_en;
      InputPort MEM_BYPASS_EN = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.memory_bypass_to_en;

      InputPort MCP_BOUNDING_EN = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.mcp_bounding_to_en;

      InputPort MBISTPG_ASYNC_RESETN = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_ASYNC_RESET;

      InputPort MBISTPG_DIAG_EN = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_DIAG_EN;
      InputPort BIST_SETUP2 = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_SETUP[2];
      InputPort BIST_SETUP[1] = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_SETUP[1];
      InputPort BIST_SETUP[0] = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_SETUP[0];
      InputPort MBISTPG_REDUCED_ADDR_CNT_EN = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.REDUCED_ADDRESS_COUNT;

      InputPort MBISTPG_MEM_RST = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.ENABLE_MEM_RESET;

      InputPort MBISTPG_TESTDATA_SELECT = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_SELECT_TEST_DATA;

      InputPort FL_CNT_MODE[1] = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.FL_CNT_MODE1;
      InputPort FL_CNT_MODE[0] = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.FL_CNT_MODE0;
      InputPort MBISTPG_ALGO_MODE[1] = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_ALGO_MODE1;

      InputPort MBISTPG_ALGO_MODE[0] = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_ALGO_MODE0;

      InputPort TCK = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_tck;
      InputPort BIST_SI = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.toBist[0];
      InputPort BIST_HOLD = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.BIST_HOLD;
      InputPort MEM0_BIST_COLLAR_SO = 
          mem_container_inst_m1_mem_inst_interface_inst.BIST_SO;
      Attribute tessent_design_instance = 
          "mem_container_inst/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst"
          ;
   }
   Instance memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst Of 
       memlibc_memory_bist_assembly_rtl_tessent_mbist_bap {
      InputPort reset = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_reset;
      InputPort ijtag_select = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_mbist_inst.ijtag_to_sel;
      InputPort si = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_si;
      InputPort capture_en = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_ce;
      InputPort shift_en = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_se;
      InputPort update_en = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_ue;
      InputPort tck = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_tck;
      InputPort memory_bypass_en = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ltest_to_mem_bypass_en;

      InputPort mcp_bounding_en = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ltest_to_mcp_bounding_en;

      InputPort ltest_en = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ltest_to_en;
      InputPort fromBist[0] = 
          mem_container_inst_memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst.MBISTPG_SO;

      InputPort MBISTPG_GO[0] = 
          mem_container_inst_memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst.MBISTPG_GO;

      InputPort MBISTPG_DONE[0] = 
          mem_container_inst_memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst.MBISTPG_DONE;

      Attribute tessent_design_instance = 
          "memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst";
   }
   Instance memlibc_memory_bist_assembly_rtl_tessent_sib_mbist_inst Of 
       memlibc_memory_bist_assembly_rtl_tessent_sib_2 {
      InputPort ijtag_reset = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_reset;
      InputPort ijtag_sel = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_sel;
      InputPort ijtag_si = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_si;
      InputPort ijtag_ce = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_ce;
      InputPort ijtag_se = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_se;
      InputPort ijtag_ue = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_ue;
      InputPort ijtag_tck = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst.ijtag_to_tck;
      InputPort ijtag_from_so = 
          memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst.so;
      Attribute tessent_design_instance = 
          "memlibc_memory_bist_assembly_rtl_tessent_sib_mbist_inst";
   }
   Instance memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst Of 
       memlibc_memory_bist_assembly_rtl_tessent_sib_1 {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = 
          memlibc_memory_bist_assembly_rtl_tessent_sib_mbist_inst.ijtag_so;
      InputPort ltest_en = 'b0;
      InputPort ltest_occ_en = 'b0;
      InputPort ltest_static_clock_control_mode = 'b0;
      InputPort ltest_clock_sequence[1] = 'b0;
      InputPort ltest_clock_sequence[0] = 'b0;
      InputPort ltest_mem_bypass_en = 'b1;
      InputPort ltest_mcp_bounding_en = 'b0;
      Attribute tessent_design_instance = 
          "memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst";
   }
}

// instanced as memlibc_memory_bist_assembly.mem_container_inst_m1_mem_inst
Module RM_IHPSG13_1P_8192x32_c4 {
   // ICL module read from source on or near line 17 of file '/home/jd.guerrero/Documents/Tessent/tech/tessent/memories/memtest/tsdb_outdir/instruments/memlibc_memory_bist_assembly_rtl_mbist.instrument/RM_IHPSG13_1P_8192x32_c4.icl'
   DataInPort A_ADDR[12:0] {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute tessent_memory_bist_function = "address";
   }
   ClockPort A_CLK;
   Attribute tessent_use_in_dft_specification = "false";
   Attribute keep_active_during_scan_test = "false";
   Attribute tessent_memory_module = "without_internal_scan_logic";
}

// instanced as memlibc_memory_bist_assembly.mem_container_inst_m1_mem_inst_interface_inst
Module memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1 {
   // ICL module read from source on or near line 25 of file '/home/jd.guerrero/Documents/Tessent/tech/tessent/memories/memtest/tsdb_outdir/instruments/memlibc_memory_bist_assembly_rtl_mbist.instrument/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1.icl'
   ClockPort BIST_CLK;
   DataInPort BIST_COLLAR_EN;
   DataInPort BIST_ASYNC_RESETN;
   ScanInPort BIST_SI;
   ScanOutPort BIST_SO {
      Source BIST_SO_INT;
   }
   ShiftEnPort BIST_SHIFT_COLLAR;
   DataInPort BIST_SETUP0;
   DataInPort MEM_BYPASS_EN {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort MCP_BOUNDING_EN {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort INCLUDE_MEM_RESULTS_REG;
   DataOutPort A_ADDR[12:0] {
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_memory_bist_function = "address";
   }
   Attribute tessent_instrument_type = "mentor::memory_bist";
   Attribute tessent_instrument_subtype = "memory_interface";
   Attribute tessent_signature = "589dd6d38538c4287cc74a3cc6ac2e63";
   Attribute tessent_ignore_during_icl_verification = "on";
   Attribute keep_active_during_scan_test = "false";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_bist_input_select_persistent_cell_output_list = 
       "tessent_persistent_cell_BIST_INPUT_SELECT_INT/y";
   Attribute tessent_async_bypass_persistent_cell_input_list = "";
   Attribute tessent_bist_clk_persistent_cell_output_list = 
       "tessent_persistent_cell_GATING_BIST_CLK/clkg";
   Attribute tessent_memory_output_is_tristate = "false";
   Attribute tessent_memory_control_inputs_list = 
       "A_DLY LOGICHIGH ACTIVEHIGH A_MEN SELECT ACTIVEHIGH A_REN READENABLE ACTIVEHIGH"
       ;
   Attribute tessent_memory_test_inputs_list = "";
   Attribute tessent_memory_test_outputs_list = "";
   Attribute tessent_memory_control_inputs_di_coverage_list = "partial";
   Alias GO_ID_REG_BYPASS_SOURCE = BIST_SI {
   }
   Alias BIST_SO_INT = FREEZE_STOP_ERROR_REG[0] {
   }
   ScanRegister GO_ID_REG[31:0] {
      ScanInSource BIST_SI;
   }
   ScanRegister FREEZE_STOP_ERROR_REG[0:0] {
      ScanInSource GO_ID_REG_BYPASS_MUX;
   }
   ScanMux GO_ID_REG_BYPASS_MUX SelectedBy INCLUDE_MEM_RESULTS_REG {
      1'b0 : GO_ID_REG_BYPASS_SOURCE;
      1'b1 : GO_ID_REG[0];
   }
}

// instanced as memlibc_memory_bist_assembly.mem_container_inst_memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst
Module memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller {
   // ICL module read from source on or near line 26 of file '/home/jd.guerrero/Documents/Tessent/tech/tessent/memories/memtest/tsdb_outdir/instruments/memlibc_memory_bist_assembly_rtl_mbist.instrument/memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller.icl'
   ClockPort BIST_CLK;
   DataInPort MBISTPG_EN;
   DataInPort LV_TM {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort MEM_BYPASS_EN {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort MCP_BOUNDING_EN {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort MBISTPG_ASYNC_RESETN {
      RefEnum AsyncResetN;
   }
   DataInPort MBISTPG_DIAG_EN;
   DataInPort BIST_SETUP2;
   DataInPort BIST_SETUP[1:0];
   DataInPort MBISTPG_REDUCED_ADDR_CNT_EN {
      RefEnum OnOff;
   }
   DataInPort MBISTPG_MEM_RST {
      RefEnum OnOff;
   }
   DataInPort MBISTPG_TESTDATA_SELECT {
      RefEnum OnOff;
   }
   DataInPort FL_CNT_MODE[1:0];
   DataInPort MBISTPG_ALGO_MODE[1:0];
   DataOutPort MBISTPG_GO {
      RefEnum PassFail;
   }
   DataOutPort MBISTPG_DONE {
      RefEnum PassFail;
   }
   TCKPort TCK;
   ScanInPort BIST_SI;
   ScanOutPort MBISTPG_SO {
      Source BIST_SO_INT;
   }
   ShiftEnPort BIST_HOLD;
   ToShiftEnPort BIST_SHIFT_COLLAR {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_COLLAR_EN0 {
      Attribute tessent_memory_alias = "m1";
   }
   ScanOutPort MEM0_BIST_COLLAR_SI {
      Source MEM0_BIST_COLLAR_SI_INT;
   }
   ScanInPort MEM0_BIST_COLLAR_SO;
   ScanInterface Client {
      Port BIST_SI;
      Port MBISTPG_SO;
      Port BIST_HOLD;
   }
   ScanInterface MEM0_INTERFACE {
      Port BIST_SHIFT_COLLAR;
      Port MEM0_BIST_COLLAR_SI;
      Port MEM0_BIST_COLLAR_SO;
   }
   Attribute tessent_instrument_container = 
       "memlibc_memory_bist_assembly_rtl_mbist";
   Attribute tessent_instrument_type = "mentor::memory_bist";
   Attribute tessent_instrument_subtype = "controller";
   Attribute tessent_signature = "5ebf3b804074c35ce286d2e7896a98a5";
   Attribute tessent_ignore_during_icl_verification = "on";
   Attribute keep_active_during_scan_test = "false";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_bist_clk_persistent_cell_output_list = 
       "tessent_persistent_cell_GATING_BIST_CLK/clkg";
   Alias SETUP_MODE[2:0] = BIST_SETUP2, BIST_SETUP[1:0] {
      RefEnum SetupModes;
   }
   Alias RUN_MODE[2:0] = BIST_SETUP2, BIST_SETUP[1:0] {
      RefEnum RunModes;
   }
   Alias INST_POINTER_REG[5:0] = INST_POINTER_REG_HW[5:0] {
   }
   Alias A_ADD_REG_Y[3:0] = A_ADD_REG_Y_HW[3:0] {
   }
   Alias A_ADD_REG_X[8:0] = A_ADD_REG_X_HW[8:0] {
   }
   Alias B_ADD_REG_Y[3:0] = B_ADD_REG_Y_HW[3:0] {
   }
   Alias B_ADD_REG_X[8:0] = B_ADD_REG_X_HW[8:0] {
   }
   Alias JCNT[2:0] = JCNT_HW[2:0] {
   }
   Alias WDATA_REG[1:0] = WDATA_REG_HW[1:0] {
   }
   Alias EDATA_REG[1:0] = EDATA_REG_HW[1:0] {
   }
   Alias REPEATLOOP_A_CNTR_REG[1:0] = REPEATLOOP_A_CNTR_REG_HW[1:0] {
   }
   Alias REPEATLOOP_B_CNTR_REG[1:0] = REPEATLOOP_B_CNTR_REG_HW[1:0] {
   }
   Alias MEM0_BIST_COLLAR_SI_INT = REPEATLOOP_B_CNTR_REG_HW[1] {
   }
   Alias STOP_ERROR_CNT_REG[11:0] = STOP_ERROR_CNT_REG_HW[11:0] {
   }
   Alias BIST_SO_INT = BIST_SO_Pipeline {
   }
   Enum PassFail {
      Pass = 1'b1;
      Fail = 1'b0;
      Ignore = 1'bx;
   }
   Enum AsyncResetN {
      On = 1'b0;
      Off = 1'b1;
   }
   Enum SetupModes {
      Short = 3'b000;
      Long = 3'b001;
   }
   Enum OnOff {
      On = 1'b1;
      Off = 1'b0;
   }
   Enum RunModes {
      HWDefault = 3'b010;
      RunTimeProg = 3'b011;
      Idle = 3'bx0x;
      Off = 3'bxxx;
   }
   ScanRegister BIST_SI_Pipeline {
      ScanInSource BIST_SI;
      ResetValue 1'b0;
   }
   ScanRegister DIAG_EN_REG[0:0] {
      ScanInSource BIST_SI_Pipeline;
   }
   ScanRegister CMP_EN_MASK_EN[0:0] {
      ScanInSource DIAG_EN_REG[0];
   }
   ScanRegister CMP_EN_PARITY[0:0] {
      ScanInSource CMP_EN_MASK_EN[0];
      CaptureSource 1'bx;
   }
   ScanRegister MEM_SELECT_REG0[0:0] {
      ScanInSource CMP_EN_PARITY[0];
      ResetValue 1'd1;
   }
   ScanRegister REDUCED_ADDR_CNT_EN_REG[0:0] {
      ScanInSource MEM_SELECT_REG0[0];
      RefEnum OnOff;
   }
   ScanRegister ALGO_SEL_CNT_REG[0:0] {
      ScanInSource REDUCED_ADDR_CNT_EN_REG[0];
      RefEnum OnOff;
   }
   ScanRegister SELECT_COMMON_OPSET_REG[0:0] {
      ScanInSource ALGO_SEL_CNT_REG[0];
      RefEnum OnOff;
   }
   ScanRegister SELECT_COMMON_DATA_PAT_REG[0:0] {
      ScanInSource SELECT_COMMON_OPSET_REG[0];
      RefEnum OnOff;
   }
   ScanRegister MICROCODE_EN_REG[0:0] {
      ScanInSource SELECT_COMMON_DATA_PAT_REG[0];
   }
   ScanRegister INST_POINTER_REG_HW[0:5] {
      ScanInSource MICROCODE_EN_REG[0];
   }
   ScanRegister A_ADD_REG_Y_HW[0:3] {
      ScanInSource INST_POINTER_REG_HW[5];
   }
   ScanRegister A_ADD_REG_X_HW[0:8] {
      ScanInSource A_ADD_REG_Y_HW[3];
   }
   ScanRegister B_ADD_REG_Y_HW[0:3] {
      ScanInSource A_ADD_REG_X_HW[8];
   }
   ScanRegister B_ADD_REG_X_HW[0:8] {
      ScanInSource B_ADD_REG_Y_HW[3];
   }
   ScanRegister JCNT_HW[0:2] {
      ScanInSource B_ADD_REG_X_HW[8];
   }
   ScanRegister OPSET_SELECT_REG[0:0] {
      ScanInSource JCNT_HW[2];
   }
   ScanRegister WDATA_REG_HW[0:1] {
      ScanInSource OPSET_SELECT_REG[0];
   }
   ScanRegister EDATA_REG_HW[0:1] {
      ScanInSource WDATA_REG_HW[1];
   }
   ScanRegister X_ADDR_BIT_SEL_REG[0:0] {
      ScanInSource EDATA_REG_HW[1];
   }
   ScanRegister Y_ADDR_BIT_SEL_REG[0:0] {
      ScanInSource X_ADDR_BIT_SEL_REG[0];
   }
   ScanRegister REPEATLOOP_A_CNTR_REG_HW[0:1] {
      ScanInSource Y_ADDR_BIT_SEL_REG[0];
   }
   ScanRegister REPEATLOOP_B_CNTR_REG_HW[0:1] {
      ScanInSource REPEATLOOP_A_CNTR_REG_HW[1];
   }
   ScanRegister STOP_ON_ERROR_REG[0:0] {
      ScanInSource MEM0_BIST_COLLAR_SO;
   }
   ScanRegister FREEZE_STOP_ERROR_REG[0:0] {
      ScanInSource STOP_ON_ERROR_REG[0];
   }
   ScanRegister STOP_ERROR_CNT_REG_HW[0:11] {
      ScanInSource FREEZE_STOP_ERROR_REG[0];
   }
   ScanRegister BIST_SO_Pipeline {
      ScanInSource BIST_SO_OUT;
      ResetValue 1'b0;
   }
   ScanMux CONTROLLER_SETUP_CHAIN SelectedBy MBISTPG_EN, SETUP_MODE[2:0] {
      1'b1, 3'b00x : STOP_ERROR_CNT_REG_HW[11];
   }
   ScanMux BIST_SO_OUT SelectedBy LV_TM, MBISTPG_ASYNC_RESETN {
      2'b01 : CONTROLLER_SETUP_CHAIN;
   }
   LogicSignal LONG_SETUP {
      MBISTPG_EN, SETUP_MODE[2:0] == 1'b1, 3'b001;
   }
   LogicSignal SHORT_SETUP {
      MBISTPG_EN, SETUP_MODE[2:0] == 1'b1, 3'b000;
   }
}

// instanced as memlibc_memory_bist_assembly.memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst
Module memlibc_memory_bist_assembly_rtl_tessent_mbist_bap {
   // ICL module read from source on or near line 17 of file '/home/jd.guerrero/Documents/Tessent/tech/tessent/memories/memtest/tsdb_outdir/instruments/memlibc_memory_bist_assembly_rtl_mbist.instrument/memlibc_memory_bist_assembly_rtl_tessent_mbist_bap.icl'
   ResetPort reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_select;
   ScanInPort si;
   CaptureEnPort capture_en;
   ShiftEnPort shift_en;
   ToShiftEnPort BIST_HOLD {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   UpdateEnPort update_en;
   TCKPort tck;
   DataInPort memory_bypass_en {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort memory_bypass_to_en {
      Source memory_bypass_en;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort mcp_bounding_en {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort mcp_bounding_to_en {
      Source mcp_bounding_en;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort ltest_en {
      DefaultLoadValue 1'b0;
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort ltest_to_en {
      Source ltest_en;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanOutPort so {
      Source ctl_group_sib;
   }
   ScanOutPort toBist[0:0] {
      Source toBist_int;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInPort fromBist[0:0] {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort MBISTPG_GO[0:0] {
      Attribute connection_rule_option = "allowed_no_source";
   }
   DataInPort MBISTPG_DONE[0:0] {
      Attribute connection_rule_option = "allowed_no_source";
   }
   DataOutPort bistEn[0:0] {
      Source bistEn_int[0:0];
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort ENABLE_MEM_RESET {
      Source ENABLE_MEM_RESET_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort REDUCED_ADDRESS_COUNT {
      Source REDUCED_ADDRESS_COUNT_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_SELECT_TEST_DATA {
      Source BIST_SELECT_TEST_DATA_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_ALGO_MODE0 {
      Source BIST_ALGO_MODE0_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_ALGO_MODE1 {
      Source BIST_ALGO_MODE1_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_DIAG_EN {
      Source BIST_DIAG_EN_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_ASYNC_RESET {
      Source BIST_ASYNC_RESET_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort FL_CNT_MODE0 {
      Source FL_CNT_MODE0_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort FL_CNT_MODE1 {
      Source FL_CNT_MODE1_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort INCLUDE_MEM_RESULTS_REG {
      Source INCLUDE_MEM_RESULTS_REG_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort CHAIN_BYPASS_EN {
      Source CHAIN_BYPASS_EN_tdr;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort TCK_MODE {
      Source TCK_MODE_tdr;
      RefEnum OnOff;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataOutPort BIST_SETUP[2:0] {
      Source BIST_SETUP_tdr[2:0];
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInterface client {
      Port si;
      Port so;
      Port ijtag_select;
   }
   ScanInterface host_0 {
      Port toBist[0];
      Port fromBist[0];
      Port BIST_HOLD;
   }
   Attribute ijtag_logical_connection = 
       "{tck to_interfaces_tck} {tck to_controllers_tck}";
   Attribute keep_active_during_scan_test = "false";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::memory_bist";
   Attribute tessent_instrument_subtype = "bist_access_port";
   Attribute tessent_signature = "bb5e722fbbe05b7088cc89efafe59fb8";
   Alias tdr[14:0] = BIST_SETUP_tdr[2:0], TCK_MODE_tdr, CHAIN_BYPASS_EN_tdr, 
       INCLUDE_MEM_RESULTS_REG_tdr, FL_CNT_MODE1_tdr, FL_CNT_MODE0_tdr, 
       BIST_ASYNC_RESET_tdr, BIST_DIAG_EN_tdr, BIST_ALGO_MODE1_tdr, 
       BIST_ALGO_MODE0_tdr, BIST_SELECT_TEST_DATA_tdr, REDUCED_ADDRESS_COUNT_tdr,
       ENABLE_MEM_RESET_tdr {
      RefEnum tdr_symbols;
   }
   Alias ChainBypassMode = CHAIN_BYPASS_EN_tdr {
   }
   Alias bistEn_int[0:0] = mbist_go_0 {
   }
   Alias toBist_int[0:0] = tdr_bypass_sib_inst {
   }
   Enum OnOff {
      ON = 1'b1;
      OFF = 1'b0;
   }
   Enum tdr_symbols {
      idle = 15'b000010001000100;
      ignore = 15'bxxxxxxxxxxxxxxx;
      mbist_async_reset = 15'b000010000000000;
   }
   ScanRegister BIST_SETUP_tdr[2:0] {
      ScanInSource si;
      CaptureSource BIST_SETUP_tdr[2], BIST_SETUP_tdr[1], BIST_SETUP_tdr[0];
      DefaultLoadValue 3'b000;
      ResetValue 3'b000;
   }
   ScanRegister TCK_MODE_tdr {
      ScanInSource BIST_SETUP_tdr[0];
      CaptureSource TCK_MODE_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister CHAIN_BYPASS_EN_tdr {
      ScanInSource TCK_MODE_tdr;
      CaptureSource CHAIN_BYPASS_EN_tdr;
      DefaultLoadValue 1'b1;
      ResetValue 1'b1;
   }
   ScanRegister INCLUDE_MEM_RESULTS_REG_tdr {
      ScanInSource CHAIN_BYPASS_EN_tdr;
      CaptureSource INCLUDE_MEM_RESULTS_REG_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister FL_CNT_MODE1_tdr {
      ScanInSource INCLUDE_MEM_RESULTS_REG_tdr;
      CaptureSource FL_CNT_MODE1_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister FL_CNT_MODE0_tdr {
      ScanInSource FL_CNT_MODE1_tdr;
      CaptureSource FL_CNT_MODE0_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_ASYNC_RESET_tdr {
      ScanInSource FL_CNT_MODE0_tdr;
      CaptureSource BIST_ASYNC_RESET_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_DIAG_EN_tdr {
      ScanInSource BIST_ASYNC_RESET_tdr;
      CaptureSource BIST_DIAG_EN_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_ALGO_MODE1_tdr {
      ScanInSource BIST_DIAG_EN_tdr;
      CaptureSource BIST_ALGO_MODE1_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_ALGO_MODE0_tdr {
      ScanInSource BIST_ALGO_MODE1_tdr;
      CaptureSource BIST_ALGO_MODE0_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister BIST_SELECT_TEST_DATA_tdr {
      ScanInSource BIST_ALGO_MODE0_tdr;
      CaptureSource BIST_SELECT_TEST_DATA_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister REDUCED_ADDRESS_COUNT_tdr {
      ScanInSource BIST_SELECT_TEST_DATA_tdr;
      CaptureSource REDUCED_ADDRESS_COUNT_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister ENABLE_MEM_RESET_tdr {
      ScanInSource REDUCED_ADDRESS_COUNT_tdr;
      CaptureSource ENABLE_MEM_RESET_tdr;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister tdr_bypass_sib_inst {
      ScanInSource tdr_bypass_sib_mux_inst;
      CaptureSource 1'b0;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister mbist_done_0 {
      ScanInSource fromBistMux_0;
      CaptureSource MBISTPG_DONE[0];
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister mbist_go_0 {
      ScanInSource mbist_done_0;
      CaptureSource MBISTPG_GO[0];
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister ctl_group_sib {
      ScanInSource ctl_sib_mux_inst;
      CaptureSource 1'b0;
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
   ScanMux tdr_bypass_sib_mux_inst SelectedBy tdr_bypass_sib_inst {
      1'b0 : si;
      1'b1 : ENABLE_MEM_RESET_tdr;
   }
   ScanMux fromBistMux_0 SelectedBy bistEn_int[0], BIST_SETUP_tdr[1], 
       ChainBypassMode {
      3'b100 : fromBist[0];
      3'bxxx : tdr_bypass_sib_inst;
   }
   ScanMux ctl_sib_mux_inst SelectedBy ctl_group_sib {
      1'b0 : tdr_bypass_sib_inst;
      1'b1 : mbist_go_0;
   }
}

// instanced as memlibc_memory_bist_assembly.memlibc_memory_bist_assembly_rtl_tessent_sib_mbist_inst
Module memlibc_memory_bist_assembly_rtl_tessent_sib_2 {
   // ICL module read from source on or near line 17 of file '/home/jd.guerrero/Documents/Tessent/tech/tessent/memories/memtest/tsdb_outdir/instruments/memlibc_memory_bist_assembly_rtl_ijtag.instrument/memlibc_memory_bist_assembly_rtl_tessent_sib_2.icl'
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   TCKPort ijtag_tck;
   ScanOutPort ijtag_so {
      Source sib;
   }
   ToSelectPort ijtag_to_sel {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInPort ijtag_from_so {
      Attribute connection_rule_option = "allowed_no_source";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   ScanInterface host {
      Port ijtag_from_so;
      Port ijtag_to_sel;
   }
   Attribute keep_active_during_scan_test = "false";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "b74b61d27ffb4d47a748e837bd8e8bd7";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
}

// instanced as memlibc_memory_bist_assembly.memlibc_memory_bist_assembly_rtl_tessent_sib_sti_inst
Module memlibc_memory_bist_assembly_rtl_tessent_sib_1 {
   // ICL module read from source on or near line 17 of file '/home/jd.guerrero/Documents/Tessent/tech/tessent/memories/memtest/tsdb_outdir/instruments/memlibc_memory_bist_assembly_rtl_ijtag.instrument/memlibc_memory_bist_assembly_rtl_tessent_sib_1.icl'
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   TCKPort ijtag_tck;
   ScanOutPort ijtag_so {
      Source sib;
   }
   ToSelectPort ijtag_to_sel {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInPort ijtag_from_so {
      Attribute connection_rule_option = "allowed_no_source";
   }
   ToResetPort ijtag_to_reset {
      ActivePolarity 0;
      Source ijtag_reset;
   }
   ScanOutPort ijtag_to_si {
      Source ijtag_si;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ToCaptureEnPort ijtag_to_ce {
      Source ijtag_ce;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ToShiftEnPort ijtag_to_se {
      Source ijtag_se;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ToUpdateEnPort ijtag_to_ue {
      Source ijtag_ue;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ToTCKPort ijtag_to_tck {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort ltest_en {
      Attribute explicit_iwrite_only = 1'b1;
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort ltest_occ_en {
      Attribute explicit_iwrite_only = 1'b1;
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort ltest_static_clock_control_mode {
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort ltest_clock_sequence[1:0] {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute tessent_use_in_dft_specification = "false";
      Attribute function_modifier = "tessent_clock_sequence";
   }
   DataOutPort ltest_to_en {
      Source ltest_en;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort ltest_mem_bypass_en {
      Attribute connection_rule_option = "allowed_tied";
   }
   DataOutPort ltest_to_mem_bypass_en {
      Source ltest_to_mem_bypass_en_int;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort ltest_mcp_bounding_en {
      Attribute explicit_iwrite_only = 1'b1;
      Attribute connection_rule_option = "allowed_tied";
      Attribute forced_low_dft_signal_list = "ltest_en";
   }
   DataOutPort ltest_to_mcp_bounding_en {
      Source ltest_to_mcp_bounding_en_int;
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   ScanInterface host {
      Port ijtag_from_so;
      Port ijtag_to_sel;
      Port ijtag_to_si;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_dft_function = "scan_tested_instrument_host";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "c611f43c4f163e85c61d7983d96ff92b";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib, ltest_en {
      2'b10 : ijtag_from_so;
      2'bxx : ijtag_si;
   }
   LogicSignal ltest_to_mem_bypass_en_int {
      ltest_mem_bypass_en & ltest_en;
   }
   LogicSignal ltest_to_mcp_bounding_en_int {
      ltest_mcp_bounding_en & ltest_en;
   }
}
