// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : counter4digit.sv
// Editor : Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//    Interface top level de uma placa FPGA DE2-115
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module counter4digit
(
   // Entrada do clock
   input 	wire 			CLOCK_50,			//	50 MHz
   // Push-buttons
   input	 	wire [3:0]	KEY,					//	Pushbutton[3:0]
      // Displays de 7 segmentos
   output 	wire [6:0]  HEX0, 				// Display de 7-segmentos (HEX0)
   output 	wire [6:0]  HEX1, 				// Display de 7-segmentos (HEX1)
   output 	wire [6:0]  HEX2, 				// Display de 7-segmentos (HEX2)
   output 	wire [6:0]  HEX3 				   // Display de 7-segmentos (HEX3)
);

   //--------------------------------------------------------------------------
   //	Parâmetros internos
   //--------------------------------------------------------------------------
   localparam NDIG = 4;

   //--------------------------------------------------------------------------
   //	Sinais internos
   //--------------------------------------------------------------------------
   logic [6:0]  segments [0:NDIG-1];
   logic reset;
   logic clock;

   //--------------------------------------------------------------------------
   //	Atribuições de entrada
   //--------------------------------------------------------------------------
   assign reset = ~KEY[0];
   assign clock = CLOCK_50;

   //--------------------------------------------------------------------------
   //	Instanciação de módulos
   //--------------------------------------------------------------------------	
   
   //--------------------------------------------------------------------------

   //--------------------------------------------------------------------------
   //	Atribuições de saída
   //--------------------------------------------------------------------------
   assign HEX0 = segments[0];
   assign HEX1 = segments[1];
   assign HEX2 = segments[2];
   assign HEX3 = segments[3];	

endmodule
