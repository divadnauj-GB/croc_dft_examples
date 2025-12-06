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

module memlibc_memory_bist_assembly_rtl_tessent_sib_1 (
   input  wire         ijtag_reset,
   input  wire         ijtag_sel,
   input  wire         ijtag_si,
   input  wire         ijtag_ce,
   input  wire         ijtag_se,
   input  wire         ijtag_ue,
   input  wire         ijtag_tck,
   output wire         ijtag_so,
   input  wire         ijtag_from_so,
   input  wire         ltest_si,
   input  wire         ltest_scan_en,
   input  wire         ltest_en,
   input  wire         ltest_clk,
   input  wire         ltest_mem_bypass_en,
   input  wire         ltest_mcp_bounding_en,
   input  wire         ltest_occ_en,
   input  wire         ltest_async_set_reset_static_disable,
   input  wire         ltest_static_clock_control_mode,
   input  wire   [1:0] ltest_clock_sequence,
   output wire         ijtag_to_tck,
   output wire         ijtag_to_reset,
   output wire         ijtag_to_si,
   output wire         ijtag_to_ce,
   output wire         ijtag_to_se,
   output wire         ijtag_to_ue,
   output wire         ltest_so,
   output wire         ltest_to_en,
   output wire         ltest_to_mem_bypass_en,
   output wire         ltest_to_mcp_bounding_en,
   output wire         ltest_to_scan_en,
   output wire         ijtag_to_sel
);
   reg            sib;
   reg            sib_latch;
   reg            retiming_so;
   reg            to_enable_int;
   reg            ltest_to_si;
   reg            retiming_ltest_to_si;
   reg [1:0]      ltest_ce_se_ue;
   reg            retiming_ltest_to_ce;
   reg            retiming_ltest_to_se;
   reg            ltest_to_sel;
   reg            ltest_so_retiming;
   reg            ltest_to_reset;
   reg            retiming_ltest_to_sel;
   reg [1:0]      occ_ctrl;
   reg            occ_ctrl_so_retimed;
   wire           occ_ctrl_so;
   wire           occ_clock_out;
 
   assign ltest_to_en = ltest_en;
   assign ltest_to_mem_bypass_en = ltest_en & ltest_mem_bypass_en;
   assign ltest_to_mcp_bounding_en = ltest_en & ltest_mcp_bounding_en;
   assign ltest_to_scan_en = ltest_en & ltest_scan_en;
   assign ijtag_to_sel = ltest_en ? ltest_to_sel : to_enable_int & ijtag_sel;
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         sib_latch     <= 1'b0;
      end else if (ijtag_ue & ijtag_sel) begin
         sib_latch     <= sib;
      end
   end
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
      if (~ijtag_reset) begin
         to_enable_int <= 1'b0;
      end else  begin
         to_enable_int <= sib_latch;
      end
   end
 
   assign ijtag_so = retiming_so;
    always @ (ijtag_tck or sib) begin
      if (~ijtag_tck) begin
         retiming_so     <= sib;
      end
   end
 
   always @ (posedge ijtag_tck) begin
      if (ijtag_ce & ijtag_sel) begin
         sib <= 1'b0;
      end else if (ijtag_se & ijtag_sel) begin
         if (sib_latch) begin
            sib <= ijtag_from_so;
         end else begin
            sib <= ijtag_si;
         end
      end
   end
 
   memlibc_memory_bist_assembly_rtl_tessent_mux2 tessent_persistent_cell_ltest_reset_mux (
     .b                   (ltest_to_reset | (ltest_scan_en || ltest_async_set_reset_static_disable)),
     .a                   (ijtag_reset),
     .s                   (ltest_en),
     .y                   (ijtag_to_reset)
   );
   assign ijtag_to_si    =  ltest_en ? retiming_ltest_to_si : ijtag_si;
   assign ijtag_to_ce    = ltest_en ? ~ltest_ce_se_ue[1] &  ltest_ce_se_ue[0] : ijtag_ce;
   assign ijtag_to_se    = ltest_en ?  ltest_ce_se_ue[1] & ~ltest_ce_se_ue[0] : ijtag_se;
   assign ijtag_to_ue    = ltest_en ?  ltest_ce_se_ue[1] &  ltest_ce_se_ue[0] : ijtag_ue;
   assign ltest_so       = ltest_so_retiming;
   always @ (posedge ijtag_to_tck) begin
     if (ltest_scan_en) begin
       ltest_to_sel <= ltest_ce_se_ue[1];
       ltest_ce_se_ue[1] <= ltest_ce_se_ue[0];
       ltest_ce_se_ue[0] <= retiming_ltest_to_si;
       ltest_to_si <= ltest_to_reset;
       ltest_to_reset <= occ_ctrl_so;
     end else begin
       ltest_to_si <= ijtag_from_so;
       ltest_ce_se_ue <= ltest_ce_se_ue;
       ltest_to_sel <= ltest_to_sel;
       ltest_to_reset <= ltest_to_reset;
     end
   end
   wire ltest_clk_buf;

   wire         ltest_scan_en_buf_out;
   wire         static_clock_control_mode_buf_out;
   wire   [1:0] clock_sequence_buf_out;
   wire         ltest_scan_in_buf_out;
   wire         occ_ctrl_so_buf_in;

   memlibc_memory_bist_assembly_rtl_tessent_buf tessent_persistent_cell_ltest_scan_en_buf (
      .a                 ( ltest_scan_en ),
      .y                 ( ltest_scan_en_buf_out )
   );
   memlibc_memory_bist_assembly_rtl_tessent_buf tessent_persistent_cell_static_clock_control_mode_buf (
      .a                 ( ltest_static_clock_control_mode ),
      .y                 ( static_clock_control_mode_buf_out )
   );
   memlibc_memory_bist_assembly_rtl_tessent_buf tessent_persistent_cell_clock_sequence_buf_0 (
      .a                 ( ltest_clock_sequence[0] ),
      .y                 ( clock_sequence_buf_out[0] )
   );
   memlibc_memory_bist_assembly_rtl_tessent_buf tessent_persistent_cell_clock_sequence_buf_1 (
      .a                 ( ltest_clock_sequence[1] ),
      .y                 ( clock_sequence_buf_out[1] )
   );
   memlibc_memory_bist_assembly_rtl_tessent_buf tessent_persistent_cell_ltest_scan_in_buf (
      .a                 ( ltest_si ),
      .y                 ( ltest_scan_in_buf_out )
   );
   memlibc_memory_bist_assembly_rtl_tessent_buf tessent_persistent_cell_occ_ctrl_so_buf (
      .a                 ( occ_ctrl_so_buf_in ),
      .y                 ( occ_ctrl_so )
   );
   memlibc_memory_bist_assembly_rtl_tessent_clk_buf tessent_persistent_cell_cts_stop_buf (
     .a                  ( ltest_clk ),
     .y                  ( ltest_clk_buf )
   );
   always @ (posedge ltest_clk_buf) begin
     if (ltest_scan_en_buf_out) begin
       if (static_clock_control_mode_buf_out) begin
          occ_ctrl[1:0] <= clock_sequence_buf_out;
       end else begin
         occ_ctrl[1:0] <= {ltest_scan_in_buf_out,occ_ctrl[1]};
       end
     end else begin
       occ_ctrl[1:0] <= {1'b0,occ_ctrl[1]};
     end
   end
   always @ (negedge ltest_clk_buf) begin
     occ_ctrl_so_retimed <= occ_ctrl[0];
   end
   assign occ_ctrl_so_buf_in = (static_clock_control_mode_buf_out) ? ltest_scan_in_buf_out : occ_ctrl_so_retimed;
 
   memlibc_memory_bist_assembly_rtl_tessent_clk_gate_and tessent_persistent_cell_occ_clock_gate (
     .clkg               ( occ_clock_out),
     .clk                ( ltest_clk ),
     .fe                 ( occ_ctrl[0] & ltest_occ_en),
     .te                 ( ltest_scan_en_buf_out)
   );
    
   memlibc_memory_bist_assembly_rtl_tessent_clk_mux2 tessent_persistent_cell_ltest_clock_mux (
     .a                  ( ijtag_tck ),
     .b                  ( occ_clock_out ),
     .s                  ( ltest_en ),
     .y                  ( ijtag_to_tck )
   );
   
    always @ (ijtag_to_tck or ltest_to_si) begin
     if (~ijtag_to_tck) begin
       retiming_ltest_to_si <= ltest_to_si;
     end
   end 
   always @ (ijtag_to_tck or ltest_to_sel) begin
     if (~ijtag_to_tck) begin
       ltest_so_retiming <= ltest_to_sel;
     end
   end
endmodule
