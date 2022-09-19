// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : xycounter_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Testbench simples para o contador X-Y.
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps

module xycounter_tb;

   localparam WIDTH = 5, HEIGHT = 3;  // Você deve tentar alterar esses valores
   // Entradas do DUT
   logic clock;
   logic enable;

   // Saídas do DUT
   wire [$clog2(WIDTH)-1:0] x;
   wire [$clog2(HEIGHT)-1:0] y;
      
   xycounter #(WIDTH, HEIGHT) dut (
      .clock(clock), .enable(enable), .x(x), .y(y)
   );

   initial begin
      #50 $finish;
   end
      
   initial begin
      clock = 0;
      // Cada ciclo de clock tem 2 ns (1 ns alto e 1 ns baixo)
      forever begin
      #1 clock = ~clock;
      #1 clock = ~clock;
      end
   end
      
   initial begin
      enable = 1;
      # 12 enable = 0;
      # 4 enable = 1;
   end
         
endmodule
