// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : dec7seg.sv
// Create : 2019-09-19 09:11:37
// Editor : Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//	   Conversor de hexadecimal para display de 7 segmentos
// -----------------------------------------------------------------------------
// Entradas: 
//    x: dígito hexadecimal
// -----------------------------------------------------------------------------
// Saidas:
//    segments: codigo para exibição no display de 7 segmentos
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module hex7seg(
   input  wire [3:0] x,
   output wire [6:0] segments
);

   assign segments = ~(              // Observe a inversão
            x == 4'h0 ? 7'b0111111      
          : x == 4'h1 ? 7'b0000110
          : x == 4'h2 ? 7'b1011011
          : x == 4'h3 ? 7'b1001111
          : x == 4'h4 ? 7'b1100110 
          : x == 4'h5 ? 7'b1101101
          : x == 4'h6 ? 7'b1111101
          : x == 4'h7 ? 7'b0000111
          : x == 4'h8 ? 7'b1111111
          : x == 4'h9 ? 7'b1101111
          : 7'b0000000 );  // Para capturar um "x" que não coincide 
                           // com nenhuma das opções acima

endmodule
