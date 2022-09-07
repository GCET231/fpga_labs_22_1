`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Bittencourt
// File   : adder4bit_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Description:
//      Módulo de teste para o circuito somador de 4-bits
// -----------------------------------------------------------------------------

`default_nettype none

module adder4bit_tb();

   logic [3:0] A;
   logic [3:0] B;
   logic Cin;
   wire [3:0] Sum;
   wire Cout;

   adder4bit my4bitadder (A, B, Cin, Sum, Cout);

   integer i;

   initial begin
      // Inicializa Entradas
      A = 0;
      B = 0;
      Cin = 0;

      // Espera 5 ns antes de mudar as entradas
      #5;

      for(i = 0; i < 8; i = i + 1)
      begin
         #1 A = A + 1; B = B + 2;
      end

      #5 $finish;
   end

endmodule
