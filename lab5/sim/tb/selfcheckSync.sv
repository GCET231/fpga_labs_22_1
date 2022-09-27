// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : selfcheckSync.sv
// Editor : Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Módulo de auto-verificacao para o VGASyncTimer10x4
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
module selfcheckSync();
      logic hsync, vsync, activevideo;
   initial begin
      fork
      #0000 {hsync, vsync, activevideo} <= 3'b111;
      #0390 {hsync, vsync, activevideo} <= 3'b110;
      #0430 {hsync, vsync, activevideo} <= 3'b010;
      #0510 {hsync, vsync, activevideo} <= 3'b110;
      #0550 {hsync, vsync, activevideo} <= 3'b111;
      #0950 {hsync, vsync, activevideo} <= 3'b110;
      #0990 {hsync, vsync, activevideo} <= 3'b010;
      #1070 {hsync, vsync, activevideo} <= 3'b110;
      #1110 {hsync, vsync, activevideo} <= 3'b111;
      #1510 {hsync, vsync, activevideo} <= 3'b110;
      #1550 {hsync, vsync, activevideo} <= 3'b010;
      #1630 {hsync, vsync, activevideo} <= 3'b110;
      #1670 {hsync, vsync, activevideo} <= 3'b111;
      #2070 {hsync, vsync, activevideo} <= 3'b110;
      #2110 {hsync, vsync, activevideo} <= 3'b010;
      #2190 {hsync, vsync, activevideo} <= 3'b110;
      #2670 {hsync, vsync, activevideo} <= 3'b010;
      #2750 {hsync, vsync, activevideo} <= 3'b110;
      #2790 {hsync, vsync, activevideo} <= 3'b100;
      #3230 {hsync, vsync, activevideo} <= 3'b000;
      #3310 {hsync, vsync, activevideo} <= 3'b100;
      #3350 {hsync, vsync, activevideo} <= 3'b110;
      #3790 {hsync, vsync, activevideo} <= 3'b010;
      #3870 {hsync, vsync, activevideo} <= 3'b110;
      #3910 {hsync, vsync, activevideo} <= 3'b111;
      join
   end
endmodule