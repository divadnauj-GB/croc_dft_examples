//
// Verilog format test patterns produced by Tessent FastScan 2022.3
// Filename       : pat.v
// Idstamp        : 2022.3:d213:51c2:13:1288
// Fault          : STUCK
// Coverage       : 100.00(TC) 99.63(FC)
// Date           : Thu Nov 13 13:42:48 2025
//
// Begin_Verify_Section 
//   format            = Verilog 
//   top_module_name   = MGC_DFT_LIB_ALL_pat_v_ctl 
//   serial_flag       = OFF 
//   test_set_type     = ALL_TEST 
//   pad_value         = X 
//   pattern_begin     = 0 
//   pattern_end       = 12 
//   one_setup         = ON 
//   no_initialization = ON 
//   pattern_checksum  = 17661 
// End_Verify_Section 

`define SIM_INSTANCE_NAME MGC_DFT_LIB_ALL_inst


`timescale 1ns / 1ns

module MGC_DFT_LIB_ALL_pat_v_ctl;

integer     _write_DIAG_file;
integer     _DIAG_file_header;
integer     _diag_file;
integer     _diag_chain_header;
integer     _diag_scan_header;
integer     _last_fail_pattern;
integer     _fail_pattern_cnt;
integer     _write_MASK_file;
integer     _MASK_file_header;
integer     _mask_file;
integer     _par_shift_cnt;
integer     _chain_test_;
integer     _compare_fail;
integer     _bit_count;
integer     _report_bit_cnt;
integer     _miscompare_limit;
integer     _found_fail;
integer     _found_fail_per_cycle;
reg[85:0]    _found_fail_obus;
integer     _end_vec_file_ok;
integer     _cycle_count, _save_cycle_count;
integer     _pattern_count, _repeat_count_nest[0:8], _repeat_count, _message_index;
integer     _index, _scan_index, _file_cnt, _max_index, _vec_pat_count, _save_index[0:8];
integer     _repeat_depth;
integer     _file_check;
integer     _run_testsetup;
integer     _in_testsetup;
integer     _start_pat;
integer     _end_pat;
integer     _end_after_setup;
integer     _no_setup;
integer     _save_state;
integer     _restart_state;
integer     _in_restart;
integer     _override_cfg;
integer     _in_range;
integer     _do_compare;
integer     _in_chaintest;
integer     _pat_num;
integer     _skipped_patterns;
integer     _end_simulation;
integer     _config_file;
integer     _fstat;
integer     _max_file_cnt;
reg[256*8:1] _vec_file_name;
reg[256*8:1] _cfg_file_name;
integer     _scan_shift_count;
reg[203:0]    _ibus;
reg[85:0]    _exp_obus, _msk_obus;
wire[85:0]   _sim_obus;
reg[2:0]    _pat_type;
reg         _tp_num;
reg         mgcdft_save_signal, mgcdft_restart_signal;
reg[384:0]   vect;

wire sg13g2_a21o_1__A1, sg13g2_a21o_1__A2, sg13g2_a21o_1__B1, sg13g2_a21o_2__A1, 
     sg13g2_a21o_2__A2, sg13g2_a21o_2__B1, sg13g2_a21oi_1__A1, sg13g2_a21oi_1__A2, 
     sg13g2_a21oi_1__B1, sg13g2_a21oi_2__A1, sg13g2_a21oi_2__A2, sg13g2_a21oi_2__B1, 
     sg13g2_a221oi_1__A1, sg13g2_a221oi_1__A2, sg13g2_a221oi_1__B1, 
     sg13g2_a221oi_1__B2, sg13g2_a221oi_1__C1, sg13g2_a22oi_1__A1, 
     sg13g2_a22oi_1__A2, sg13g2_a22oi_1__B1, sg13g2_a22oi_1__B2, sg13g2_and2_1__A, 
     sg13g2_and2_1__B, sg13g2_and2_2__A, sg13g2_and2_2__B, sg13g2_and3_1__A, 
     sg13g2_and3_1__B, sg13g2_and3_1__C, sg13g2_and3_2__A, sg13g2_and3_2__B, 
     sg13g2_and3_2__C, sg13g2_and4_1__A, sg13g2_and4_1__B, sg13g2_and4_1__C, 
     sg13g2_and4_1__D, sg13g2_and4_2__A, sg13g2_and4_2__B, sg13g2_and4_2__C, 
     sg13g2_and4_2__D, sg13g2_antennanp__A, sg13g2_buf_1__A, sg13g2_buf_16__A, 
     sg13g2_buf_2__A, sg13g2_buf_4__A, sg13g2_buf_8__A, sg13g2_dfrbp_1__CLK, 
     sg13g2_dfrbp_1__D, sg13g2_dfrbp_1__RESET_B, sg13g2_dfrbp_2__CLK, 
     sg13g2_dfrbp_2__D, sg13g2_dfrbp_2__RESET_B, sg13g2_dfrbpq_1__CLK, 
     sg13g2_dfrbpq_1__D, sg13g2_dfrbpq_1__RESET_B, sg13g2_dfrbpq_2__CLK, 
     sg13g2_dfrbpq_2__D, sg13g2_dfrbpq_2__RESET_B, sg13g2_dlhq_1__D, 
     sg13g2_dlhq_1__GATE, sg13g2_dlhr_1__D, sg13g2_dlhr_1__GATE, sg13g2_dlhr_1__RESET_B, 
     sg13g2_dlhrq_1__D, sg13g2_dlhrq_1__GATE, sg13g2_dlhrq_1__RESET_B, 
     sg13g2_dllr_1__D, sg13g2_dllr_1__GATE_N, sg13g2_dllr_1__RESET_B, 
     sg13g2_dllrq_1__D, sg13g2_dllrq_1__GATE_N, sg13g2_dllrq_1__RESET_B, 
     sg13g2_dlygate4sd1_1__A, sg13g2_dlygate4sd2_1__A, sg13g2_dlygate4sd3_1__A, 
     sg13g2_ebufn_2__A, sg13g2_ebufn_2__TE_B, sg13g2_ebufn_4__A, sg13g2_ebufn_4__TE_B, 
     sg13g2_ebufn_8__A, sg13g2_ebufn_8__TE_B, sg13g2_einvn_2__A, sg13g2_einvn_2__TE_B, 
     sg13g2_einvn_4__A, sg13g2_einvn_4__TE_B, sg13g2_einvn_8__A, sg13g2_einvn_8__TE_B, 
     sg13g2_inv_1__A, sg13g2_inv_16__A, sg13g2_inv_2__A, sg13g2_inv_4__A, 
     sg13g2_inv_8__A, sg13g2_lgcp_1_$_int_GATE__CLK, sg13g2_lgcp_1_$_int_GATE__GATE, 
     sg13g2_lgcp_1__CLK, sg13g2_lgcp_1__GATE, sg13g2_mux2_1__A0, sg13g2_mux2_1__A1, 
     sg13g2_mux2_1__S, sg13g2_mux2_2__A0, sg13g2_mux2_2__A1, sg13g2_mux2_2__S, 
     sg13g2_mux4_1__A0, sg13g2_mux4_1__A1, sg13g2_mux4_1__A2, sg13g2_mux4_1__A3, 
     sg13g2_mux4_1__S0, sg13g2_mux4_1__S1, sg13g2_nand2_1__A, sg13g2_nand2_1__B, 
     sg13g2_nand2_2__A, sg13g2_nand2_2__B, sg13g2_nand2b_1__A_N, sg13g2_nand2b_1__B, 
     sg13g2_nand2b_2__A_N, sg13g2_nand2b_2__B, sg13g2_nand3_1__A, sg13g2_nand3_1__B, 
     sg13g2_nand3_1__C, sg13g2_nand3b_1__A_N, sg13g2_nand3b_1__B, sg13g2_nand3b_1__C, 
     sg13g2_nand4_1__A, sg13g2_nand4_1__B, sg13g2_nand4_1__C, sg13g2_nand4_1__D, 
     sg13g2_nor2_1__A, sg13g2_nor2_1__B, sg13g2_nor2_2__A, sg13g2_nor2_2__B, 
     sg13g2_nor2b_1__A, sg13g2_nor2b_1__B_N, sg13g2_nor2b_2__A, sg13g2_nor2b_2__B_N, 
     sg13g2_nor3_1__A, sg13g2_nor3_1__B, sg13g2_nor3_1__C, sg13g2_nor3_2__A, 
     sg13g2_nor3_2__B, sg13g2_nor3_2__C, sg13g2_nor4_1__A, sg13g2_nor4_1__B, 
     sg13g2_nor4_1__C, sg13g2_nor4_1__D, sg13g2_nor4_2__A, sg13g2_nor4_2__B, 
     sg13g2_nor4_2__C, sg13g2_nor4_2__D, sg13g2_o21ai_1__A1, sg13g2_o21ai_1__A2, 
     sg13g2_o21ai_1__B1, sg13g2_or2_1__A, sg13g2_or2_1__B, sg13g2_or2_2__A, 
     sg13g2_or2_2__B, sg13g2_or3_1__A, sg13g2_or3_1__B, sg13g2_or3_1__C, 
     sg13g2_or3_2__A, sg13g2_or3_2__B, sg13g2_or3_2__C, sg13g2_or4_1__A, 
     sg13g2_or4_1__B, sg13g2_or4_1__C, sg13g2_or4_1__D, sg13g2_or4_2__A, 
     sg13g2_or4_2__B, sg13g2_or4_2__C, sg13g2_or4_2__D, sg13g2_sdfbbp_1__CLK, 
     sg13g2_sdfbbp_1__D, sg13g2_sdfbbp_1__RESET_B, sg13g2_sdfbbp_1__SCD, 
     sg13g2_sdfbbp_1__SCE, sg13g2_sdfbbp_1__SET_B, sg13g2_sdfrbp_1__CLK, 
     sg13g2_sdfrbp_1__D, sg13g2_sdfrbp_1__RESET_B, sg13g2_sdfrbp_1__SCD, 
     sg13g2_sdfrbp_1__SCE, sg13g2_sdfrbp_2__CLK, sg13g2_sdfrbp_2__D, 
     sg13g2_sdfrbp_2__RESET_B, sg13g2_sdfrbp_2__SCD, sg13g2_sdfrbp_2__SCE, 
     sg13g2_sdfrbpq_1__CLK, sg13g2_sdfrbpq_1__D, sg13g2_sdfrbpq_1__RESET_B, 
     sg13g2_sdfrbpq_1__SCD, sg13g2_sdfrbpq_1__SCE, sg13g2_sdfrbpq_2__CLK, 
     sg13g2_sdfrbpq_2__D, sg13g2_sdfrbpq_2__RESET_B, sg13g2_sdfrbpq_2__SCD, 
     sg13g2_sdfrbpq_2__SCE, sg13g2_slgcp_1_$_int_GATE__CLK, sg13g2_slgcp_1_$_int_GATE__GATE, 
     sg13g2_slgcp_1_$_int_GATE__SCE, sg13g2_slgcp_1__CLK, sg13g2_slgcp_1__GATE, 
     sg13g2_slgcp_1__SCE, sg13g2_xnor2_1__A, sg13g2_xnor2_1__B, sg13g2_xor2_1__A, 
     sg13g2_xor2_1__B, sg13g2_sighold__SH, sg13g2_a21o_1__X, sg13g2_a21o_2__X, 
     sg13g2_a21oi_1__Y, sg13g2_a21oi_2__Y, sg13g2_a221oi_1__Y, sg13g2_a22oi_1__Y, 
     sg13g2_and2_1__X, sg13g2_and2_2__X, sg13g2_and3_1__X, sg13g2_and3_2__X, 
     sg13g2_and4_1__X, sg13g2_and4_2__X, sg13g2_buf_1__X, sg13g2_buf_16__X, 
     sg13g2_buf_2__X, sg13g2_buf_4__X, sg13g2_buf_8__X, sg13g2_dfrbp_1__Q, 
     sg13g2_dfrbp_1__Q_N, sg13g2_dfrbp_2__Q, sg13g2_dfrbp_2__Q_N, sg13g2_dfrbpq_1__Q, 
     sg13g2_dfrbpq_2__Q, sg13g2_dlhq_1__Q, sg13g2_dlhr_1__Q, sg13g2_dlhr_1__Q_N, 
     sg13g2_dlhrq_1__Q, sg13g2_dllr_1__Q, sg13g2_dllr_1__Q_N, sg13g2_dllrq_1__Q, 
     sg13g2_dlygate4sd1_1__X, sg13g2_dlygate4sd2_1__X, sg13g2_dlygate4sd3_1__X, 
     sg13g2_ebufn_2__Z, sg13g2_ebufn_4__Z, sg13g2_ebufn_8__Z, sg13g2_einvn_2__Z, 
     sg13g2_einvn_4__Z, sg13g2_einvn_8__Z, sg13g2_inv_1__Y, sg13g2_inv_16__Y, 
     sg13g2_inv_2__Y, sg13g2_inv_4__Y, sg13g2_inv_8__Y, sg13g2_lgcp_1_$_int_GATE__int_GATE, 
     sg13g2_lgcp_1__GCLK, sg13g2_mux2_1__X, sg13g2_mux2_2__X, sg13g2_mux4_1__X, 
     sg13g2_nand2_1__Y, sg13g2_nand2_2__Y, sg13g2_nand2b_1__Y, sg13g2_nand2b_2__Y, 
     sg13g2_nand3_1__Y, sg13g2_nand3b_1__Y, sg13g2_nand4_1__Y, sg13g2_nor2_1__Y, 
     sg13g2_nor2_2__Y, sg13g2_nor2b_1__Y, sg13g2_nor2b_2__Y, sg13g2_nor3_1__Y, 
     sg13g2_nor3_2__Y, sg13g2_nor4_1__Y, sg13g2_nor4_2__Y, sg13g2_o21ai_1__Y, 
     sg13g2_or2_1__X, sg13g2_or2_2__X, sg13g2_or3_1__X, sg13g2_or3_2__X, 
     sg13g2_or4_1__X, sg13g2_or4_2__X, sg13g2_sdfbbp_1__Q, sg13g2_sdfbbp_1__Q_N, 
     sg13g2_sdfrbp_1__Q, sg13g2_sdfrbp_1__Q_N, sg13g2_sdfrbp_2__Q, 
     sg13g2_sdfrbp_2__Q_N, sg13g2_sdfrbpq_1__Q, sg13g2_sdfrbpq_2__Q, 
     sg13g2_slgcp_1_$_int_GATE__int_GATE, sg13g2_slgcp_1__GCLK, sg13g2_tiehi__L_HI, 
     sg13g2_tielo__L_LO, sg13g2_xnor2_1__Y, sg13g2_xor2_1__X;

event       before_finish;
assign sg13g2_a21o_1__A1 = _ibus[203];
assign sg13g2_a21o_1__A2 = _ibus[202];
assign sg13g2_a21o_1__B1 = _ibus[201];
assign sg13g2_a21o_2__A1 = _ibus[200];
assign sg13g2_a21o_2__A2 = _ibus[199];
assign sg13g2_a21o_2__B1 = _ibus[198];
assign sg13g2_a21oi_1__A1 = _ibus[197];
assign sg13g2_a21oi_1__A2 = _ibus[196];
assign sg13g2_a21oi_1__B1 = _ibus[195];
assign sg13g2_a21oi_2__A1 = _ibus[194];
assign sg13g2_a21oi_2__A2 = _ibus[193];
assign sg13g2_a21oi_2__B1 = _ibus[192];
assign sg13g2_a221oi_1__A1 = _ibus[191];
assign sg13g2_a221oi_1__A2 = _ibus[190];
assign sg13g2_a221oi_1__B1 = _ibus[189];
assign sg13g2_a221oi_1__B2 = _ibus[188];
assign sg13g2_a221oi_1__C1 = _ibus[187];
assign sg13g2_a22oi_1__A1 = _ibus[186];
assign sg13g2_a22oi_1__A2 = _ibus[185];
assign sg13g2_a22oi_1__B1 = _ibus[184];
assign sg13g2_a22oi_1__B2 = _ibus[183];
assign sg13g2_and2_1__A = _ibus[182];
assign sg13g2_and2_1__B = _ibus[181];
assign sg13g2_and2_2__A = _ibus[180];
assign sg13g2_and2_2__B = _ibus[179];
assign sg13g2_and3_1__A = _ibus[178];
assign sg13g2_and3_1__B = _ibus[177];
assign sg13g2_and3_1__C = _ibus[176];
assign sg13g2_and3_2__A = _ibus[175];
assign sg13g2_and3_2__B = _ibus[174];
assign sg13g2_and3_2__C = _ibus[173];
assign sg13g2_and4_1__A = _ibus[172];
assign sg13g2_and4_1__B = _ibus[171];
assign sg13g2_and4_1__C = _ibus[170];
assign sg13g2_and4_1__D = _ibus[169];
assign sg13g2_and4_2__A = _ibus[168];
assign sg13g2_and4_2__B = _ibus[167];
assign sg13g2_and4_2__C = _ibus[166];
assign sg13g2_and4_2__D = _ibus[165];
assign sg13g2_antennanp__A = 1'b0;
assign sg13g2_buf_1__A = _ibus[164];
assign sg13g2_buf_16__A = _ibus[163];
assign sg13g2_buf_2__A = _ibus[162];
assign sg13g2_buf_4__A = _ibus[161];
assign sg13g2_buf_8__A = _ibus[160];
assign sg13g2_dfrbp_1__CLK = _ibus[159];
assign sg13g2_dfrbp_1__D = _ibus[158];
assign sg13g2_dfrbp_1__RESET_B = _ibus[157];
assign sg13g2_dfrbp_2__CLK = _ibus[156];
assign sg13g2_dfrbp_2__D = _ibus[155];
assign sg13g2_dfrbp_2__RESET_B = _ibus[154];
assign sg13g2_dfrbpq_1__CLK = _ibus[153];
assign sg13g2_dfrbpq_1__D = _ibus[152];
assign sg13g2_dfrbpq_1__RESET_B = _ibus[151];
assign sg13g2_dfrbpq_2__CLK = _ibus[150];
assign sg13g2_dfrbpq_2__D = _ibus[149];
assign sg13g2_dfrbpq_2__RESET_B = _ibus[148];
assign sg13g2_dlhq_1__D = _ibus[147];
assign sg13g2_dlhq_1__GATE = _ibus[146];
assign sg13g2_dlhr_1__D = _ibus[145];
assign sg13g2_dlhr_1__GATE = _ibus[144];
assign sg13g2_dlhr_1__RESET_B = _ibus[143];
assign sg13g2_dlhrq_1__D = _ibus[142];
assign sg13g2_dlhrq_1__GATE = _ibus[141];
assign sg13g2_dlhrq_1__RESET_B = _ibus[140];
assign sg13g2_dllr_1__D = _ibus[139];
assign sg13g2_dllr_1__GATE_N = _ibus[138];
assign sg13g2_dllr_1__RESET_B = _ibus[137];
assign sg13g2_dllrq_1__D = _ibus[136];
assign sg13g2_dllrq_1__GATE_N = _ibus[135];
assign sg13g2_dllrq_1__RESET_B = _ibus[134];
assign sg13g2_dlygate4sd1_1__A = _ibus[133];
assign sg13g2_dlygate4sd2_1__A = _ibus[132];
assign sg13g2_dlygate4sd3_1__A = _ibus[131];
assign sg13g2_ebufn_2__A = _ibus[130];
assign sg13g2_ebufn_2__TE_B = _ibus[129];
assign sg13g2_ebufn_4__A = _ibus[128];
assign sg13g2_ebufn_4__TE_B = _ibus[127];
assign sg13g2_ebufn_8__A = _ibus[126];
assign sg13g2_ebufn_8__TE_B = _ibus[125];
assign sg13g2_einvn_2__A = _ibus[124];
assign sg13g2_einvn_2__TE_B = _ibus[123];
assign sg13g2_einvn_4__A = _ibus[122];
assign sg13g2_einvn_4__TE_B = _ibus[121];
assign sg13g2_einvn_8__A = _ibus[120];
assign sg13g2_einvn_8__TE_B = _ibus[119];
assign sg13g2_inv_1__A = _ibus[118];
assign sg13g2_inv_16__A = _ibus[117];
assign sg13g2_inv_2__A = _ibus[116];
assign sg13g2_inv_4__A = _ibus[115];
assign sg13g2_inv_8__A = _ibus[114];
assign sg13g2_lgcp_1_$_int_GATE__CLK = _ibus[113];
assign sg13g2_lgcp_1_$_int_GATE__GATE = _ibus[112];
assign sg13g2_lgcp_1__CLK = _ibus[111];
assign sg13g2_lgcp_1__GATE = _ibus[110];
assign sg13g2_mux2_1__A0 = _ibus[109];
assign sg13g2_mux2_1__A1 = _ibus[108];
assign sg13g2_mux2_1__S = _ibus[107];
assign sg13g2_mux2_2__A0 = _ibus[106];
assign sg13g2_mux2_2__A1 = _ibus[105];
assign sg13g2_mux2_2__S = _ibus[104];
assign sg13g2_mux4_1__A0 = _ibus[103];
assign sg13g2_mux4_1__A1 = _ibus[102];
assign sg13g2_mux4_1__A2 = _ibus[101];
assign sg13g2_mux4_1__A3 = _ibus[100];
assign sg13g2_mux4_1__S0 = _ibus[99];
assign sg13g2_mux4_1__S1 = _ibus[98];
assign sg13g2_nand2_1__A = _ibus[97];
assign sg13g2_nand2_1__B = _ibus[96];
assign sg13g2_nand2_2__A = _ibus[95];
assign sg13g2_nand2_2__B = _ibus[94];
assign sg13g2_nand2b_1__A_N = _ibus[93];
assign sg13g2_nand2b_1__B = _ibus[92];
assign sg13g2_nand2b_2__A_N = _ibus[91];
assign sg13g2_nand2b_2__B = _ibus[90];
assign sg13g2_nand3_1__A = _ibus[89];
assign sg13g2_nand3_1__B = _ibus[88];
assign sg13g2_nand3_1__C = _ibus[87];
assign sg13g2_nand3b_1__A_N = _ibus[86];
assign sg13g2_nand3b_1__B = _ibus[85];
assign sg13g2_nand3b_1__C = _ibus[84];
assign sg13g2_nand4_1__A = _ibus[83];
assign sg13g2_nand4_1__B = _ibus[82];
assign sg13g2_nand4_1__C = _ibus[81];
assign sg13g2_nand4_1__D = _ibus[80];
assign sg13g2_nor2_1__A = _ibus[79];
assign sg13g2_nor2_1__B = _ibus[78];
assign sg13g2_nor2_2__A = _ibus[77];
assign sg13g2_nor2_2__B = _ibus[76];
assign sg13g2_nor2b_1__A = _ibus[75];
assign sg13g2_nor2b_1__B_N = _ibus[74];
assign sg13g2_nor2b_2__A = _ibus[73];
assign sg13g2_nor2b_2__B_N = _ibus[72];
assign sg13g2_nor3_1__A = _ibus[71];
assign sg13g2_nor3_1__B = _ibus[70];
assign sg13g2_nor3_1__C = _ibus[69];
assign sg13g2_nor3_2__A = _ibus[68];
assign sg13g2_nor3_2__B = _ibus[67];
assign sg13g2_nor3_2__C = _ibus[66];
assign sg13g2_nor4_1__A = _ibus[65];
assign sg13g2_nor4_1__B = _ibus[64];
assign sg13g2_nor4_1__C = _ibus[63];
assign sg13g2_nor4_1__D = _ibus[62];
assign sg13g2_nor4_2__A = _ibus[61];
assign sg13g2_nor4_2__B = _ibus[60];
assign sg13g2_nor4_2__C = _ibus[59];
assign sg13g2_nor4_2__D = _ibus[58];
assign sg13g2_o21ai_1__A1 = _ibus[57];
assign sg13g2_o21ai_1__A2 = _ibus[56];
assign sg13g2_o21ai_1__B1 = _ibus[55];
assign sg13g2_or2_1__A = _ibus[54];
assign sg13g2_or2_1__B = _ibus[53];
assign sg13g2_or2_2__A = _ibus[52];
assign sg13g2_or2_2__B = _ibus[51];
assign sg13g2_or3_1__A = _ibus[50];
assign sg13g2_or3_1__B = _ibus[49];
assign sg13g2_or3_1__C = _ibus[48];
assign sg13g2_or3_2__A = _ibus[47];
assign sg13g2_or3_2__B = _ibus[46];
assign sg13g2_or3_2__C = _ibus[45];
assign sg13g2_or4_1__A = _ibus[44];
assign sg13g2_or4_1__B = _ibus[43];
assign sg13g2_or4_1__C = _ibus[42];
assign sg13g2_or4_1__D = _ibus[41];
assign sg13g2_or4_2__A = _ibus[40];
assign sg13g2_or4_2__B = _ibus[39];
assign sg13g2_or4_2__C = _ibus[38];
assign sg13g2_or4_2__D = _ibus[37];
assign sg13g2_sdfbbp_1__CLK = _ibus[36];
assign sg13g2_sdfbbp_1__D = _ibus[35];
assign sg13g2_sdfbbp_1__RESET_B = _ibus[34];
assign sg13g2_sdfbbp_1__SCD = _ibus[33];
assign sg13g2_sdfbbp_1__SCE = _ibus[32];
assign sg13g2_sdfbbp_1__SET_B = _ibus[31];
assign sg13g2_sdfrbp_1__CLK = _ibus[30];
assign sg13g2_sdfrbp_1__D = _ibus[29];
assign sg13g2_sdfrbp_1__RESET_B = _ibus[28];
assign sg13g2_sdfrbp_1__SCD = _ibus[27];
assign sg13g2_sdfrbp_1__SCE = _ibus[26];
assign sg13g2_sdfrbp_2__CLK = _ibus[25];
assign sg13g2_sdfrbp_2__D = _ibus[24];
assign sg13g2_sdfrbp_2__RESET_B = _ibus[23];
assign sg13g2_sdfrbp_2__SCD = _ibus[22];
assign sg13g2_sdfrbp_2__SCE = _ibus[21];
assign sg13g2_sdfrbpq_1__CLK = _ibus[20];
assign sg13g2_sdfrbpq_1__D = _ibus[19];
assign sg13g2_sdfrbpq_1__RESET_B = _ibus[18];
assign sg13g2_sdfrbpq_1__SCD = _ibus[17];
assign sg13g2_sdfrbpq_1__SCE = _ibus[16];
assign sg13g2_sdfrbpq_2__CLK = _ibus[15];
assign sg13g2_sdfrbpq_2__D = _ibus[14];
assign sg13g2_sdfrbpq_2__RESET_B = _ibus[13];
assign sg13g2_sdfrbpq_2__SCD = _ibus[12];
assign sg13g2_sdfrbpq_2__SCE = _ibus[11];
assign sg13g2_slgcp_1_$_int_GATE__CLK = _ibus[10];
assign sg13g2_slgcp_1_$_int_GATE__GATE = _ibus[9];
assign sg13g2_slgcp_1_$_int_GATE__SCE = _ibus[8];
assign sg13g2_slgcp_1__CLK = _ibus[7];
assign sg13g2_slgcp_1__GATE = _ibus[6];
assign sg13g2_slgcp_1__SCE = _ibus[5];
assign sg13g2_xnor2_1__A = _ibus[4];
assign sg13g2_xnor2_1__B = _ibus[3];
assign sg13g2_xor2_1__A = _ibus[2];
assign sg13g2_xor2_1__B = _ibus[1];
assign sg13g2_sighold__SH = _ibus[0];

assign _sim_obus[85] = sg13g2_a21o_1__X;
assign _sim_obus[84] = sg13g2_a21o_2__X;
assign _sim_obus[83] = sg13g2_a21oi_1__Y;
assign _sim_obus[82] = sg13g2_a21oi_2__Y;
assign _sim_obus[81] = sg13g2_a221oi_1__Y;
assign _sim_obus[80] = sg13g2_a22oi_1__Y;
assign _sim_obus[79] = sg13g2_and2_1__X;
assign _sim_obus[78] = sg13g2_and2_2__X;
assign _sim_obus[77] = sg13g2_and3_1__X;
assign _sim_obus[76] = sg13g2_and3_2__X;
assign _sim_obus[75] = sg13g2_and4_1__X;
assign _sim_obus[74] = sg13g2_and4_2__X;
assign _sim_obus[73] = sg13g2_buf_1__X;
assign _sim_obus[72] = sg13g2_buf_16__X;
assign _sim_obus[71] = sg13g2_buf_2__X;
assign _sim_obus[70] = sg13g2_buf_4__X;
assign _sim_obus[69] = sg13g2_buf_8__X;
assign _sim_obus[68] = sg13g2_dfrbp_1__Q;
assign _sim_obus[67] = sg13g2_dfrbp_1__Q_N;
assign _sim_obus[66] = sg13g2_dfrbp_2__Q;
assign _sim_obus[65] = sg13g2_dfrbp_2__Q_N;
assign _sim_obus[64] = sg13g2_dfrbpq_1__Q;
assign _sim_obus[63] = sg13g2_dfrbpq_2__Q;
assign _sim_obus[62] = sg13g2_dlhq_1__Q;
assign _sim_obus[61] = sg13g2_dlhr_1__Q;
assign _sim_obus[60] = sg13g2_dlhr_1__Q_N;
assign _sim_obus[59] = sg13g2_dlhrq_1__Q;
assign _sim_obus[58] = sg13g2_dllr_1__Q;
assign _sim_obus[57] = sg13g2_dllr_1__Q_N;
assign _sim_obus[56] = sg13g2_dllrq_1__Q;
assign _sim_obus[55] = sg13g2_dlygate4sd1_1__X;
assign _sim_obus[54] = sg13g2_dlygate4sd2_1__X;
assign _sim_obus[53] = sg13g2_dlygate4sd3_1__X;
assign _sim_obus[52] = sg13g2_ebufn_2__Z;
assign _sim_obus[51] = sg13g2_ebufn_4__Z;
assign _sim_obus[50] = sg13g2_ebufn_8__Z;
assign _sim_obus[49] = sg13g2_einvn_2__Z;
assign _sim_obus[48] = sg13g2_einvn_4__Z;
assign _sim_obus[47] = sg13g2_einvn_8__Z;
assign _sim_obus[46] = sg13g2_inv_1__Y;
assign _sim_obus[45] = sg13g2_inv_16__Y;
assign _sim_obus[44] = sg13g2_inv_2__Y;
assign _sim_obus[43] = sg13g2_inv_4__Y;
assign _sim_obus[42] = sg13g2_inv_8__Y;
assign _sim_obus[41] = sg13g2_lgcp_1_$_int_GATE__int_GATE;
assign _sim_obus[40] = sg13g2_lgcp_1__GCLK;
assign _sim_obus[39] = sg13g2_mux2_1__X;
assign _sim_obus[38] = sg13g2_mux2_2__X;
assign _sim_obus[37] = sg13g2_mux4_1__X;
assign _sim_obus[36] = sg13g2_nand2_1__Y;
assign _sim_obus[35] = sg13g2_nand2_2__Y;
assign _sim_obus[34] = sg13g2_nand2b_1__Y;
assign _sim_obus[33] = sg13g2_nand2b_2__Y;
assign _sim_obus[32] = sg13g2_nand3_1__Y;
assign _sim_obus[31] = sg13g2_nand3b_1__Y;
assign _sim_obus[30] = sg13g2_nand4_1__Y;
assign _sim_obus[29] = sg13g2_nor2_1__Y;
assign _sim_obus[28] = sg13g2_nor2_2__Y;
assign _sim_obus[27] = sg13g2_nor2b_1__Y;
assign _sim_obus[26] = sg13g2_nor2b_2__Y;
assign _sim_obus[25] = sg13g2_nor3_1__Y;
assign _sim_obus[24] = sg13g2_nor3_2__Y;
assign _sim_obus[23] = sg13g2_nor4_1__Y;
assign _sim_obus[22] = sg13g2_nor4_2__Y;
assign _sim_obus[21] = sg13g2_o21ai_1__Y;
assign _sim_obus[20] = sg13g2_or2_1__X;
assign _sim_obus[19] = sg13g2_or2_2__X;
assign _sim_obus[18] = sg13g2_or3_1__X;
assign _sim_obus[17] = sg13g2_or3_2__X;
assign _sim_obus[16] = sg13g2_or4_1__X;
assign _sim_obus[15] = sg13g2_or4_2__X;
assign _sim_obus[14] = sg13g2_sdfbbp_1__Q;
assign _sim_obus[13] = sg13g2_sdfbbp_1__Q_N;
assign _sim_obus[12] = sg13g2_sdfrbp_1__Q;
assign _sim_obus[11] = sg13g2_sdfrbp_1__Q_N;
assign _sim_obus[10] = sg13g2_sdfrbp_2__Q;
assign _sim_obus[9] = sg13g2_sdfrbp_2__Q_N;
assign _sim_obus[8] = sg13g2_sdfrbpq_1__Q;
assign _sim_obus[7] = sg13g2_sdfrbpq_2__Q;
assign _sim_obus[6] = sg13g2_slgcp_1_$_int_GATE__int_GATE;
assign _sim_obus[5] = sg13g2_slgcp_1__GCLK;
assign _sim_obus[4] = sg13g2_tiehi__L_HI;
assign _sim_obus[3] = sg13g2_tielo__L_LO;
assign _sim_obus[2] = sg13g2_xnor2_1__Y;
assign _sim_obus[1] = sg13g2_xor2_1__X;
assign _sim_obus[0] = sg13g2_sighold__SH;

// Change Path Variables & Get Argument 
integer      _change_path; 
integer      _change_out_path; 
reg[512*8:1]  _new_path; 
reg[512*8:1]  _new_out_path; 
reg[512*8:1]  _new_filename; 
reg[512*8:1]  _vcd_dump_file_name; 
reg[512*8:1]  _utvcd_dump_file_name; 
reg[512*8:1]  _fsdb_dump_file_name; 
reg[512*8:1]  _qwave_dump_file_name; 
reg[512*8:1]  _tmp_filename; 
initial begin 
  _change_path = 0; 
  _change_out_path = 0; 
  if ($value$plusargs("NEWPATH=%s", _new_path)) begin 
    $display("Found New Path %0s\n", _new_path); 
    _change_path = 1; 
  end 
  if ($value$plusargs("NEWOUTPATH=%s", _new_out_path)) begin 
    $display("Found New Out Path %0s\n", _new_out_path); 
    _change_out_path = 1; 
  end 

`ifdef VCD
    $sformat(_vcd_dump_file_name, "pat.v.dump");
    if(_change_out_path) begin 
      $sformat(_vcd_dump_file_name, "%0s/%0s", _new_out_path, _vcd_dump_file_name);
    end
    $dumpfile(_vcd_dump_file_name);
    $dumpvars;
`endif

`ifdef UTVCD
    $sformat(_utvcd_dump_file_name, "pat.v.dump");
    if(_change_out_path) begin 
      $sformat(_utvcd_dump_file_name, "%0s/%0s", _new_out_path, _utvcd_dump_file_name);
    end
    $dumpfile(_utvcd_dump_file_name);
    $vtDump;
    $dumpvars;
`endif

`ifdef debussy
    $sformat(_fsdb_dump_file_name, "pat.v.fsdb");
    if(_change_out_path) begin 
      $sformat(_fsdb_dump_file_name, "%0s/%0s", _new_out_path, _fsdb_dump_file_name);
    end
    $fsdbDumpfile(_fsdb_dump_file_name);
    $fsdbDumpvars;
`endif

`ifdef QWAVE
    $sformat(_qwave_dump_file_name, "pat.v.qwave.db");
    if(_change_out_path) begin 
      $sformat(_qwave_dump_file_name, "%0s/%0s", _new_out_path, _qwave_dump_file_name);
    end
    $qwavedb_dumpvars_filename(_qwave_dump_file_name);
    $qwavedb_dumpvars;
`endif
end 

reg /* sparse */[279:0] _nam_obus[85:0];
initial begin 
   if(_change_path) begin 
     $sformat(_new_filename,"%0s/pat.v.po.name",_new_path); 
     $display("Loading %0s\n", _new_filename ); 
     $readmemh(_new_filename,_nam_obus,85,0); 
   end 
   else begin
     $display("Loading pat.v.po.name");
     $readmemh("pat.v.po.name",_nam_obus,85,0);
   end 
end 


// Declare Wires for tracking Vector Type
reg[3:0] _MGCDFT_VECTYPE ;
reg[160:0] _procedure_string ;
reg mgcdft_test_setup, mgcdft_load_unload, mgcdft_shift,
     mgcdft_single_shift, mgcdft_shift_extra, 
     mgcdft_shadow_control, mgcdft_master_observe,
     mgcdft_shadow_observe, mgcdft_skew_load, 
     mgcdft_seq_transparent, mgcdft_launch_capture,
     mgcdft_clock_proc, mgcdft_test_end, mgcdft_unknown; 

event       set_vector_type;
always @(_MGCDFT_VECTYPE) begin
  assign mgcdft_test_setup      = 1'b0;
  assign mgcdft_load_unload     = 1'b0;
  assign mgcdft_shift           = 1'b0;
  assign mgcdft_single_shift    = 1'b0;
  assign mgcdft_shift_extra     = 1'b0;
  assign mgcdft_shadow_control  = 1'b0;
  assign mgcdft_master_observe  = 1'b0;
  assign mgcdft_shadow_observe  = 1'b0;
  assign mgcdft_skew_load       = 1'b0;
  assign mgcdft_seq_transparent = 1'b0;
  assign mgcdft_launch_capture  = 1'b0;
  assign mgcdft_clock_proc      = 1'b0;
  assign mgcdft_test_end        = 1'b0;
  assign mgcdft_unknown         = 1'b0;
  case (_MGCDFT_VECTYPE)
    4'b0001: begin
               assign mgcdft_test_setup      = 1'b1;
               _procedure_string = "TEST_SETUP";
               _scan_shift_count = 0;
             end
    4'b0010: begin
               assign mgcdft_load_unload     = 1'b1;
               _procedure_string = "LOAD";
               _scan_shift_count = 0;
             end
    4'b0011: begin
               assign mgcdft_shift           = 1'b1;
               _procedure_string = "SHIFT";
               if(!(_scan_shift_count)) begin
                 _scan_shift_count = 1;
               end
             end
    4'b0100: begin
               assign mgcdft_single_shift    = 1'b1;
               _procedure_string = "SINGLE_SHIFT";
               if(!(_scan_shift_count)) begin
                 _scan_shift_count = 1;
               end
             end
    4'b0101: begin
               assign mgcdft_shift_extra     = 1'b1;
               _procedure_string = "SHIFT_EXTRA";
               _scan_shift_count = 0;
             end
    4'b0110: begin
               assign mgcdft_shadow_control  = 1'b1;
               _procedure_string = "SHADOW_CONTROL";
               _scan_shift_count = 0;
             end
    4'b0111: begin
               assign mgcdft_master_observe  = 1'b1;
               _procedure_string = "MASTER_OBSERVE";
               _scan_shift_count = 0;
             end
    4'b1000: begin
               assign mgcdft_shadow_observe  = 1'b1;
               _procedure_string = "SHADOW_OBSERVE";
               _scan_shift_count = 0;
             end
    4'b1001: begin
               assign mgcdft_skew_load       = 1'b1;
               _procedure_string = "SKEW_LOAD";
               _scan_shift_count = 0;
             end
    4'b1010: begin
               assign mgcdft_seq_transparent = 1'b1;
               _procedure_string = "SEQ_TRANSPARENT";
               _scan_shift_count = 0;
             end
    4'b1011: begin
               assign mgcdft_launch_capture  = 1'b1;
               _procedure_string = "LAUNCH_CAPTURE";
               _scan_shift_count = 0;
             end
    4'b1101: begin
               assign mgcdft_clock_proc      = 1'b1;
               _procedure_string = "CLOCK_PROC";
               _scan_shift_count = 0;
             end
    4'b1111: begin
               assign mgcdft_test_end        = 1'b1;
               _procedure_string = "TEST_END";
               _scan_shift_count = 0;
             end
    4'b0000: begin
               assign mgcdft_unknown         = 1'b1;
               _procedure_string = "UNKNOWN";
               _scan_shift_count = 0;
             end
    default: begin
               assign mgcdft_unknown         = 1'b1;
               _procedure_string = "UNKNOWN";
               _scan_shift_count = 0;
             end
  endcase
end

event       compare_exp_sim_obus;
always @(compare_exp_sim_obus) begin
 _found_fail = 0;
 if (_do_compare) begin
  if (_exp_obus !== _sim_obus) begin
     for(_bit_count = 0;
         ((_bit_count < 86)&&(_found_fail==0));
          _bit_count =_bit_count +1) begin
        if ((_msk_obus[_bit_count] === 1'b1) &&
            (_exp_obus[_bit_count] !== _sim_obus[_bit_count])) begin
           _found_fail = 1;
           _found_fail_per_cycle = 1;
           _found_fail_obus[_bit_count] = 1'b1;
        end
     end
  end
  if (_found_fail == 1) begin
    $write($realtime, "ns: Simulated response %b pattern %d cycle %d\n",_sim_obus,_pattern_count,_cycle_count);
    $write($realtime, "ns: Expected  response %b pattern %d cycle %d\n",_exp_obus,_pattern_count,_cycle_count);
     for(_bit_count = 0;
         ((_bit_count < 86)&&((_miscompare_limit==0)||(_compare_fail<=_miscompare_limit)));
          _bit_count =_bit_count +1) begin
      if ((_msk_obus[_bit_count] === 1'b1) &&
          (_exp_obus[_bit_count] !== _sim_obus[_bit_count])) begin
        _found_fail_obus[_bit_count] = 1'b1;
        $write($realtime, "ns: Mismatch at pin %d name %s, Simulated %b, Expected %b\n",_bit_count,_nam_obus[_bit_count],_sim_obus[_bit_count],_exp_obus[_bit_count]);
        if (_write_DIAG_file == 1) begin
          if (_DIAG_file_header == 0) begin
            if ((_start_pat > -1) && (_end_pat > -1)) begin
              $sformat(_tmp_filename, "pat.v_%0d_%0d.fail",
                       _start_pat, _end_pat);
            end
            else if (_start_pat > -1) begin
              $sformat(_tmp_filename, "pat.v_%0d.fail",
                       _start_pat);
            end
            else if (_end_pat > -1) begin
              $sformat(_tmp_filename, "pat.v__%0d.fail",
                       _end_pat);
            end
            else begin
              $sformat(_tmp_filename, "pat.v.fail");
            end
            if(_change_out_path) begin 
              $sformat(_tmp_filename, "%0s/%0s", _new_out_path, _tmp_filename);
            end
            _diag_file = $fopen(_tmp_filename);
            if (_diag_file == 0) begin
              $display("ERROR: Couldn't open .fail file %0s, simulation aborted\n", _tmp_filename);
              ->before_finish;
              #0;
              $finish;
            end
            if(_change_out_path) begin 
              $fwrite(_diag_file, "// This File is simulation generated (%0s/pat.v)\n", _new_out_path);
            end
            else begin
              $fwrite(_diag_file, "// This File is simulation generated (pat.v)\n");
            end
            $fwrite(_diag_file, "//format pattern\n");
            $fwrite(_diag_file, "//failure_buffer_limit_reached none\n");
            $fwrite(_diag_file, "//data_reference cell\n");
            $fwrite(_diag_file, "//pattern_id      chain/PO_name   cell_number   expected_value   simulated_value\n\n");
            _DIAG_file_header = 1;
          end
          if ((_chain_test_)&&(_diag_chain_header!=1)) begin
            $fwrite(_diag_file, "chain_test\n");
            _diag_chain_header = 1;
          end
          if ((_chain_test_!=1)&&(_diag_scan_header!=1)) begin
            $fwrite(_diag_file, "scan_test\n");
            _diag_scan_header = 1;
          end
          if ((_pattern_count == _last_fail_pattern) && (_pattern_count == 0)) begin
             _fail_pattern_cnt = 1; 
          end
          if (_pattern_count > _last_fail_pattern) begin 
             _fail_pattern_cnt = _fail_pattern_cnt + 1;
             _last_fail_pattern = _pattern_count;
          end

          $fwrite(_diag_file, "%d  %s ", _pattern_count, _nam_obus[_bit_count]);
          case ( _exp_obus[_bit_count] )
            1'b1: begin
                    $fwrite(_diag_file, "            H"); 
                  end
            1'b0: begin
                    $fwrite(_diag_file, "            L"); 
                  end
            1'bZ: begin
                    $fwrite(_diag_file, "            Z"); 
                  end
          endcase
          case ( _sim_obus[_bit_count] )
            1'b1: begin
                    $fwrite(_diag_file, " H  // PO\n"); 
                  end
            1'b0: begin
                    $fwrite(_diag_file, " L  // PO\n"); 
                  end
            1'bZ: begin
                    $fwrite(_diag_file, " Z  // PO\n"); 
                  end
            1'bX: begin
                    $fwrite(_diag_file, " X  // PO\n"); 
                  end
          endcase
        end // EndIf _write_DIAG_file
        if (_write_MASK_file == 1) begin
          if (_MASK_file_header == 0) begin
            if ((_start_pat > -1) && (_end_pat > -1)) begin
              $sformat(_tmp_filename, "pat.v_%0d_%0d.mask",
                       _start_pat, _end_pat);
            end
            else if (_start_pat > -1) begin
              $sformat(_tmp_filename, "pat.v_%0d.mask",
                       _start_pat);
            end
            else if (_end_pat > -1) begin
              $sformat(_tmp_filename, "pat.v__%0d.mask",
                       _end_pat);
            end
            else begin
              $sformat(_tmp_filename, "pat.v.mask");
            end
            if(_change_out_path) begin 
              $sformat(_tmp_filename, "%0s/%0s", _new_out_path, _tmp_filename);
            end
            _mask_file = $fopen(_tmp_filename);
            if (_mask_file == 0) begin
              $display("ERROR: Couldn't open .mask file %0s, simulation aborted\n", _tmp_filename);
              ->before_finish;
              #0;
              $finish;
            end
            $fwrite(_mask_file, "%s\n%s\n", "type mask", "");
            _MASK_file_header = 1;
          end
          if (_chain_test_ == 0) begin
            $fwrite(_mask_file, "%d %s\n", _pattern_count,_nam_obus[_bit_count]);
          end
          if (_chain_test_ == 1) begin
            $fwrite(_mask_file, "// %d %s\n", _pattern_count,_nam_obus[_bit_count]);
          end
        end
      end
    end
    _compare_fail = _compare_fail + 1;
  end
 end // if _do_compare
end

reg[384:0]     mem [0:348616];
MGC_DFT_LIB_ALL MGC_DFT_LIB_ALL_inst (
     .sg13g2_a21o_1__A1(sg13g2_a21o_1__A1), 
     .sg13g2_a21o_1__A2(sg13g2_a21o_1__A2), 
     .sg13g2_a21o_1__B1(sg13g2_a21o_1__B1), 
     .sg13g2_a21o_2__A1(sg13g2_a21o_2__A1), 
     .sg13g2_a21o_2__A2(sg13g2_a21o_2__A2), 
     .sg13g2_a21o_2__B1(sg13g2_a21o_2__B1), 
     .sg13g2_a21oi_1__A1(sg13g2_a21oi_1__A1), 
     .sg13g2_a21oi_1__A2(sg13g2_a21oi_1__A2), 
     .sg13g2_a21oi_1__B1(sg13g2_a21oi_1__B1), 
     .sg13g2_a21oi_2__A1(sg13g2_a21oi_2__A1), 
     .sg13g2_a21oi_2__A2(sg13g2_a21oi_2__A2), 
     .sg13g2_a21oi_2__B1(sg13g2_a21oi_2__B1), 
     .sg13g2_a221oi_1__A1(sg13g2_a221oi_1__A1), 
     .sg13g2_a221oi_1__A2(sg13g2_a221oi_1__A2), 
     .sg13g2_a221oi_1__B1(sg13g2_a221oi_1__B1), 
     .sg13g2_a221oi_1__B2(sg13g2_a221oi_1__B2), 
     .sg13g2_a221oi_1__C1(sg13g2_a221oi_1__C1), 
     .sg13g2_a22oi_1__A1(sg13g2_a22oi_1__A1), 
     .sg13g2_a22oi_1__A2(sg13g2_a22oi_1__A2), 
     .sg13g2_a22oi_1__B1(sg13g2_a22oi_1__B1), 
     .sg13g2_a22oi_1__B2(sg13g2_a22oi_1__B2), 
     .sg13g2_and2_1__A(sg13g2_and2_1__A), 
     .sg13g2_and2_1__B(sg13g2_and2_1__B), 
     .sg13g2_and2_2__A(sg13g2_and2_2__A), 
     .sg13g2_and2_2__B(sg13g2_and2_2__B), 
     .sg13g2_and3_1__A(sg13g2_and3_1__A), 
     .sg13g2_and3_1__B(sg13g2_and3_1__B), 
     .sg13g2_and3_1__C(sg13g2_and3_1__C), 
     .sg13g2_and3_2__A(sg13g2_and3_2__A), 
     .sg13g2_and3_2__B(sg13g2_and3_2__B), 
     .sg13g2_and3_2__C(sg13g2_and3_2__C), 
     .sg13g2_and4_1__A(sg13g2_and4_1__A), 
     .sg13g2_and4_1__B(sg13g2_and4_1__B), 
     .sg13g2_and4_1__C(sg13g2_and4_1__C), 
     .sg13g2_and4_1__D(sg13g2_and4_1__D), 
     .sg13g2_and4_2__A(sg13g2_and4_2__A), 
     .sg13g2_and4_2__B(sg13g2_and4_2__B), 
     .sg13g2_and4_2__C(sg13g2_and4_2__C), 
     .sg13g2_and4_2__D(sg13g2_and4_2__D), 
     .sg13g2_antennanp__A(sg13g2_antennanp__A), 
     .sg13g2_buf_1__A(sg13g2_buf_1__A), 
     .sg13g2_buf_16__A(sg13g2_buf_16__A), 
     .sg13g2_buf_2__A(sg13g2_buf_2__A), 
     .sg13g2_buf_4__A(sg13g2_buf_4__A), 
     .sg13g2_buf_8__A(sg13g2_buf_8__A), 
     .sg13g2_dfrbp_1__CLK(sg13g2_dfrbp_1__CLK), 
     .sg13g2_dfrbp_1__D(sg13g2_dfrbp_1__D), 
     .sg13g2_dfrbp_1__RESET_B(sg13g2_dfrbp_1__RESET_B), 
     .sg13g2_dfrbp_2__CLK(sg13g2_dfrbp_2__CLK), 
     .sg13g2_dfrbp_2__D(sg13g2_dfrbp_2__D), 
     .sg13g2_dfrbp_2__RESET_B(sg13g2_dfrbp_2__RESET_B), 
     .sg13g2_dfrbpq_1__CLK(sg13g2_dfrbpq_1__CLK), 
     .sg13g2_dfrbpq_1__D(sg13g2_dfrbpq_1__D), 
     .sg13g2_dfrbpq_1__RESET_B(sg13g2_dfrbpq_1__RESET_B), 
     .sg13g2_dfrbpq_2__CLK(sg13g2_dfrbpq_2__CLK), 
     .sg13g2_dfrbpq_2__D(sg13g2_dfrbpq_2__D), 
     .sg13g2_dfrbpq_2__RESET_B(sg13g2_dfrbpq_2__RESET_B), 
     .sg13g2_dlhq_1__D(sg13g2_dlhq_1__D), 
     .sg13g2_dlhq_1__GATE(sg13g2_dlhq_1__GATE), 
     .sg13g2_dlhr_1__D(sg13g2_dlhr_1__D), 
     .sg13g2_dlhr_1__GATE(sg13g2_dlhr_1__GATE), 
     .sg13g2_dlhr_1__RESET_B(sg13g2_dlhr_1__RESET_B), 
     .sg13g2_dlhrq_1__D(sg13g2_dlhrq_1__D), 
     .sg13g2_dlhrq_1__GATE(sg13g2_dlhrq_1__GATE), 
     .sg13g2_dlhrq_1__RESET_B(sg13g2_dlhrq_1__RESET_B), 
     .sg13g2_dllr_1__D(sg13g2_dllr_1__D), 
     .sg13g2_dllr_1__GATE_N(sg13g2_dllr_1__GATE_N), 
     .sg13g2_dllr_1__RESET_B(sg13g2_dllr_1__RESET_B), 
     .sg13g2_dllrq_1__D(sg13g2_dllrq_1__D), 
     .sg13g2_dllrq_1__GATE_N(sg13g2_dllrq_1__GATE_N), 
     .sg13g2_dllrq_1__RESET_B(sg13g2_dllrq_1__RESET_B), 
     .sg13g2_dlygate4sd1_1__A(sg13g2_dlygate4sd1_1__A), 
     .sg13g2_dlygate4sd2_1__A(sg13g2_dlygate4sd2_1__A), 
     .sg13g2_dlygate4sd3_1__A(sg13g2_dlygate4sd3_1__A), 
     .sg13g2_ebufn_2__A(sg13g2_ebufn_2__A), 
     .sg13g2_ebufn_2__TE_B(sg13g2_ebufn_2__TE_B), 
     .sg13g2_ebufn_4__A(sg13g2_ebufn_4__A), 
     .sg13g2_ebufn_4__TE_B(sg13g2_ebufn_4__TE_B), 
     .sg13g2_ebufn_8__A(sg13g2_ebufn_8__A), 
     .sg13g2_ebufn_8__TE_B(sg13g2_ebufn_8__TE_B), 
     .sg13g2_einvn_2__A(sg13g2_einvn_2__A), 
     .sg13g2_einvn_2__TE_B(sg13g2_einvn_2__TE_B), 
     .sg13g2_einvn_4__A(sg13g2_einvn_4__A), 
     .sg13g2_einvn_4__TE_B(sg13g2_einvn_4__TE_B), 
     .sg13g2_einvn_8__A(sg13g2_einvn_8__A), 
     .sg13g2_einvn_8__TE_B(sg13g2_einvn_8__TE_B), 
     .sg13g2_inv_1__A(sg13g2_inv_1__A), 
     .sg13g2_inv_16__A(sg13g2_inv_16__A), 
     .sg13g2_inv_2__A(sg13g2_inv_2__A), 
     .sg13g2_inv_4__A(sg13g2_inv_4__A), 
     .sg13g2_inv_8__A(sg13g2_inv_8__A), 
     .sg13g2_lgcp_1_$_int_GATE__CLK(sg13g2_lgcp_1_$_int_GATE__CLK), 
     .sg13g2_lgcp_1_$_int_GATE__GATE(sg13g2_lgcp_1_$_int_GATE__GATE), 
     .sg13g2_lgcp_1__CLK(sg13g2_lgcp_1__CLK), 
     .sg13g2_lgcp_1__GATE(sg13g2_lgcp_1__GATE), 
     .sg13g2_mux2_1__A0(sg13g2_mux2_1__A0), 
     .sg13g2_mux2_1__A1(sg13g2_mux2_1__A1), 
     .sg13g2_mux2_1__S(sg13g2_mux2_1__S), 
     .sg13g2_mux2_2__A0(sg13g2_mux2_2__A0), 
     .sg13g2_mux2_2__A1(sg13g2_mux2_2__A1), 
     .sg13g2_mux2_2__S(sg13g2_mux2_2__S), 
     .sg13g2_mux4_1__A0(sg13g2_mux4_1__A0), 
     .sg13g2_mux4_1__A1(sg13g2_mux4_1__A1), 
     .sg13g2_mux4_1__A2(sg13g2_mux4_1__A2), 
     .sg13g2_mux4_1__A3(sg13g2_mux4_1__A3), 
     .sg13g2_mux4_1__S0(sg13g2_mux4_1__S0), 
     .sg13g2_mux4_1__S1(sg13g2_mux4_1__S1), 
     .sg13g2_nand2_1__A(sg13g2_nand2_1__A), 
     .sg13g2_nand2_1__B(sg13g2_nand2_1__B), 
     .sg13g2_nand2_2__A(sg13g2_nand2_2__A), 
     .sg13g2_nand2_2__B(sg13g2_nand2_2__B), 
     .sg13g2_nand2b_1__A_N(sg13g2_nand2b_1__A_N), 
     .sg13g2_nand2b_1__B(sg13g2_nand2b_1__B), 
     .sg13g2_nand2b_2__A_N(sg13g2_nand2b_2__A_N), 
     .sg13g2_nand2b_2__B(sg13g2_nand2b_2__B), 
     .sg13g2_nand3_1__A(sg13g2_nand3_1__A), 
     .sg13g2_nand3_1__B(sg13g2_nand3_1__B), 
     .sg13g2_nand3_1__C(sg13g2_nand3_1__C), 
     .sg13g2_nand3b_1__A_N(sg13g2_nand3b_1__A_N), 
     .sg13g2_nand3b_1__B(sg13g2_nand3b_1__B), 
     .sg13g2_nand3b_1__C(sg13g2_nand3b_1__C), 
     .sg13g2_nand4_1__A(sg13g2_nand4_1__A), 
     .sg13g2_nand4_1__B(sg13g2_nand4_1__B), 
     .sg13g2_nand4_1__C(sg13g2_nand4_1__C), 
     .sg13g2_nand4_1__D(sg13g2_nand4_1__D), 
     .sg13g2_nor2_1__A(sg13g2_nor2_1__A), 
     .sg13g2_nor2_1__B(sg13g2_nor2_1__B), 
     .sg13g2_nor2_2__A(sg13g2_nor2_2__A), 
     .sg13g2_nor2_2__B(sg13g2_nor2_2__B), 
     .sg13g2_nor2b_1__A(sg13g2_nor2b_1__A), 
     .sg13g2_nor2b_1__B_N(sg13g2_nor2b_1__B_N), 
     .sg13g2_nor2b_2__A(sg13g2_nor2b_2__A), 
     .sg13g2_nor2b_2__B_N(sg13g2_nor2b_2__B_N), 
     .sg13g2_nor3_1__A(sg13g2_nor3_1__A), 
     .sg13g2_nor3_1__B(sg13g2_nor3_1__B), 
     .sg13g2_nor3_1__C(sg13g2_nor3_1__C), 
     .sg13g2_nor3_2__A(sg13g2_nor3_2__A), 
     .sg13g2_nor3_2__B(sg13g2_nor3_2__B), 
     .sg13g2_nor3_2__C(sg13g2_nor3_2__C), 
     .sg13g2_nor4_1__A(sg13g2_nor4_1__A), 
     .sg13g2_nor4_1__B(sg13g2_nor4_1__B), 
     .sg13g2_nor4_1__C(sg13g2_nor4_1__C), 
     .sg13g2_nor4_1__D(sg13g2_nor4_1__D), 
     .sg13g2_nor4_2__A(sg13g2_nor4_2__A), 
     .sg13g2_nor4_2__B(sg13g2_nor4_2__B), 
     .sg13g2_nor4_2__C(sg13g2_nor4_2__C), 
     .sg13g2_nor4_2__D(sg13g2_nor4_2__D), 
     .sg13g2_o21ai_1__A1(sg13g2_o21ai_1__A1), 
     .sg13g2_o21ai_1__A2(sg13g2_o21ai_1__A2), 
     .sg13g2_o21ai_1__B1(sg13g2_o21ai_1__B1), 
     .sg13g2_or2_1__A(sg13g2_or2_1__A), 
     .sg13g2_or2_1__B(sg13g2_or2_1__B), 
     .sg13g2_or2_2__A(sg13g2_or2_2__A), 
     .sg13g2_or2_2__B(sg13g2_or2_2__B), 
     .sg13g2_or3_1__A(sg13g2_or3_1__A), 
     .sg13g2_or3_1__B(sg13g2_or3_1__B), 
     .sg13g2_or3_1__C(sg13g2_or3_1__C), 
     .sg13g2_or3_2__A(sg13g2_or3_2__A), 
     .sg13g2_or3_2__B(sg13g2_or3_2__B), 
     .sg13g2_or3_2__C(sg13g2_or3_2__C), 
     .sg13g2_or4_1__A(sg13g2_or4_1__A), 
     .sg13g2_or4_1__B(sg13g2_or4_1__B), 
     .sg13g2_or4_1__C(sg13g2_or4_1__C), 
     .sg13g2_or4_1__D(sg13g2_or4_1__D), 
     .sg13g2_or4_2__A(sg13g2_or4_2__A), 
     .sg13g2_or4_2__B(sg13g2_or4_2__B), 
     .sg13g2_or4_2__C(sg13g2_or4_2__C), 
     .sg13g2_or4_2__D(sg13g2_or4_2__D), 
     .sg13g2_sdfbbp_1__CLK(sg13g2_sdfbbp_1__CLK), 
     .sg13g2_sdfbbp_1__D(sg13g2_sdfbbp_1__D), 
     .sg13g2_sdfbbp_1__RESET_B(sg13g2_sdfbbp_1__RESET_B), 
     .sg13g2_sdfbbp_1__SCD(sg13g2_sdfbbp_1__SCD), 
     .sg13g2_sdfbbp_1__SCE(sg13g2_sdfbbp_1__SCE), 
     .sg13g2_sdfbbp_1__SET_B(sg13g2_sdfbbp_1__SET_B), 
     .sg13g2_sdfrbp_1__CLK(sg13g2_sdfrbp_1__CLK), 
     .sg13g2_sdfrbp_1__D(sg13g2_sdfrbp_1__D), 
     .sg13g2_sdfrbp_1__RESET_B(sg13g2_sdfrbp_1__RESET_B), 
     .sg13g2_sdfrbp_1__SCD(sg13g2_sdfrbp_1__SCD), 
     .sg13g2_sdfrbp_1__SCE(sg13g2_sdfrbp_1__SCE), 
     .sg13g2_sdfrbp_2__CLK(sg13g2_sdfrbp_2__CLK), 
     .sg13g2_sdfrbp_2__D(sg13g2_sdfrbp_2__D), 
     .sg13g2_sdfrbp_2__RESET_B(sg13g2_sdfrbp_2__RESET_B), 
     .sg13g2_sdfrbp_2__SCD(sg13g2_sdfrbp_2__SCD), 
     .sg13g2_sdfrbp_2__SCE(sg13g2_sdfrbp_2__SCE), 
     .sg13g2_sdfrbpq_1__CLK(sg13g2_sdfrbpq_1__CLK), 
     .sg13g2_sdfrbpq_1__D(sg13g2_sdfrbpq_1__D), 
     .sg13g2_sdfrbpq_1__RESET_B(sg13g2_sdfrbpq_1__RESET_B), 
     .sg13g2_sdfrbpq_1__SCD(sg13g2_sdfrbpq_1__SCD), 
     .sg13g2_sdfrbpq_1__SCE(sg13g2_sdfrbpq_1__SCE), 
     .sg13g2_sdfrbpq_2__CLK(sg13g2_sdfrbpq_2__CLK), 
     .sg13g2_sdfrbpq_2__D(sg13g2_sdfrbpq_2__D), 
     .sg13g2_sdfrbpq_2__RESET_B(sg13g2_sdfrbpq_2__RESET_B), 
     .sg13g2_sdfrbpq_2__SCD(sg13g2_sdfrbpq_2__SCD), 
     .sg13g2_sdfrbpq_2__SCE(sg13g2_sdfrbpq_2__SCE), 
     .sg13g2_slgcp_1_$_int_GATE__CLK(sg13g2_slgcp_1_$_int_GATE__CLK), 
     .sg13g2_slgcp_1_$_int_GATE__GATE(sg13g2_slgcp_1_$_int_GATE__GATE), 
     .sg13g2_slgcp_1_$_int_GATE__SCE(sg13g2_slgcp_1_$_int_GATE__SCE), 
     .sg13g2_slgcp_1__CLK(sg13g2_slgcp_1__CLK), 
     .sg13g2_slgcp_1__GATE(sg13g2_slgcp_1__GATE), 
     .sg13g2_slgcp_1__SCE(sg13g2_slgcp_1__SCE), 
     .sg13g2_xnor2_1__A(sg13g2_xnor2_1__A), 
     .sg13g2_xnor2_1__B(sg13g2_xnor2_1__B), 
     .sg13g2_xor2_1__A(sg13g2_xor2_1__A), 
     .sg13g2_xor2_1__B(sg13g2_xor2_1__B), 
     .sg13g2_sighold__SH(sg13g2_sighold__SH), 
     .sg13g2_a21o_1__X(sg13g2_a21o_1__X), 
     .sg13g2_a21o_2__X(sg13g2_a21o_2__X), 
     .sg13g2_a21oi_1__Y(sg13g2_a21oi_1__Y), 
     .sg13g2_a21oi_2__Y(sg13g2_a21oi_2__Y), 
     .sg13g2_a221oi_1__Y(sg13g2_a221oi_1__Y), 
     .sg13g2_a22oi_1__Y(sg13g2_a22oi_1__Y), 
     .sg13g2_and2_1__X(sg13g2_and2_1__X), 
     .sg13g2_and2_2__X(sg13g2_and2_2__X), 
     .sg13g2_and3_1__X(sg13g2_and3_1__X), 
     .sg13g2_and3_2__X(sg13g2_and3_2__X), 
     .sg13g2_and4_1__X(sg13g2_and4_1__X), 
     .sg13g2_and4_2__X(sg13g2_and4_2__X), 
     .sg13g2_buf_1__X(sg13g2_buf_1__X), 
     .sg13g2_buf_16__X(sg13g2_buf_16__X), 
     .sg13g2_buf_2__X(sg13g2_buf_2__X), 
     .sg13g2_buf_4__X(sg13g2_buf_4__X), 
     .sg13g2_buf_8__X(sg13g2_buf_8__X), 
     .sg13g2_dfrbp_1__Q(sg13g2_dfrbp_1__Q), 
     .sg13g2_dfrbp_1__Q_N(sg13g2_dfrbp_1__Q_N), 
     .sg13g2_dfrbp_2__Q(sg13g2_dfrbp_2__Q), 
     .sg13g2_dfrbp_2__Q_N(sg13g2_dfrbp_2__Q_N), 
     .sg13g2_dfrbpq_1__Q(sg13g2_dfrbpq_1__Q), 
     .sg13g2_dfrbpq_2__Q(sg13g2_dfrbpq_2__Q), 
     .sg13g2_dlhq_1__Q(sg13g2_dlhq_1__Q), 
     .sg13g2_dlhr_1__Q(sg13g2_dlhr_1__Q), 
     .sg13g2_dlhr_1__Q_N(sg13g2_dlhr_1__Q_N), 
     .sg13g2_dlhrq_1__Q(sg13g2_dlhrq_1__Q), 
     .sg13g2_dllr_1__Q(sg13g2_dllr_1__Q), 
     .sg13g2_dllr_1__Q_N(sg13g2_dllr_1__Q_N), 
     .sg13g2_dllrq_1__Q(sg13g2_dllrq_1__Q), 
     .sg13g2_dlygate4sd1_1__X(sg13g2_dlygate4sd1_1__X), 
     .sg13g2_dlygate4sd2_1__X(sg13g2_dlygate4sd2_1__X), 
     .sg13g2_dlygate4sd3_1__X(sg13g2_dlygate4sd3_1__X), 
     .sg13g2_ebufn_2__Z(sg13g2_ebufn_2__Z), 
     .sg13g2_ebufn_4__Z(sg13g2_ebufn_4__Z), 
     .sg13g2_ebufn_8__Z(sg13g2_ebufn_8__Z), 
     .sg13g2_einvn_2__Z(sg13g2_einvn_2__Z), 
     .sg13g2_einvn_4__Z(sg13g2_einvn_4__Z), 
     .sg13g2_einvn_8__Z(sg13g2_einvn_8__Z), 
     .sg13g2_inv_1__Y(sg13g2_inv_1__Y), 
     .sg13g2_inv_16__Y(sg13g2_inv_16__Y), 
     .sg13g2_inv_2__Y(sg13g2_inv_2__Y), 
     .sg13g2_inv_4__Y(sg13g2_inv_4__Y), 
     .sg13g2_inv_8__Y(sg13g2_inv_8__Y), 
     .sg13g2_lgcp_1_$_int_GATE__int_GATE(sg13g2_lgcp_1_$_int_GATE__int_GATE), 
     .sg13g2_lgcp_1__GCLK(sg13g2_lgcp_1__GCLK), 
     .sg13g2_mux2_1__X(sg13g2_mux2_1__X), 
     .sg13g2_mux2_2__X(sg13g2_mux2_2__X), 
     .sg13g2_mux4_1__X(sg13g2_mux4_1__X), 
     .sg13g2_nand2_1__Y(sg13g2_nand2_1__Y), 
     .sg13g2_nand2_2__Y(sg13g2_nand2_2__Y), 
     .sg13g2_nand2b_1__Y(sg13g2_nand2b_1__Y), 
     .sg13g2_nand2b_2__Y(sg13g2_nand2b_2__Y), 
     .sg13g2_nand3_1__Y(sg13g2_nand3_1__Y), 
     .sg13g2_nand3b_1__Y(sg13g2_nand3b_1__Y), 
     .sg13g2_nand4_1__Y(sg13g2_nand4_1__Y), 
     .sg13g2_nor2_1__Y(sg13g2_nor2_1__Y), 
     .sg13g2_nor2_2__Y(sg13g2_nor2_2__Y), 
     .sg13g2_nor2b_1__Y(sg13g2_nor2b_1__Y), 
     .sg13g2_nor2b_2__Y(sg13g2_nor2b_2__Y), 
     .sg13g2_nor3_1__Y(sg13g2_nor3_1__Y), 
     .sg13g2_nor3_2__Y(sg13g2_nor3_2__Y), 
     .sg13g2_nor4_1__Y(sg13g2_nor4_1__Y), 
     .sg13g2_nor4_2__Y(sg13g2_nor4_2__Y), 
     .sg13g2_o21ai_1__Y(sg13g2_o21ai_1__Y), 
     .sg13g2_or2_1__X(sg13g2_or2_1__X), 
     .sg13g2_or2_2__X(sg13g2_or2_2__X), 
     .sg13g2_or3_1__X(sg13g2_or3_1__X), 
     .sg13g2_or3_2__X(sg13g2_or3_2__X), 
     .sg13g2_or4_1__X(sg13g2_or4_1__X), 
     .sg13g2_or4_2__X(sg13g2_or4_2__X), 
     .sg13g2_sdfbbp_1__Q(sg13g2_sdfbbp_1__Q), 
     .sg13g2_sdfbbp_1__Q_N(sg13g2_sdfbbp_1__Q_N), 
     .sg13g2_sdfrbp_1__Q(sg13g2_sdfrbp_1__Q), 
     .sg13g2_sdfrbp_1__Q_N(sg13g2_sdfrbp_1__Q_N), 
     .sg13g2_sdfrbp_2__Q(sg13g2_sdfrbp_2__Q), 
     .sg13g2_sdfrbp_2__Q_N(sg13g2_sdfrbp_2__Q_N), 
     .sg13g2_sdfrbpq_1__Q(sg13g2_sdfrbpq_1__Q), 
     .sg13g2_sdfrbpq_2__Q(sg13g2_sdfrbpq_2__Q), 
     .sg13g2_slgcp_1_$_int_GATE__int_GATE(sg13g2_slgcp_1_$_int_GATE__int_GATE), 
     .sg13g2_slgcp_1__GCLK(sg13g2_slgcp_1__GCLK), 
     .sg13g2_tiehi__L_HI(sg13g2_tiehi__L_HI), 
     .sg13g2_tielo__L_LO(sg13g2_tielo__L_LO), 
     .sg13g2_xnor2_1__Y(sg13g2_xnor2_1__Y), 
     .sg13g2_xor2_1__X(sg13g2_xor2_1__X));

initial begin
_in_restart = 0;
while (_in_restart < 2) begin
_in_restart = _in_restart + 1;
_restart_state     = -1;
if ($value$plusargs("RESTART=%d", _restart_state)) begin
  $display(" Found RESTART   %d", _restart_state);
end

if ((_in_restart < 2) || (_restart_state == 1)) begin
mgcdft_save_signal = 1'b0;
mgcdft_restart_signal = 1'b0;
if (_restart_state == 1) begin
  #0;
  mgcdft_restart_signal = 1'b1;
//  $display("Reading checkpoint pat.v.dat");
//  $restart("pat.v.dat");
end

#0;
mgcdft_save_signal = 1'b0;
mgcdft_restart_signal = 1'b0;
_compare_fail = 0;
_pattern_count = 0;
_cycle_count = 0;
_save_cycle_count = 0;
_write_DIAG_file = 0; // change to 1, to generate file
_write_MASK_file = 0; // change to 1, to generate file
_DIAG_file_header = 0;
_diag_file = 0;
_diag_chain_header = 0;
_diag_scan_header = 0;
_fail_pattern_cnt = 0;
_last_fail_pattern = 0;
_MASK_file_header = 0;
_mask_file = 0;
_chain_test_ = 0;
_par_shift_cnt = 0;
_report_bit_cnt = 0;
// Limit # of miscompares before aborting simulation (non-zero)
_miscompare_limit = 0; 
_end_vec_file_ok = 0; 
_scan_shift_count = 0;
_run_testsetup = 1;
_in_testsetup = 1;
_start_pat      = -1;
_end_pat        = -1;
_end_after_setup = -1;
_no_setup       = -1;
_save_state     = -1;
_override_cfg   = 0;
_pat_num        = -1;
_in_range       = 1;
_do_compare     = 1;
_in_chaintest   = 0;

_skipped_patterns = 0;

_end_simulation   = 0;

if ($value$plusargs("STARTPAT=%d", _start_pat)) begin
  if (_start_pat > -1) begin
    $display(" Found Start pattern number %d", _start_pat);
    _in_range = 0;
    _do_compare = 0;
  end
  else begin
    $display(" Ignoring negative Start pattern number   %d", _start_pat);
    _start_pat = -1;
  end
end
if ($value$plusargs("ENDPAT=%d", _end_pat)) begin
  if (_end_pat > -1) begin
    $display(" Found End pattern number   %d", _end_pat);
  end
  else begin
    $display(" Ignoring negative End pattern number   %d", _end_pat);
    _end_pat = -1;
  end
end

if ($value$plusargs("CHAINTEST=%d", _in_chaintest)) begin
  if (_in_chaintest) begin
    $display(" Found ChainTest identifier %d", _in_chaintest);
  end
end

if ($value$plusargs("END_AFTER_SETUP=%d", _end_after_setup)) begin
  $display(" Found End after setup   %d", _end_after_setup);
  if (_end_after_setup > 0) begin
    _end_pat = 0;
    _in_chaintest = 1;
  end
end

if ($value$plusargs("SKIP_SETUP=%d", _no_setup)) begin
  $display(" Found Skip setup   %d", _no_setup);
  if (_no_setup > 0) begin
    if (_start_pat == -1) begin
      _start_pat = 0;
      _in_chaintest = 1;
    end
    if (_in_chaintest == 1) begin
      _chain_test_ = 1;
    end
    _run_testsetup = 0;
    _in_range = 0;
    _do_compare = 0;
  end
end

if ($value$plusargs("SAVE=%d", _save_state)) begin
  $display(" Found SAVE   %d", _save_state);
end

if ($value$plusargs("CONFIG=%0s", _cfg_file_name)) begin
  $display(" Found CONFIG identifier   %0s", _cfg_file_name);
  _override_cfg = 1;
end
else begin
  _cfg_file_name = "pat.v.cfg";
end

if ((_end_pat != -1) && (_end_pat < _start_pat)) begin
  _start_pat = -1;
  _in_range = 1;
  _do_compare = 1;
  $display("STARTPAT less than ENDPAT, ignoring STARTPAT ");
end

// read vector config file
if(_override_cfg) begin 
  _config_file = $fopen(_cfg_file_name, "r");
end
else begin
if(_change_path) begin 
  $sformat(_new_filename,"%0s/pat.v.cfg",_new_path); 
  _config_file = $fopen(_new_filename, "r");
end
else begin
  _config_file = $fopen("pat.v.cfg", "r");
end

end

if (_config_file == 0) begin
  $display("ERROR: Couldn't open configuration file, simulation aborted\n");
  ->before_finish;
  #0;
  $finish;
end
_fstat = 0;
if (_start_pat != -1) begin
  if (_no_setup > 0) begin
  $display("BEGIN pattern read loop  Skip test_setup\n");
  end
  else if (_in_chaintest == 0) begin
    if (_end_pat != -1) begin
    $display("BEGIN pattern read loop  Start pattern (%d) End pattern (%d)\n",
_start_pat,_end_pat);
    end
    else begin
    $display("BEGIN pattern read loop  Start pattern (%d) \n",
_start_pat);
    end
  end
  else begin
    if (_end_pat != -1) begin
    $display("BEGIN pattern read loop  Start chain pattern (%d) End chain pattern (%d)\n",
_start_pat,_end_pat);
    end
    else begin
    $display("BEGIN pattern read loop  Start chain pattern (%d)\n",
_start_pat);
    end
  end
end
else if (_end_pat != -1) begin
  if (_end_after_setup > 0) begin
  $display("BEGIN pattern read loop  End after test_setup\n");
  end
  else if (_in_chaintest == 0) begin
  $display("BEGIN pattern read loop  End pattern (%d)\n", _end_pat);
  end
  else begin
  $display("BEGIN pattern read loop  End chain pattern (%d)\n", _end_pat);
  end
end

// begin pattern read loop
while (!$feof(_config_file) && (!_end_simulation))
begin
         _fstat = $fscanf(_config_file, "%s", _vec_file_name);
         _fstat = $fscanf(_config_file, "%d", _max_index);
   if (_fstat != -1) begin
         _fstat = $fscanf(_config_file, "%d", _vec_pat_count);
         if (_fstat == -1) begin
           _vec_pat_count = -1;
         end
         // skip .vec file if _start_pat greater than this
         if ((_start_pat != -1) && !_in_range && (_vec_pat_count != -1) &&
             !_in_testsetup && !_in_chaintest &&
             ((_pat_num + _vec_pat_count) < _start_pat)) begin
           _max_index = -1;
           if (_chain_test_) begin
             _pattern_count = 0;
             _pat_num = 0;
           end
           _pat_num = _pat_num + _vec_pat_count;
           _skipped_patterns = _skipped_patterns + _vec_pat_count;
           _end_vec_file_ok = 1;
           _chain_test_ = 0;
            $display("Skipping %0s\n", _vec_file_name);
         end
         else begin
          if(_change_path) begin 
            $sformat(_new_filename,"%0s/%0s",_new_path, _vec_file_name); 
            $display("Loading %0s\n", _new_filename ); 
            $readmemb(_new_filename, mem, 0, _max_index);
         end
         else begin
           $display("Loading %0s\n", _vec_file_name);
           $readmemb(_vec_file_name, mem, 0, _max_index);
         end
           _end_vec_file_ok = 0;
         end
   end
   else begin
     _max_index = -1;
     _vec_pat_count = -1;
   end
   _scan_index = 0;
   _repeat_count_nest[0] = 0;
   _repeat_count = 0;
   _repeat_depth = 0;
   _message_index = 0;
   _save_index[0] = 0;
   _found_fail_obus =86'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
   for (_index=0; _index <= _max_index; _index = _index+1)
   begin
      vect = mem[_index];
      _exp_obus=86'bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
      _msk_obus=86'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
      _MGCDFT_VECTYPE = vect[3:0];
      _pat_type = vect[6:4];
      _tp_num = vect[7];
      //    Range Check
      if ((_start_pat != -1) && ((_start_pat != 0) || (!_in_testsetup)) &&
          ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
        if (!_chain_test_ && _in_chaintest && !_in_range && !_in_testsetup) begin
          _in_range = 1;
          _do_compare = 1;
        end
        if ((_pat_num == _start_pat) && !_in_range) begin
          _in_range = 1;
          _do_compare = 0;
          _pattern_count = (_pat_num - 1);
          if (_pattern_count < 0) begin
            _pattern_count = 0;
          end
        end
        if (_pat_num == (_start_pat + 1)) begin
          _do_compare = 1;
        end
      end

      if ((_end_pat != -1) && (_pattern_count > _end_pat) && 
          ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
         // simulation complete, exit
         _index = _max_index + 1;
         _end_vec_file_ok = 1;
         _end_simulation = 1;
      end
      if ((_end_pat != -1) && !_chain_test_ && _in_chaintest &&
          !_run_testsetup) begin
         // simulation complete, exit
         _index = _max_index + 1;
         _end_vec_file_ok = 1;
         _end_simulation = 1;
      end
      if ((_in_range) || (_run_testsetup)) begin
      case (_pat_type)
         3'b000:  begin // end vector
            _index = _max_index + 1;
         end // end vector
         3'b001: ;// skip scan vector, handled by shift vector
         3'b010:  begin // broadside vector
            _found_fail_per_cycle = 0;
            _found_fail_obus =86'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
            if (vect[8] == 1'b1) begin
               _pattern_count = _pattern_count + 1;
               _par_shift_cnt = 0;
              if ((!_do_compare) && (_pattern_count >= _start_pat)) begin
                _do_compare = 1;
              end
              if ((_end_pat != -1) && (_pattern_count > _end_pat) && 
                  ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
                // simulation complete, exit
                _index = _max_index + 1;
                _end_vec_file_ok = 1;
                _end_simulation = 1;
                _in_range = 0;
              end
            end
            if (vect[8] === 1'bz) begin
               _pattern_count = 0;
               _par_shift_cnt = 0;
            end
            if(_scan_shift_count) begin
               _scan_shift_count = _scan_shift_count + 1;
            end
            case (_tp_num)
               1'b1: begin // timeplate 1 - gen_tp1
                  if (vect[181] === 1'bz)
                    _ibus[0] = 1'bz;
                  _ibus[203:1] = vect[384:182];
                  _ibus[0] = vect[181];

                  #10; // 10 ns
                  _exp_obus[85:0] = vect[180:95];
                  _msk_obus[85:0] = vect[94:9];
                  #0;
                  ->compare_exp_sim_obus;
                  if ((_miscompare_limit)&&(_compare_fail>=_miscompare_limit)) begin
                    $display("ERROR: exceeded miscompare limit(%d), exiting simulation",_miscompare_limit);
                    _end_vec_file_ok = 1;
                    if (_DIAG_file_header == 1) begin
                       if (_diag_scan_header==1) begin
                         $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
                       end
                       $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
                       $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
                       $fwrite(_diag_file, "failure_file_end\n");
                       $fclose(_diag_file);
                    end
                    ->before_finish;
                    #0;
                    $finish;
                  end

                  #30; // 40 ns
               end // timeplate 1 - gen_tp1
               1'b0: begin // timeplate 2 - gen_tp2
                  _ibus[159] = 1'b0;
                  _ibus[157] = 1'b1;
                  _ibus[156] = 1'b0;
                  _ibus[154] = 1'b1;
                  _ibus[153] = 1'b0;
                  _ibus[151] = 1'b1;
                  _ibus[150] = 1'b0;
                  _ibus[148] = 1'b1;
                  _ibus[146] = 1'b0;
                  _ibus[144] = 1'b0;
                  _ibus[143] = 1'b1;
                  _ibus[141] = 1'b0;
                  _ibus[140] = 1'b1;
                  _ibus[138] = 1'b1;
                  _ibus[137] = 1'b1;
                  _ibus[135] = 1'b1;
                  _ibus[134] = 1'b1;
                  _ibus[113] = 1'b1;
                  _ibus[111] = 1'b1;
                  _ibus[36] = 1'b0;
                  _ibus[34] = 1'b1;
                  _ibus[31] = 1'b1;
                  _ibus[30] = 1'b0;
                  _ibus[28] = 1'b1;
                  _ibus[25] = 1'b0;
                  _ibus[23] = 1'b1;
                  _ibus[20] = 1'b0;
                  _ibus[18] = 1'b1;
                  _ibus[15] = 1'b0;
                  _ibus[13] = 1'b1;
                  _ibus[10] = 1'b1;
                  _ibus[7] = 1'b1;
                  if (vect[181] === 1'bz)
                    _ibus[0] = 1'bz;
                  _ibus[203:160] = vect[384:341];
                  _ibus[158] = vect[339];
                  _ibus[155] = vect[336];
                  _ibus[152] = vect[333];
                  _ibus[149] = vect[330];
                  _ibus[147] = vect[328];
                  _ibus[145] = vect[326];
                  _ibus[142] = vect[323];
                  _ibus[139] = vect[320];
                  _ibus[136] = vect[317];
                  _ibus[133:114] = vect[314:295];
                  _ibus[112] = vect[293];
                  _ibus[110:37] = vect[291:218];
                  _ibus[35] = vect[216];
                  _ibus[33:32] = vect[214:213];
                  _ibus[29] = vect[210];
                  _ibus[27:26] = vect[208:207];
                  _ibus[24] = vect[205];
                  _ibus[22:21] = vect[203:202];
                  _ibus[19] = vect[200];
                  _ibus[17:16] = vect[198:197];
                  _ibus[14] = vect[195];
                  _ibus[12:11] = vect[193:192];
                  _ibus[9:8] = vect[190:189];
                  _ibus[6:1] = vect[187:182];
                  _ibus[0] = vect[181];

                  #10; // 10 ns
                  _exp_obus[85:0] = vect[180:95];
                  _msk_obus[85:0] = vect[94:9];
                  #0;
                  ->compare_exp_sim_obus;
                  if ((_miscompare_limit)&&(_compare_fail>=_miscompare_limit)) begin
                    $display("ERROR: exceeded miscompare limit(%d), exiting simulation",_miscompare_limit);
                    _end_vec_file_ok = 1;
                    if (_DIAG_file_header == 1) begin
                       if (_diag_scan_header==1) begin
                         $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
                       end
                       $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
                       $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
                       $fwrite(_diag_file, "failure_file_end\n");
                       $fclose(_diag_file);
                    end
                    ->before_finish;
                    #0;
                    $finish;
                  end

                  #10; // 20 ns
                  _ibus[159] = vect[340];
                  _ibus[157:156] = vect[338:337];
                  _ibus[154:153] = vect[335:334];
                  _ibus[151:150] = vect[332:331];
                  _ibus[148] = vect[329];
                  _ibus[146] = vect[327];
                  _ibus[144:143] = vect[325:324];
                  _ibus[141:140] = vect[322:321];
                  _ibus[138:137] = vect[319:318];
                  _ibus[135:134] = vect[316:315];
                  _ibus[113] = vect[294];
                  _ibus[111] = vect[292];
                  _ibus[36] = vect[217];
                  _ibus[34] = vect[215];
                  _ibus[31:30] = vect[212:211];
                  _ibus[28] = vect[209];
                  _ibus[25] = vect[206];
                  _ibus[23] = vect[204];
                  _ibus[20] = vect[201];
                  _ibus[18] = vect[199];
                  _ibus[15] = vect[196];
                  _ibus[13] = vect[194];
                  _ibus[10] = vect[191];
                  _ibus[7] = vect[188];

                  #10; // 30 ns
                  _ibus[159] = 1'b0;
                  _ibus[157] = 1'b1;
                  _ibus[156] = 1'b0;
                  _ibus[154] = 1'b1;
                  _ibus[153] = 1'b0;
                  _ibus[151] = 1'b1;
                  _ibus[150] = 1'b0;
                  _ibus[148] = 1'b1;
                  _ibus[146] = 1'b0;
                  _ibus[144] = 1'b0;
                  _ibus[143] = 1'b1;
                  _ibus[141] = 1'b0;
                  _ibus[140] = 1'b1;
                  _ibus[138] = 1'b1;
                  _ibus[137] = 1'b1;
                  _ibus[135] = 1'b1;
                  _ibus[134] = 1'b1;
                  _ibus[113] = 1'b1;
                  _ibus[111] = 1'b1;
                  _ibus[36] = 1'b0;
                  _ibus[34] = 1'b1;
                  _ibus[31] = 1'b1;
                  _ibus[30] = 1'b0;
                  _ibus[28] = 1'b1;
                  _ibus[25] = 1'b0;
                  _ibus[23] = 1'b1;
                  _ibus[20] = 1'b0;
                  _ibus[18] = 1'b1;
                  _ibus[15] = 1'b0;
                  _ibus[13] = 1'b1;
                  _ibus[10] = 1'b1;
                  _ibus[7] = 1'b1;

                  #10; // 40 ns
               end // timeplate 2 - gen_tp2
               default: begin
                  $display("ERROR: corrupt timeplate number\n");
                  ->before_finish;
                  #0;
                  $finish;
               end
            endcase // _tp_num
            _cycle_count = _cycle_count + 1;
            _par_shift_cnt = 0;
         end // broadside vector
         3'b011:  begin // status message vector
            _message_index = vect[38:7];
            case (_message_index)
               0: begin
                  $display("Begin chain test\n");
                 _chain_test_ = 1;
                  _diag_chain_header = 0;
               end
               1: begin
                 _chain_test_ = 0;
                  if (_diag_chain_header) begin
                    $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
                  end
                  _diag_scan_header = 0;
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                        $display("Simulated chain pattern %d\n",_pat_num);
                    end
                  end
                  _pat_num = -1;
                  _pattern_count = 0;
                  $display("End chain test\n");
               end
               2: begin
                  $display("Status update: simulated through pattern %d\n",_pattern_count);
               end
               3: begin
                  _end_vec_file_ok = 1;
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                      if (!_chain_test_) begin
                        $display("Simulated pattern %d\n",_pat_num);
                      end
                    end
                  end
               end
               4: begin // start of atpg pattern
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                      if (_chain_test_) begin
                        $display("Simulated chain pattern %d\n",_pat_num);
                      end
                      else begin
                        $display("Simulated pattern %d\n",_pat_num);
                      end
                    end
                  end
                  _pat_num = _pat_num + 1;
                  _run_testsetup  = 0;
                  _in_testsetup  = 0;
                  if (_end_after_setup  > 0) begin
                    //simulation complete, exit
                    _index = _max_index + 1;
                    _end_vec_file_ok = 1;
                    _end_simulation = 1;
                    _in_range = 0;
                  end
               end
               default: begin
                  $display("ERROR: corrupt message index\n");
                  ->before_finish;
                  #0;
                  $finish;
               end
            endcase // _message_index
         end
         default: begin
            $display("ERROR: corrupt vector number\n");
            ->before_finish;
            #0;
            $finish;
         end
      endcase
   end // if in_range
      else begin
      case (_pat_type)  // _pat_type = vect[6:4]; 
         3'b011:  begin // status message vector
            _message_index = vect[38:7]; 
            case (_message_index)
               0: begin
                  _chain_test_ = 1;
                  _diag_chain_header = 0;
               end
               1: begin
                  if (_pat_num > -1) begin
                    $display("Skipped chain pattern %d\n",_pat_num);
                  end
                  _chain_test_ = 0;
                  _pat_num = -1;
                  $display("End chain test\n");
               end
               3: begin 
                  _end_vec_file_ok = 1;
                  if (_pat_num > -1) begin
                    if (!_chain_test_) begin
                      $display("Skipped pattern %d\n",_pat_num);
                    end
                  end
               end
               4: begin // start of atpg pattern
                  if (_pat_num > -1) begin
                    if (!_chain_test_) begin
                      _skipped_patterns = _skipped_patterns + 1;
                    end
                  end
                  if (_pat_num > -1) begin
                    if (_chain_test_) begin
                      $display("Skipped chain pattern %d\n",_pat_num);
                    end
                    else begin
                      $display("Skipped pattern %d\n",_pat_num);
                    end
                  end
                  _pat_num = _pat_num + 1;
                  _run_testsetup  = 0;
                  _in_testsetup  = 0;
                  if (_end_after_setup  > 0) begin
                    //simulation complete, exit
                    _index = _max_index + 1;
                    _end_vec_file_ok = 1;
                    _end_simulation = 1;
                    _in_range = 0;
                  end
               end
               default: begin
                  // Skip
               end
            endcase // _message_index
         end
         default: begin
            // Skip
         end
      endcase
      end // else !_in_range
   end // index loop
end // file_cnt loop

if (_save_state == 1) begin
  #1;
  mgcdft_save_signal = 1'b1;
//  $display("Writing checkpoint pat.v.dat");
//  $save("pat.v.dat");
  #1;
  $stop;
end
end
end  // while _in_restart
 if (_DIAG_file_header == 1) begin
    if (_diag_scan_header==1) begin
      $fwrite(_diag_file, "last_pattern_applied %d\n", _pattern_count);
    end
    $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
    $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
    $fwrite(_diag_file, "failure_file_end\n");
    $fclose(_diag_file);
 end


#1;
if (_end_vec_file_ok == 0) begin
  $display("ERROR: Pattern file corrupted, simulation aborted\n");
end
if ((_end_vec_file_ok) && (_compare_fail == 0)) begin
   $display("No error between simulated and expected patterns\n");
end

if (_compare_fail != 0) begin
   $display("Error between simulated and expected patterns\n");
end

#1;
->before_finish;
#0;
$finish;
end
endmodule
