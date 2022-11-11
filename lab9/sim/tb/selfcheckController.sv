// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : selfcheckController.sv
// Editor : Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Módulo de auto-verificacao para o Controller_Tb
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module selfcheckController();
   logic [1:0] pcsel;
   logic [1:0] wasel;
   logic sext;
   logic bsel;
   logic [1:0] wdsel;
   logic [4:0] alufn;
   logic wr;
   logic werf;
   logic [1:0] asel;
      
   initial begin
      fork
         #00 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'bxxxxxxxxxxxxx00xx};
         #01 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b000111100xx010100};
         #02 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b00xx11xx0xx011000};
         #03 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b000111010xx010100};
         #05 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b000111011x0110100};
         #06 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b000111011x1110100};
         #07 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b00010101x01000100};
         #08 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0001x101x00100110};
         #09 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b00010101x00000100};
         #10 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b00010101x10000100};
         #11 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b00xx10xx1xx010000};
         #12 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b01xx10xx1xx010000};
         #14 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b00xx10xx1xx010000};
         #15 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b10xxxxxxxxxxx00xx};
         #16 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b1010xx00xxxxx01xx};
         #17 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x0010xx010100};
         #19 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x0011xx010100};
         #20 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x00000100};
         #21 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x01000100};
         #22 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x10000100};
         #23 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x11000100};
         #24 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x0011x0110100};
         #25 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x0011x1110100};
         #26 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x00100101};
         #27 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x00100100};
         #28 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x10100101};
         #29 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x10100100};
         #30 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x11100101};
         #31 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x001x11100100};
         #32 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b11xxxxxxxxxxx00xx};
         #33 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b1100xx00xxxxx01xx};
         #34 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x0010xx010100};
         #35 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x0010xx010000};
         #37 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b0000x0010xx010100};
         #38 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b00xx11xx0xx011000};
         #39 {pcsel, wasel, sgnext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b00xx11xx0xx010000};   
      join
   end
endmodule