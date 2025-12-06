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
//       Created on: Sat Nov 15 20:33:15 EST 2025
//--------------------------------------------------------------------------

Module memlibc_memory_bist_assembly_rtl_tessent_sib_1 {
 
   ResetPort     ijtag_reset            { ActivePolarity 0;      }
   SelectPort    ijtag_sel;
   ScanInPort    ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort   ijtag_se;
   UpdateEnPort  ijtag_ue;
   TCKPort       ijtag_tck;
   ScanOutPort   ijtag_so               { Source sib;            }
   ToSelectPort  ijtag_to_sel           { 
     Attribute connection_rule_option = "allowed_no_destination"; 
   }
   ScanInPort    ijtag_from_so          { 
     Attribute connection_rule_option = "allowed_no_source"; 
   }
   ToResetPort   ijtag_to_reset         { Source ijtag_reset; ActivePolarity 0;}
   ScanOutPort   ijtag_to_si            { Source ijtag_si;
     Attribute connection_rule_option = "allowed_no_destination";
   }
   ToCaptureEnPort ijtag_to_ce          { Source ijtag_ce; 
     Attribute connection_rule_option = "allowed_no_destination";
   }
   ToShiftEnPort ijtag_to_se            { Source ijtag_se; 
     Attribute connection_rule_option = "allowed_no_destination";
   }
   ToUpdateEnPort ijtag_to_ue           { Source ijtag_ue; 
     Attribute connection_rule_option = "allowed_no_destination";
   }
   ToTCKPort     ijtag_to_tck           { 
     Attribute connection_rule_option = "allowed_no_destination";
   }
   DataInPort    ltest_en               {
     Attribute explicit_iwrite_only = 1'b1;
     Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort    ltest_occ_en           {
     Attribute explicit_iwrite_only = 1'b1;
     Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort    ltest_static_clock_control_mode                 {
     Attribute connection_rule_option = "allowed_tied_low";
   }
   DataInPort ltest_clock_sequence[1:0] {
    Attribute connection_rule_option = "allowed_no_source";
    Attribute tessent_use_in_dft_specification = "false";
    Attribute function_modifier = "tessent_clock_sequence";
  }
   DataOutPort   ltest_to_en            { 
     Attribute connection_rule_option = "allowed_no_destination";
     Source ltest_en;
   }
   DataInPort    ltest_mem_bypass_en    {
     Attribute connection_rule_option = "allowed_tied";
   }
   DataOutPort   ltest_to_mem_bypass_en                          { 
     Attribute connection_rule_option = "allowed_no_destination";
     Source ltest_to_mem_bypass_en_int;
   }
   DataInPort    ltest_mcp_bounding_en  {
     Attribute explicit_iwrite_only = 1'b1;
     Attribute connection_rule_option = "allowed_tied";
     Attribute forced_low_dft_signal_list = "ltest_en";
   }
   DataOutPort   ltest_to_mcp_bounding_en                        { 
     Attribute connection_rule_option = "allowed_no_destination";
     Source ltest_to_mcp_bounding_en_int;
   }
 
   ScanInterface client { 
     Port ijtag_si; 
     Port ijtag_so; 
     Port ijtag_sel;
   }
   ScanInterface host   { 
     Port ijtag_from_so; 
     Port ijtag_to_sel; 
     Port ijtag_to_si;
   }
  
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_dft_function = "scan_tested_instrument_host";
  
   LogicSignal ltest_to_mem_bypass_en_int {
     ltest_mem_bypass_en & ltest_en;
   }
   LogicSignal ltest_to_mcp_bounding_en_int {
     ltest_mcp_bounding_en & ltest_en;
   }
   
   ScanRegister sib {
     ScanInSource    scan_in_mux;
     CaptureSource   1'b0;
     ResetValue      1'b0;
   }
 
   ScanMux scan_in_mux SelectedBy sib,ltest_en {
     2'b10 : ijtag_from_so;
     2'bxx : ijtag_si;
   }
 
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type          = "mentor::ijtag_node";
   Attribute tessent_signature                = "c611f43c4f163e85c61d7983d96ff92b";
}
