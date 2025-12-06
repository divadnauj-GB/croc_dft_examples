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
//       Created on: Sat Nov 15 20:33:21 EST 2025
//--------------------------------------------------------------------------

Module memlibc_memory_bist_assembly_rtl_tessent_mbist_bap {
 
  ResetPort     reset                   { ActivePolarity 0;      }
  SelectPort    ijtag_select;
  ScanInPort    si;
  CaptureEnPort capture_en;
  ShiftEnPort   shift_en;
  ToShiftEnPort BIST_HOLD {Attribute connection_rule_option = "allowed_no_destination"; }
  UpdateEnPort  update_en;
  TCKPort       tck;
  DataInPort    memory_bypass_en { Attribute connection_rule_option = "allowed_tied_low"; }
  DataOutPort   memory_bypass_to_en     { Source memory_bypass_en; Attribute connection_rule_option = "allowed_no_destination"; }
  DataInPort    mcp_bounding_en { Attribute connection_rule_option = "allowed_tied_low"; }
  DataOutPort   mcp_bounding_to_en      { Source mcp_bounding_en; Attribute connection_rule_option = "allowed_no_destination"; }
  DataInPort    ltest_en { Attribute connection_rule_option = "allowed_tied_low"; DefaultLoadValue 0; }
  DataOutPort   ltest_to_en             { Source ltest_en; Attribute connection_rule_option = "allowed_no_destination"; }
  ScanOutPort   so                      { Source ctl_group_sib;  }
  ScanOutPort   toBist[0:0]             {
    Source toBist_int; 
    Attribute connection_rule_option = "allowed_no_destination";
  }
  ScanInPort    fromBist[0:0]            {
    Attribute connection_rule_option = "allowed_tied_low";
  }
  DataInPort    MBISTPG_GO[0:0] { Attribute connection_rule_option = "allowed_no_source"; }
  DataInPort    MBISTPG_DONE[0:0] { Attribute connection_rule_option = "allowed_no_source"; }
  DataOutPort   bistEn[0:0]             { 
    Source bistEn_int[0:0];
    Attribute connection_rule_option = "allowed_no_destination";
  }
  DataOutPort   ENABLE_MEM_RESET        {
    Source ENABLE_MEM_RESET_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   REDUCED_ADDRESS_COUNT   {
    Source REDUCED_ADDRESS_COUNT_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_SELECT_TEST_DATA   {
    Source BIST_SELECT_TEST_DATA_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_ALGO_MODE0         {
    Source BIST_ALGO_MODE0_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_ALGO_MODE1         {
    Source BIST_ALGO_MODE1_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_DIAG_EN            {
    Source BIST_DIAG_EN_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_ASYNC_RESET        {
    Source BIST_ASYNC_RESET_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   FL_CNT_MODE0            {
    Source FL_CNT_MODE0_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   FL_CNT_MODE1            {
    Source FL_CNT_MODE1_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   INCLUDE_MEM_RESULTS_REG {
    Source INCLUDE_MEM_RESULTS_REG_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   CHAIN_BYPASS_EN         {
    Source CHAIN_BYPASS_EN_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
  }
  DataOutPort   TCK_MODE                {
    Source TCK_MODE_tdr;
    Attribute connection_rule_option = "allowed_no_destination";
    RefEnum OnOff;
  }
  DataOutPort   BIST_SETUP[2:0]         {
    Source BIST_SETUP_tdr[2:0];
    Attribute connection_rule_option = "allowed_no_destination";
  }
  Attribute                             ijtag_logical_connection = "{tck to_interfaces_tck} {tck to_controllers_tck}";
  Enum                                  OnOff                    { 
    ON                                  = 1'b1; 
    OFF                                 = 1'b0; 
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
   Attribute keep_active_during_scan_test = "false";
 
  ScanRegister BIST_SETUP_tdr[2:0] {
    ScanInSource     si;
    CaptureSource    BIST_SETUP_tdr[2],
                     BIST_SETUP_tdr[1],
                     BIST_SETUP_tdr[0];
    ResetValue       3'b000;
    DefaultLoadValue 3'b000;
  }
  ScanRegister TCK_MODE_tdr {
    ScanInSource     BIST_SETUP_tdr[0];
    CaptureSource    TCK_MODE_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister CHAIN_BYPASS_EN_tdr {
    ScanInSource     TCK_MODE_tdr;
    CaptureSource    CHAIN_BYPASS_EN_tdr;
    ResetValue       1'b1;
    DefaultLoadValue 1'b1;
  }
  ScanRegister INCLUDE_MEM_RESULTS_REG_tdr {
    ScanInSource     CHAIN_BYPASS_EN_tdr;
    CaptureSource    INCLUDE_MEM_RESULTS_REG_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister FL_CNT_MODE1_tdr {
    ScanInSource     INCLUDE_MEM_RESULTS_REG_tdr;
    CaptureSource    FL_CNT_MODE1_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister FL_CNT_MODE0_tdr {
    ScanInSource     FL_CNT_MODE1_tdr;
    CaptureSource    FL_CNT_MODE0_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_ASYNC_RESET_tdr {
    ScanInSource     FL_CNT_MODE0_tdr;
    CaptureSource    BIST_ASYNC_RESET_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_DIAG_EN_tdr {
    ScanInSource     BIST_ASYNC_RESET_tdr;
    CaptureSource    BIST_DIAG_EN_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_ALGO_MODE1_tdr {
    ScanInSource     BIST_DIAG_EN_tdr;
    CaptureSource    BIST_ALGO_MODE1_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_ALGO_MODE0_tdr {
    ScanInSource     BIST_ALGO_MODE1_tdr;
    CaptureSource    BIST_ALGO_MODE0_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister BIST_SELECT_TEST_DATA_tdr {
    ScanInSource     BIST_ALGO_MODE0_tdr;
    CaptureSource    BIST_SELECT_TEST_DATA_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister REDUCED_ADDRESS_COUNT_tdr {
    ScanInSource     BIST_SELECT_TEST_DATA_tdr;
    CaptureSource    REDUCED_ADDRESS_COUNT_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister ENABLE_MEM_RESET_tdr {
    ScanInSource     REDUCED_ADDRESS_COUNT_tdr;
    CaptureSource    ENABLE_MEM_RESET_tdr;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  Alias tdr[14:0] = BIST_SETUP_tdr[2:0],
                     TCK_MODE_tdr,
                     CHAIN_BYPASS_EN_tdr,
                     INCLUDE_MEM_RESULTS_REG_tdr,
                     FL_CNT_MODE1_tdr,
                     FL_CNT_MODE0_tdr,
                     BIST_ASYNC_RESET_tdr,
                     BIST_DIAG_EN_tdr,
                     BIST_ALGO_MODE1_tdr,
                     BIST_ALGO_MODE0_tdr,
                     BIST_SELECT_TEST_DATA_tdr,
                     REDUCED_ADDRESS_COUNT_tdr,
                     ENABLE_MEM_RESET_tdr {
    RefEnum          tdr_symbols;
  }
  Enum tdr_symbols {
    idle              = 15'b000010001000100;
    ignore            = 15'bxxxxxxxxxxxxxxx;
    mbist_async_reset = 15'b000010000000000;
  }
  Alias ChainBypassMode = CHAIN_BYPASS_EN_tdr;
  ScanMux    tdr_bypass_sib_mux_inst SelectedBy tdr_bypass_sib_inst {
    1'b0 : si;
    1'b1 : ENABLE_MEM_RESET_tdr;
  }
  ScanRegister tdr_bypass_sib_inst {
    ScanInSource     tdr_bypass_sib_mux_inst;
    CaptureSource    1'b0;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanMux    fromBistMux_0 SelectedBy bistEn_int[0],BIST_SETUP_tdr[1],ChainBypassMode {
    3'b100 : fromBist[0];
    3'bxxx : tdr_bypass_sib_inst;
  }
  ScanRegister mbist_done_0 {
    ScanInSource     fromBistMux_0;
    CaptureSource    MBISTPG_DONE[0];
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanRegister mbist_go_0 {
    ScanInSource     mbist_done_0;
    CaptureSource    MBISTPG_GO[0];
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  ScanMux    ctl_sib_mux_inst SelectedBy ctl_group_sib {
    1'b0 : tdr_bypass_sib_inst;
    1'b1 : mbist_go_0;
  }
  ScanRegister ctl_group_sib {
    ScanInSource     ctl_sib_mux_inst;
    CaptureSource    1'b0;
    ResetValue       1'b0;
    DefaultLoadValue 1'b0;
  }
  Alias bistEn_int[0:0] = mbist_go_0;
  Alias toBist_int[0:0] = tdr_bypass_sib_inst;
 
  Attribute tessent_use_in_dft_specification = "false";
  Attribute tessent_instrument_type          = "mentor::memory_bist";
  Attribute tessent_instrument_subtype       = "bist_access_port";
  Attribute tessent_signature                = "bb5e722fbbe05b7088cc89efafe59fb8";
}
