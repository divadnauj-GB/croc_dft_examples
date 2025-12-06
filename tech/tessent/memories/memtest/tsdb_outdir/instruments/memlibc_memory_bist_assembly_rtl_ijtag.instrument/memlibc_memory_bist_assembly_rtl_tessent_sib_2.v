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

module memlibc_memory_bist_assembly_rtl_tessent_sib_2 (
   input  wire         ijtag_reset,
   input  wire         ijtag_sel,
   input  wire         ijtag_si,
   input  wire         ijtag_ce,
   input  wire         ijtag_se,
   input  wire         ijtag_ue,
   input  wire         ijtag_tck,
   output wire         ijtag_so,
   input  wire         ijtag_from_so,
   output wire         ijtag_to_sel
);
   reg            sib;
   reg            sib_latch;
   reg            retiming_so;
   reg            to_enable_int;
 
   assign ijtag_to_sel = to_enable_int & ijtag_sel;
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
 
endmodule
