// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : debounce_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Módulo de simulação para o circuito debouncer.
// -----------------------------------------------------------------------------
// Notes:
//      Para a simulação, N=20 é obviamente muito longo. Portanto o testador
//      instancia um debouncer com N=4, de modo que o intervalo de debounce
//      seja apenas 16 pulsos de clock, não 2^20! A saída do debouncer deve
//      mudar no pulso de clock 17 após a entrada direta terminar de pulsar.
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module debounce_tb();

   // Entradas para a UUT
   logic clock=0;
   logic rawX=0;

   // Saídas da UUT
   wire cleanX;

   // Instancia a Unit Under Test (UUT)
   debouncer #(4) uut (
      .raw(rawX),
      .clk(clock), 
      .clean(cleanX)
   );

   initial begin      // gerando o clock clock
      forever begin   // Cada ciclo de clock é de 1ns (0.5 ns alto and 0.5 ns baixo)
         #0.5 clock = ~clock;
         #0.5 clock = ~clock;
      end
   end
   
   initial begin
      #100 $finish;   // Encerra a simulação após 100 ns
   end

   integer i;
   initial begin
      #10;
      for(i=0; i<30; i++) begin
         #0.33 rawX = $urandom_range(0,1); 	// Valor aleatório sem sinal de 0 a 1
      end
      #0.33 rawX = 1;
      
      #30;
      for(i=0; i<30; i++) begin
         #0.33 rawX = $urandom_range(0,1);
      end
      #0.33 rawX = 0;
   end    

endmodule
