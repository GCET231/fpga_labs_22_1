// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : vgasynctimer10x4_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Teste auto-verificável por meio de forma de onda.
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
module vgasynctimer10x4_tb();

   // Entradas
   logic clock;
   
   // Saidas
   wire hsync;
   wire vsync;
   wire activevideo;
   wire [3:0] x;
   wire [2:0] y;
 
   // Instancia o Design Under Verificatio (DUV)
   vgasynctimer DUT (.*);

   initial begin      // Produz o clock
      clock = 0;
      forever
         #10 clock = ~clock;
   end
   
   initial begin
      #4000 $finish;
   end
      
   // initial begin
   //   $monitor("#%04d {hsync, vsync, activevideo} <= 3'b%b%b%b;", $time, hsync, vsync, activevideo);
   // end
   
   selfcheckSync selfchecker();
   wire ERROR_hsync        = (hsync != selfchecker.hsync)? 1'bx : 1'b0;
   wire ERROR_vsync        = (vsync != selfchecker.vsync)? 1'bx : 1'b0;
   wire ERROR_activevideo  = (activevideo != selfchecker.activevideo)? 1'bx : 1'b0;
 
endmodule
