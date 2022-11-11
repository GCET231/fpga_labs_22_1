// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : selfcheckDatapath.sv
// Editor : Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Módulo de auto-verificacao para o Datapath_Tb
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
module selfcheckDatapath();
   logic [31:0] RD1, RD2;
   logic [31:0] ALUResult;
   logic FlagZ;
      
   initial begin
      fork
         #0 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000000, 32'h00000000, 32'h00000000, 1'b1};
         #3 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000000, 32'h00000001, 32'h00000001, 1'b0};
         #4 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000007, 32'h00000001, 32'h00000008, 1'b0};
         #5 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000007, 32'h0000000b, 32'h00000012, 1'b0};
         #6 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000003, 32'h0000000b, 32'hfffffff8, 1'b0};
         #7 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000008, 32'h0000000b, 32'h00000003, 1'b0};
         #8 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000003, 32'h0000000b, 32'h00000058, 1'b0};
         #9 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000003, 32'h00000028, 32'h00000005, 1'b0};
         #10 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000003, 32'hffffff00, 32'hffffffe0, 1'b0};
         #11 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000ffff, 32'hffffff00, 32'h0000ff00, 1'b0};
         #12 {RD1, RD2, ALUResult, FlagZ} <= {32'hffffff00, 32'h0000ffff, 32'hffffffff, 1'b0};
         #13 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000ffff, 32'hffffff00, 32'h00000000, 1'b1};
         #14 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000000a, 32'h00000010, 32'h00000001, 1'b0};
         #15 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000010, 32'h0000000a, 32'h00000000, 1'b1};
         #16 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000000a, 32'h00000010, 32'h00000001, 1'b0};
         #17 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000000a, 32'hfffffff0, 32'h00000000, 1'b1};
         #18 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000000a, 32'hfffffff0, 32'h00000001, 1'b0};
      join
   end
endmodule