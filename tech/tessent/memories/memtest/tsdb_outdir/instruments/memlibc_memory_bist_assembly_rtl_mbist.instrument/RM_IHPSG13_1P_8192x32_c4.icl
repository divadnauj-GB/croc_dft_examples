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

Module RM_IHPSG13_1P_8192x32_c4 {
  DataInPort                             A_ADDR[12:0] { 
    Attribute connection_rule_option = "allowed_no_source"; 
    Attribute tessent_memory_bist_function = "address";
  }
  ClockPort                              A_CLK;
  Attribute tessent_use_in_dft_specification = "false"; 
  Attribute keep_active_during_scan_test     = "false"; 
  Attribute tessent_memory_module            = "without_internal_scan_logic";
}
