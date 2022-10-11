// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : seebounce.sv
// Editor : Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//    Interface top level para a placa DE2-115 FPGA
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module seebounce (
   // Entrada do clock
   input   wire         CLOCK_50,      //  50 MHz
   // Push Buttons e Chaves
   input   wire [3:0]   KEY,
   input   wire [17:0]  SW,          //  Pushbutton[3:0]
   // Displays de 7 segmentos
   output  wire [6:0]   HEX0,         // Display de 7-segmentos (HEX0)
   output  wire [6:0]   HEX1,         // Display de 7-segmentos (HEX1)
   output  wire [6:0]   HEX2,         // Display de 7-segmentos (HEX2)
   output  wire [6:0]   HEX3,         // Display de 7-segmentos (HEX3)
   output  wire [6:0]   HEX4,         // Display de 7-segmentos (HEX0)
   output  wire [6:0]   HEX5,         // Display de 7-segmentos (HEX1)
   output  wire [6:0]   HEX6,         // Display de 7-segmentos (HEX2)
   output  wire [6:0]   HEX7          // Display de 7-segmentos (HEX3)
);

   logic X;
   assign X  = SW[0];
   
   // Para a primeira parte, remova o comentários das duas linhas abaixo para incluir um debouncer
   // wire cleanX;
   // debouncer #(10) d(X, CLOCK_50, cleanX);    // Escolha o parâmetro N apropriadamente
   // Use cleanX no lugar de X abaixo para incrementar numBounces
   localparam NDIG = 8;

   logic [31:0] numBounces = 0;
   logic [6:0]  segments [0:NDIG-1];

   always @(posedge cleanX)
      numBounces <= numBounces + 1'b1;    // Vamos contar o número de "bounces"

   displayNdigit #(.NDIG(NDIG)) mydisplay (CLOCK_50, numBounces, segments);

   //--------------------------------------------------------------------------
   // Atribuições de saída
   //--------------------------------------------------------------------------
   assign HEX0 = segments[0];
   assign HEX1 = segments[1];
   assign HEX2 = segments[2];
   assign HEX3 = segments[3]; 
   assign HEX4 = segments[4];
   assign HEX5 = segments[5];
   assign HEX6 = segments[6];
   assign HEX7 = segments[7]; 
		
endmodule
