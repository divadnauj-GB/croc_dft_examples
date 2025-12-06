// SYNC 1RW Memory
// Configured as 8Kx16 for hierarchical test case 
// Mentor Graphics
// =====================================
`timescale 1 ns/10 ps
`celldefine
module SYNC_1RW_8Kx16 (
   Q,
   CLK,
   CEN,
   WEN,
   A,
   D,
   OEN
);
   parameter		   BITS = 16;
   parameter		   word_depth = 8192;
   //parameter		   addr_width = 12;
   parameter		   wordz = {BITS{1'bz}};
   parameter		   wordx = {BITS{1'bx}};

   output [15:0] Q;
   input CLK;
   input CEN;
   input WEN;
   input [12:0] A;
   input [15:0] D;
   input OEN;

   reg [15:0]	   MEM [word_depth-1:0];
   reg [15:0]	   Q_REG;

assign Q = (~OEN) ? Q_REG : wordz ;

always @ (posedge CLK) begin
   if (~CEN) begin
      if (~WEN) begin
         MEM[A] <= D;
         Q_REG  <= D;
      end else begin
         Q_REG  <= MEM[A];
      end
   end
end
endmodule
`endcelldefine