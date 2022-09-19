// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : countermod4_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Testbench simples para o contador módulo 4.
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps

module countermod4_tb;

   // Intradas do DUT
   logic clock;
   logic reset;

   // Saídas do DUT
   wire [1:0] value;

   // Instanciação do Design Under Test (DUT)
   countermod4 dut (
      .clock(clock), 
      .reset(reset), 
      .value(value)
   );

   integer i;

   initial begin
      
      // Inicializa as entradas
      clock = 0;
      reset = 0;

      // Espera 5 ns antes de começar
      #5;
   
      // Método de geração de clock
      // Vamos contar durante 5 pulsos de clock
      // Cada pulso de clock possui 2 ns (1 ns alto e 1 ns baixo)
      for(i=0; i<5; i=i+1) begin
         #1 clock = ~clock;
         #1 clock = ~clock;
      end
      
      // Redefine o contador
      reset = 1; 
      #1 clock = 1;
      #1 reset = 0; 
         clock = 0; 

      // Vamos contar novamente durante 3 ciclos de clock
      for(i = 0; i < 3; i = i + 1) begin
         #1 clock = ~clock;
         #1 clock = ~clock;
      end
      
      #2 $finish;
      
   end
      
endmodule
