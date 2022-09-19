// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : countermod7_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Testbench simples para o contador módulo 7.
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps

module countermod7_tb;

   // Entradas para o DUT
   logic clock;
   logic reset;

   // Saídas para o DUT
   wire [2:0] value;

   // Instanciação do Design Under Test (DUT)
   countermod7 dut (
      .clock(clock), 
      .reset(reset), 
      .value(value)
   );

   integer i;

   initial begin
      
      // Inicializa as entradas
      clock = 0;
      reset = 0;

      // Espera 2 ns e então redefine o contador
      #1 reset = 1;
      #1 clock = 1;
      #1 reset = 0; 
         clock = 0; 
   
      // Vamos contar 8 ciclos de clock
      // Cada ciclo de clock possui 2 ns (1 ns alto e 1 ns baixo)
      for(i = 0; i < 8; i = i + 1) begin
         #1 clock = ~clock;
         #1 clock = ~clock;
      end
      
      // Espera 2 ns e então redefine o contador
      reset = 1;
      #1 clock = 1;
      #1 reset = 0; 
         clock = 0; 

      // Vamos contar novamente 2 ciclos de clock
      for(i = 0; i < 2; i = i + 1) begin
         #1 clock = ~clock;
         #1 clock = ~clock;
      end
      
      #2 $finish;   
   end
      
endmodule
