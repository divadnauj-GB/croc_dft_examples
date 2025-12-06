/*
----------------------------------------------------------------------------------
-                                                                                -
-  Unpublished work. Copyright 2021 Siemens                                      -
-                                                                                -
-  This material contains trade secrets or otherwise confidential                -
-  information owned by Siemens Industry Software Inc. or its affiliates         -
-  (collectively, SISW), or its licensors. Access to and use of this             -
-  information is strictly limited as set forth in the Customer's                -
-  applicable agreements with SISW.                                              -
-                                                                                -
----------------------------------------------------------------------------------
-  File created by: Tessent Shell                                                -
-          Version: 2022.3                                                       -
-       Created on: Sat Nov 15 20:33:20 EST 2025                                 -
----------------------------------------------------------------------------------


*/
 // ============================================================================
// == Description     : ICL description for memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1
// == Tool Name       : membistipCommonGenerate
// == Tool Version    : 2022.3      Thu Aug 11 22:57:52 GMT 2022
// ============================================================================
Module memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_interface_m1 {
    ClockPort                       BIST_CLK;
    DataInPort                      BIST_COLLAR_EN;
    DataInPort                      BIST_ASYNC_RESETN;
    ScanInPort                      BIST_SI;
    ScanOutPort                     BIST_SO {Source BIST_SO_INT;}
    ShiftEnPort                     BIST_SHIFT_COLLAR;
    DataInPort                      BIST_SETUP0;
    DataInPort                      MEM_BYPASS_EN {
        Attribute connection_rule_option = "allowed_tied_low";}
    DataInPort                      MCP_BOUNDING_EN {
        Attribute connection_rule_option = "allowed_tied_low";}
    DataInPort                      INCLUDE_MEM_RESULTS_REG;
          
    DataOutPort                     A_ADDR[12:0] { 
        Attribute connection_rule_option = "allowed_no_destination"; 
        Attribute tessent_memory_bist_function = "address";
    }
// [start] : LONG_SETUP / SHORT_SETUP chain registers {{{
  Alias GO_ID_REG_BYPASS_SOURCE = BIST_SI;
  ScanRegister GO_ID_REG[31:0] {
    ScanInSource     BIST_SI;
  }
  ScanMux GO_ID_REG_BYPASS_MUX SelectedBy INCLUDE_MEM_RESULTS_REG {
      1'b0 : GO_ID_REG_BYPASS_SOURCE;
      1'b1 : GO_ID_REG[0];
  }
  ScanRegister FREEZE_STOP_ERROR_REG[0:0] {
    ScanInSource     GO_ID_REG_BYPASS_MUX;
  }
// [end]   : LONG_SETUP / SHORT_SETUP chain registers }}}
  Alias BIST_SO_INT = FREEZE_STOP_ERROR_REG[0];
  Attribute          tessent_instrument_type = "mentor::memory_bist";
  Attribute          tessent_instrument_subtype = "memory_interface";
  Attribute          tessent_signature = "589dd6d38538c4287cc74a3cc6ac2e63";
  Attribute          tessent_ignore_during_icl_verification = "on";
  Attribute          keep_active_during_scan_test           = "false";
  Attribute          tessent_use_in_dft_specification = "false";
  Attribute          tessent_bist_input_select_persistent_cell_output_list = "tessent_persistent_cell_BIST_INPUT_SELECT_INT/y";
  Attribute          tessent_async_bypass_persistent_cell_input_list = "";
  Attribute          tessent_bist_clk_persistent_cell_output_list = "tessent_persistent_cell_GATING_BIST_CLK/clkg";
  Attribute          tessent_memory_output_is_tristate = "false";
  Attribute          tessent_memory_control_inputs_list = "A_DLY LOGICHIGH ACTIVEHIGH A_MEN SELECT ACTIVEHIGH A_REN READENABLE ACTIVEHIGH";
  Attribute          tessent_memory_test_inputs_list = "";
  Attribute          tessent_memory_test_outputs_list = "";
  Attribute          tessent_memory_control_inputs_di_coverage_list = "partial";
}
