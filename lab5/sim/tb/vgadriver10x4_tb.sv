// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : vgadriver10x4_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Teste auto-verificável por meio de forma de onda.
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps

module vgadriver10x4_tb();

   // Entradas
   logic clock;

   // Saidas
   wire [3:0] red;
   wire [3:0] green;
   wire [3:0] blue;
   wire hsync;
   wire vsync;
   wire avideo;
 
   // Instancia o Design Under Test (DUT)
   vgadriver DUT (.*);

   initial begin      // Produz o clock
      clock = 0;
      forever
         #10 clock = ~clock;
   end
   
   initial begin
      #4000 $finish;
   end
      
   // initial begin
   //   $monitor("#%05d {hsync, vsync, red, green, blue} <= {2'b%b%b, 4'd%d, 4'd%d, 4'd%d};", $time, hsync, vsync, red, green, blue);
   // end
   
   selfcheckDriver selfchecker();
   wire ERROR_hsync = (hsync != selfchecker.hsync) ? 1'bx : 1'b0;
   wire ERROR_vsync = (vsync != selfchecker.vsync) ? 1'bx : 1'b0;
   wire ERROR_red   = (red   != selfchecker.red)   ? 1'bx : 1'b0;
   wire ERROR_green = (green != selfchecker.green) ? 1'bx : 1'b0;
   wire ERROR_blue  = (blue  != selfchecker.blue)  ? 1'bx : 1'b0;
   
endmodule
