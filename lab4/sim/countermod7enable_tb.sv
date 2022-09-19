// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : countermod7enable_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Testbench simples para o contador módulo 7 com enable.
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps

module countermod7enable_tb;

   // Entradas para o DUT
   logic clock;
   logic reset;
   logic enable;

   // Saídas para o DUT
   wire [2:0] value;

   // Instanciação do Design Under Test (DUT)
   countermod7enable dut (
      .clock(clock), 
      .reset(reset), 
      .enable(enable), 
      .value(value)
   );

   integer i;

   initial begin
      clock = 0;
      // Cada pulso de clock possui 2 ns (1 ns alto e 1 ns baixo)
      for(i = 0; i < 12; i = i + 1) begin
         #1 clock = ~clock;
         #1 clock = ~clock;
      end
      #2 $finish;
   end
   
   initial begin
      reset = 1;  // Redefine o contado no começo
      #2 reset = 0;
      #12 reset = 1; // Redefine o contador novament
      #2 reset = 0;
   end

   initial begin
      enable = 1;
      # 12 enable = 0;
      # 6 enable = 1;
   end
   
endmodule
