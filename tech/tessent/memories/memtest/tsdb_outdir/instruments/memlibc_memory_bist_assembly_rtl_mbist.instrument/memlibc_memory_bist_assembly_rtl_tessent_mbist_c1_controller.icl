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
// == Description     : ICL description for memlibc_memory_bist_assembly_LVISION_MBISTPG_CTRL
// == Tool Name       : membistipCommonGenerate
// == Tool Version    : 2022.3      Thu Aug 11 22:57:52 GMT 2022
// ============================================================================
Module memlibc_memory_bist_assembly_rtl_tessent_mbist_c1_controller {
  ClockPort     BIST_CLK;
  DataInPort    MBISTPG_EN;
  DataInPort    LV_TM { Attribute connection_rule_option = "allowed_tied_low"; }
  DataInPort           MEM_BYPASS_EN {
    Attribute connection_rule_option = "allowed_tied_low";}
  DataInPort           MCP_BOUNDING_EN {
    Attribute connection_rule_option = "allowed_tied_low";}
  DataInPort    MBISTPG_ASYNC_RESETN {RefEnum AsyncResetN;}
  DataInPort    MBISTPG_DIAG_EN;
  DataInPort    BIST_SETUP2;
  DataInPort    BIST_SETUP[1:0];
  DataInPort    MBISTPG_REDUCED_ADDR_CNT_EN {RefEnum OnOff;}
  DataInPort    MBISTPG_MEM_RST {RefEnum OnOff;}
  DataInPort    MBISTPG_TESTDATA_SELECT {RefEnum OnOff;}
  DataInPort    FL_CNT_MODE[1:0];
  DataInPort    MBISTPG_ALGO_MODE[1:0];
  DataOutPort   MBISTPG_GO   {RefEnum PassFail;}
  DataOutPort   MBISTPG_DONE {RefEnum PassFail;}
  TCKPort       TCK;                       
  ScanInPort    BIST_SI;
  ScanOutPort   MBISTPG_SO {Source BIST_SO_INT;}
  ShiftEnPort   BIST_HOLD;
  ToShiftEnPort  BIST_SHIFT_COLLAR {Attribute connection_rule_option = "allowed_no_destination";}
  DataOutPort   BIST_COLLAR_EN0 {Attribute tessent_memory_alias = "m1";}
  ScanOutPort   MEM0_BIST_COLLAR_SI { Source MEM0_BIST_COLLAR_SI_INT;}
  ScanInPort    MEM0_BIST_COLLAR_SO;
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
  Alias        SETUP_MODE[2:0] = BIST_SETUP2,BIST_SETUP[1:0] { RefEnum SetupModes; }
  Alias        RUN_MODE[2:0]   = BIST_SETUP2,BIST_SETUP[1:0] { RefEnum RunModes; }
  Enum         PassFail {
                    Pass = 1'b1;
                    Fail = 1'b0;
                    Ignore = 1'bx;
               }
  Enum         AsyncResetN {
                    On = 1'b0;
                    Off = 1'b1;
               }
  Enum         SetupModes {
                    Short = 3'b000; 
                    Long  = 3'b001; 
               }
  Enum         OnOff {
                    On  = 1'b1;
                    Off = 1'b0;
               }
  Enum         RunModes   {
                    HWDefault   = 3'b010; 
                    RunTimeProg = 3'b011;
                    Idle        = 3'bx0x;
                    Off         = 3'bxxx;
               }
  LogicSignal  LONG_SETUP  { MBISTPG_EN,SETUP_MODE[2:0] == 1'b1,3'b001;}
  LogicSignal  SHORT_SETUP { MBISTPG_EN,SETUP_MODE[2:0] == 1'b1,3'b000;}
 
// [start] : LONG_SETUP / SHORT_SETUP chain registers {{{
  ScanRegister BIST_SI_Pipeline {
      ScanInSource   BIST_SI;
      ResetValue     1'b0;
  }
  ScanRegister DIAG_EN_REG[0:0] {
      ScanInSource   BIST_SI_Pipeline;
  }
  ScanRegister CMP_EN_MASK_EN[0:0] {
      ScanInSource   DIAG_EN_REG[0];
  }
  ScanRegister CMP_EN_PARITY[0:0] {
      CaptureSource   1'bx;
      ScanInSource   CMP_EN_MASK_EN[0];
  }
  ScanRegister MEM_SELECT_REG0[0:0] {
      ResetValue     1'd1;
      ScanInSource   CMP_EN_PARITY[0];
  }
  ScanRegister REDUCED_ADDR_CNT_EN_REG[0:0] {
      ScanInSource   MEM_SELECT_REG0[0];
      RefEnum        OnOff;
  }
  ScanRegister ALGO_SEL_CNT_REG[0:0] {
      ScanInSource   REDUCED_ADDR_CNT_EN_REG[0];
      RefEnum        OnOff;
  }
  ScanRegister SELECT_COMMON_OPSET_REG[0:0] {
      ScanInSource   ALGO_SEL_CNT_REG[0];
      RefEnum        OnOff;
  }
  ScanRegister SELECT_COMMON_DATA_PAT_REG[0:0] {
      ScanInSource   SELECT_COMMON_OPSET_REG[0];
      RefEnum        OnOff;
  }
  ScanRegister MICROCODE_EN_REG[0:0] {
      ScanInSource   SELECT_COMMON_DATA_PAT_REG[0];
  }
  ScanRegister INST_POINTER_REG_HW[0:5] {
      ScanInSource   MICROCODE_EN_REG[0];
  }
  Alias INST_POINTER_REG[5:0] = INST_POINTER_REG_HW[5:0];
  ScanRegister A_ADD_REG_Y_HW[0:3] {
      ScanInSource   INST_POINTER_REG_HW[5];
  }
  Alias A_ADD_REG_Y[3:0] = A_ADD_REG_Y_HW[3:0];
  ScanRegister A_ADD_REG_X_HW[0:8] {
      ScanInSource   A_ADD_REG_Y_HW[3];
  }
  Alias A_ADD_REG_X[8:0] = A_ADD_REG_X_HW[8:0];
  ScanRegister B_ADD_REG_Y_HW[0:3] {
      ScanInSource   A_ADD_REG_X_HW[8];
  }
  Alias B_ADD_REG_Y[3:0] = B_ADD_REG_Y_HW[3:0];
  ScanRegister B_ADD_REG_X_HW[0:8] {
      ScanInSource   B_ADD_REG_Y_HW[3];
  }
  Alias B_ADD_REG_X[8:0] = B_ADD_REG_X_HW[8:0];
  ScanRegister JCNT_HW[0:2] {
      ScanInSource   B_ADD_REG_X_HW[8];
  }
  Alias JCNT[2:0] = JCNT_HW[2:0];
  ScanRegister OPSET_SELECT_REG[0:0] {
      ScanInSource   JCNT_HW[2];
  }
  ScanRegister WDATA_REG_HW[0:1] {
      ScanInSource   OPSET_SELECT_REG[0];
  }
  Alias WDATA_REG[1:0] = WDATA_REG_HW[1:0];
  ScanRegister EDATA_REG_HW[0:1] {
      ScanInSource   WDATA_REG_HW[1];
  }
  Alias EDATA_REG[1:0] = EDATA_REG_HW[1:0];
  ScanRegister X_ADDR_BIT_SEL_REG[0:0] {
      ScanInSource   EDATA_REG_HW[1];
  }
  ScanRegister Y_ADDR_BIT_SEL_REG[0:0] {
      ScanInSource   X_ADDR_BIT_SEL_REG[0];
  }
  ScanRegister REPEATLOOP_A_CNTR_REG_HW[0:1] {
      ScanInSource   Y_ADDR_BIT_SEL_REG[0];
  }
  Alias REPEATLOOP_A_CNTR_REG[1:0] = REPEATLOOP_A_CNTR_REG_HW[1:0];
  ScanRegister REPEATLOOP_B_CNTR_REG_HW[0:1] {
      ScanInSource   REPEATLOOP_A_CNTR_REG_HW[1];
  }
  Alias REPEATLOOP_B_CNTR_REG[1:0] = REPEATLOOP_B_CNTR_REG_HW[1:0];
  Alias MEM0_BIST_COLLAR_SI_INT = REPEATLOOP_B_CNTR_REG_HW[1];
  ScanRegister STOP_ON_ERROR_REG[0:0] {
      ScanInSource   MEM0_BIST_COLLAR_SO;
  }
  ScanRegister FREEZE_STOP_ERROR_REG[0:0] {
      ScanInSource   STOP_ON_ERROR_REG[0];
  }
  ScanRegister STOP_ERROR_CNT_REG_HW[0:11] {
      ScanInSource   FREEZE_STOP_ERROR_REG[0];
  }
  Alias STOP_ERROR_CNT_REG[11:0] = STOP_ERROR_CNT_REG_HW[11:0];
 ScanMux CONTROLLER_SETUP_CHAIN SelectedBy MBISTPG_EN,SETUP_MODE[2:0] {
     1'b1,3'b00x : STOP_ERROR_CNT_REG_HW[11];
 }
// [end]   : LONG_SETUP / SHORT_SETUP chain registers }}}
  ScanMux BIST_SO_OUT SelectedBy LV_TM,MBISTPG_ASYNC_RESETN {
    2'b01 : CONTROLLER_SETUP_CHAIN;
  }
  ScanRegister BIST_SO_Pipeline {
      ScanInSource   BIST_SO_OUT;
      ResetValue     1'b0;
  }
  Alias BIST_SO_INT = BIST_SO_Pipeline;
  Attribute     tessent_instrument_container           = "memlibc_memory_bist_assembly_rtl_mbist";
  Attribute     tessent_instrument_type                = "mentor::memory_bist";
  Attribute     tessent_instrument_subtype             = "controller";
  Attribute     tessent_signature                      = "5ebf3b804074c35ce286d2e7896a98a5";
  Attribute     tessent_ignore_during_icl_verification = "on";
  Attribute     keep_active_during_scan_test           = "false";
  Attribute     tessent_use_in_dft_specification       = "false";
  Attribute     tessent_bist_clk_persistent_cell_output_list     = "tessent_persistent_cell_GATING_BIST_CLK/clkg";
}
