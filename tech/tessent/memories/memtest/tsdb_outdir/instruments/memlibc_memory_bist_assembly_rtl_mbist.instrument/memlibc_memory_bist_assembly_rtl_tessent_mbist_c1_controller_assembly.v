//--------------------------------------------------------------------------
//
//  Unpublished work. Copyright 2021 Siemens
//
//  This material contains trade secrets or otherwise confidential 
//  information owned by Siemens Industry Software Inc. or its affiliates 
//  (collectively, SISW), or its licensors. Access to and use of this 
//  information is strictly limited as set forth in the Customer's 
//  applicable agreements with SISW.
//
//--------------------------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2022.3
//       Created on: Sat Nov 15 20:33:30 EST 2025
//--------------------------------------------------------------------------


module memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_assembly(LV_TM, 
                                                                             MEM_BYPASS_EN, 
                                                                             SCAN_SHIFT_EN, 
                                                                             MCP_BOUNDING_EN, 
                                                                             BIST_ON, 
                                                                             BIST_DONE, 
                                                                             BIST_GO, 
                                                                             clk_BIST_CLK, 
                                                                             m1_inst_A_DLY, 
                                                                             m1_inst_A_DIN, 
                                                                             m1_inst_A_ADDR, 
                                                                             m1_inst_A_MEN, 
                                                                             m1_inst_A_WEN, 
                                                                             m1_inst_A_REN, 
                                                                             m1_inst_A_DOUT, 
                                                                             reset, 
                                                                             ijtag_select, 
                                                                             si, 
                                                                             capture_en, 
                                                                             shift_en, 
                                                                             update_en, 
                                                                             tck, 
                                                                             so);
  input  [31:0] m1_inst_A_DIN;
  input  [12:0] m1_inst_A_ADDR;
  input  LV_TM, MEM_BYPASS_EN, SCAN_SHIFT_EN, MCP_BOUNDING_EN, clk_BIST_CLK, 
         m1_inst_A_DLY, m1_inst_A_MEN, m1_inst_A_WEN, m1_inst_A_REN, reset, 
         ijtag_select, si, capture_en, shift_en, update_en, tck;
  output [31:0] m1_inst_A_DOUT;
  output BIST_ON, BIST_DONE, BIST_GO, so;

  wire [31:0] A_DIN, A_DOUT;
  wire [12:0] A_ADDR;
  wire [8:0] BIST_ROW_ADD;
  wire [3:0] BIST_COL_ADD;
  wire [2:1] BIST_SETUP_ts1;
  wire [1:0] BIST_WRITE_DATA, BIST_EXPECT_DATA;
  wire [0:0] toBist, bistEn;
  wire BIST_HOLD, BIST_SETUP, BIST_SELECT_TEST_DATA, to_controllers_tck, 
       mcp_bounding_to_en, scan_to_en, memory_bypass_to_en, ltest_to_en, 
       BIST_ALGO_MODE0, BIST_ALGO_MODE1, ENABLE_MEM_RESET, 
       REDUCED_ADDRESS_COUNT, BIST_ASYNC_RESET, MEM0_BIST_COLLAR_SI, BIST_SO, 
       MBISTPG_SO, BIST_GO_ts1, BIST_DIAG_EN, BIST_COLLAR_DIAG_EN, 
       FL_CNT_MODE0, FL_CNT_MODE1, BIST_SELECT, BIST_WRITEENABLE, 
       BIST_READENABLE, BIST_CMP, INCLUDE_MEM_RESULTS_REG, BIST_COLLAR_EN0, 
       BIST_RUN_TO_COLLAR0, to_interfaces_tck, BIST_TESTDATA_SELECT_TO_COLLAR, 
       CHKBCI_PHASE, BIST_SHIFT_COLLAR, BIST_COLLAR_SETUP, BIST_CLEAR_DEFAULT, 
       BIST_CLEAR, BIST_COLLAR_HOLD, FREEZE_STOP_ERROR, ERROR_CNT_ZERO, 
       MBISTPG_RESET_REG_SETUP2, A_MEN, A_WEN, A_REN;

  RM_IHPSG13_1P_8192x32_c4 m1_inst(
      .A_CLK(clk_BIST_CLK), .A_MEN(A_MEN), .A_WEN(A_WEN), .A_REN(A_REN), .A_DLY(1'b1), 
      .A_ADDR(A_ADDR), .A_DIN(A_DIN), .A_DOUT(A_DOUT)
  );
  memlibc_memory_bist_assembly_rtl_tessent_mbist_bap memlibc_memory_bist_assembly_rtl_tessent_mbist_bap_inst(
      .reset(reset), .ijtag_select(ijtag_select), .si(si), .capture_en(capture_en), 
      .shift_en(shift_en), .shift_en_R(), .update_en(update_en), .tck(tck), .to_interfaces_tck(to_interfaces_tck), 
      .to_controllers_tck(to_controllers_tck), .mcp_bounding_en(MCP_BOUNDING_EN), 
      .mcp_bounding_to_en(mcp_bounding_to_en), .scan_en(SCAN_SHIFT_EN), .scan_to_en(scan_to_en), 
      .memory_bypass_en(MEM_BYPASS_EN), .memory_bypass_to_en(memory_bypass_to_en), 
      .ltest_en(LV_TM), .ltest_to_en(ltest_to_en), .BIST_HOLD(BIST_HOLD), .ENABLE_MEM_RESET(ENABLE_MEM_RESET), 
      .REDUCED_ADDRESS_COUNT(REDUCED_ADDRESS_COUNT), .BIST_SELECT_TEST_DATA(BIST_SELECT_TEST_DATA), 
      .BIST_ALGO_MODE0(BIST_ALGO_MODE0), .BIST_ALGO_MODE1(BIST_ALGO_MODE1), .BIST_DIAG_EN(BIST_DIAG_EN), 
      .BIST_ASYNC_RESET(BIST_ASYNC_RESET), .FL_CNT_MODE0(FL_CNT_MODE0), .FL_CNT_MODE1(FL_CNT_MODE1), 
      .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), .CHAIN_BYPASS_EN(), .TCK_MODE(), 
      .BIST_SETUP({BIST_SETUP_ts1[2:1], BIST_SETUP}), .MBISTPG_GO(BIST_GO), .MBISTPG_DONE(BIST_DONE), 
      .bistEn(bistEn), .toBist(toBist), .fromBist(MBISTPG_SO), .so(so)
  );
  memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller_inst(
      .MBISTPG_ALGO_MODE({BIST_ALGO_MODE1, BIST_ALGO_MODE0}), .MBISTPG_MEM_RST(ENABLE_MEM_RESET), 
      .MBISTPG_REDUCED_ADDR_CNT_EN(REDUCED_ADDRESS_COUNT), .MEM_BYPASS_EN(memory_bypass_to_en), 
      .MCP_BOUNDING_EN(mcp_bounding_to_en), .MEM0_BIST_COLLAR_SO(BIST_SO), .FL_CNT_MODE({
      FL_CNT_MODE1, FL_CNT_MODE0}), .BIST_COLLAR_GO(BIST_GO_ts1), .MBISTPG_DIAG_EN(BIST_DIAG_EN), 
      .BIST_CLK(clk_BIST_CLK), .BIST_SI(toBist), .BIST_HOLD(BIST_HOLD), .BIST_SETUP2(BIST_SETUP_ts1[2]), 
      .BIST_SETUP({BIST_SETUP_ts1[1], BIST_SETUP}), .MBISTPG_TESTDATA_SELECT(BIST_SELECT_TEST_DATA), 
      .TCK(to_controllers_tck), .MBISTPG_EN(bistEn), .MBISTPG_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .LV_TM(ltest_to_en), .MBISTPG_RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD), .BIST_WRITE_DATA(BIST_WRITE_DATA), 
      .BIST_EXPECT_DATA(BIST_EXPECT_DATA), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), 
      .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), .MEM0_BIST_COLLAR_SI(MEM0_BIST_COLLAR_SI), 
      .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .BIST_COLLAR_DIAG_EN(BIST_COLLAR_DIAG_EN), 
      .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), .BIST_CLEAR(BIST_CLEAR), .MBISTPG_SO(MBISTPG_SO), 
      .BIST_SELECT(BIST_SELECT), .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_CMP(BIST_CMP), .BIST_COLLAR_EN0(BIST_COLLAR_EN0), .BIST_RUN_TO_COLLAR0(BIST_RUN_TO_COLLAR0), 
      .CHKBCI_PHASE(CHKBCI_PHASE), .MBISTPG_GO(BIST_GO), .MBISTPG_DONE(BIST_DONE), 
      .BIST_ON_TO_COLLAR(BIST_ON)
  );
  memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1 m1_interface_instance(
      .A_MEN_IN(m1_inst_A_MEN), .A_WEN_IN(m1_inst_A_WEN), .A_REN_IN(m1_inst_A_REN), 
      .A_ADDR_IN(m1_inst_A_ADDR[12:0]), .A_DIN_IN(m1_inst_A_DIN[31:0]), .A_DOUT_IN(A_DOUT), 
      .TCK(to_interfaces_tck), .BIST_CMP(BIST_CMP), .INCLUDE_MEM_RESULTS_REG(INCLUDE_MEM_RESULTS_REG), 
      .BIST_SELECT(BIST_SELECT), .BIST_WRITEENABLE(BIST_WRITEENABLE), .BIST_READENABLE(BIST_READENABLE), 
      .BIST_COL_ADD(BIST_COL_ADD), .BIST_ROW_ADD(BIST_ROW_ADD), .BIST_WRITE_DATA(BIST_WRITE_DATA), 
      .CHKBCI_PHASE(CHKBCI_PHASE), .BIST_TESTDATA_SELECT_TO_COLLAR(BIST_TESTDATA_SELECT_TO_COLLAR), 
      .MEM_BYPASS_EN(memory_bypass_to_en), .SCAN_SHIFT_EN(scan_to_en), .MCP_BOUNDING_EN(mcp_bounding_to_en), 
      .BIST_ON(BIST_ON), .BIST_RUN(BIST_RUN_TO_COLLAR0), .BIST_ASYNC_RESETN(BIST_ASYNC_RESET), 
      .BIST_CLK(clk_BIST_CLK), .BIST_SHIFT_COLLAR(BIST_SHIFT_COLLAR), .BIST_EXPECT_DATA(BIST_EXPECT_DATA), 
      .BIST_SI(MEM0_BIST_COLLAR_SI), .BIST_COLLAR_SETUP(BIST_COLLAR_SETUP), .BIST_COLLAR_HOLD(BIST_COLLAR_HOLD), 
      .BIST_DIAG_EN(BIST_COLLAR_DIAG_EN), .BIST_CLEAR_DEFAULT(BIST_CLEAR_DEFAULT), 
      .BIST_CLEAR(BIST_CLEAR), .BIST_SETUP0(BIST_SETUP), .LV_TM(ltest_to_en), .FREEZE_STOP_ERROR(FREEZE_STOP_ERROR), 
      .BIST_COLLAR_EN(BIST_COLLAR_EN0), .RESET_REG_SETUP2(MBISTPG_RESET_REG_SETUP2), 
      .ERROR_CNT_ZERO(ERROR_CNT_ZERO), .A_MEN(A_MEN), .A_WEN(A_WEN), .A_REN(A_REN), 
      .A_ADDR(A_ADDR), .A_DIN(A_DIN), .A_DOUT(m1_inst_A_DOUT[31:0]), .SCAN_OBS_FLOPS(), 
      .BIST_SO(BIST_SO), .BIST_GO(BIST_GO_ts1)
  );
endmodule

