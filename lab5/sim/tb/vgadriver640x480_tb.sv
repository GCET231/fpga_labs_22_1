// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : vgadriver640x480_tb.sv
// Editor : Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Teste auto-verificável por meio de forma de onda para a resolução
//      VGA padrão 640x480.
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module vgadriver640x480_tb();

   // Entradas
   logic clk;

   // Saídas
   wire [3:0] red;
   wire [3:0] green;
   wire [3:0] blue;
   wire hsync;
   wire vsync;
 
   // Instancia o Design Under Test (DUT)
   vgadisplaydriver uut (.*);

   initial begin      // Produz o clock
      clk = 0;
      forever
         #10 clk = ~clk;
   end
   
   initial begin
      #16832000 $finish;
   end
      
   //initial begin
   //   $monitor("#%05d {hsync, vsync, red, green, blue} <= {2'b%b%b, 4'd%d, 4'd%d, 4'd%d};", $time, hsync, vsync, red, green, blue);
   //end
   
   selfcheckDriverVGA c();
   
   function mismatch;   // alguns ajustes necessários para comparar dois valores com don't cares
       input p, q;      // diferença em uma posição de bit é ignorada se q possui um 'x' naquele bit
       integer p, q;
       mismatch = (((p ^ q) ^ q) !== q);
   endfunction
   
   wire ERROR;       
   wire ERROR_hsync = mismatch(hsync, c.hsync)? 1'bx : 1'b0;
   wire ERROR_vsync = mismatch(vsync, c.vsync)? 1'bx : 1'b0;
   wire ERROR_red   = mismatch(red, c.red)? 1'bx : 1'b0;
   wire ERROR_green = mismatch(green, c.green)? 1'bx : 1'b0;
   wire ERROR_blue  = mismatch(blue, c.blue)? 1'bx : 1'b0;
   assign ERROR = ERROR_hsync | ERROR_vsync | ERROR_red | ERROR_green | ERROR_blue;
   
endmodule