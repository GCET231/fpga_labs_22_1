// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : de2_115top.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//    Top level interface from a DE2-115 FPGA board
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module de2_115top
(
   // Entrada do Clock
   input 	wire 			CLOCK_50, //	50 MHz
   // Pushbuttons
   input	 	wire [3:0]	KEY, //	Pushbutton[3:0]
   // Displays de 7 Segmentos
   output 	wire [6:0]  HEX0, // Display de 7-segmentos (HEX0)
   output 	wire [6:0]  HEX1, // Display de 7-segmentos (HEX1)
   output 	wire [6:0]  HEX2, // Display de 7-segmentos (HEX2)
   output 	wire [6:0]  HEX3, // Display de 7-segmentos (HEX3)
   output 	wire [6:0]  HEX4, // Display de 7-segmentos (HEX4)
   output 	wire [6:0]  HEX5, // Display de 7-segmentos (HEX5)
   output 	wire [6:0]  HEX6, // Display de 7-segmentos (HEX6)
   output 	wire [6:0]  HEX7  // Display de 7-segmentos (HEX7)
);

   //--------------------------------------------------------------------------
   //	Sinais internos
   //--------------------------------------------------------------------------
   
   //--------------------------------------------------------------------------

   //--------------------------------------------------------------------------
   //	Instanciação dos módulos
   //--------------------------------------------------------------------------
   
   //--------------------------------------------------------------------------
   
   //--------------------------------------------------------------------------
   //	Lógica de saída
   //--------------------------------------------------------------------------	
   
   //--------------------------------------------------------------------------	

endmodule
