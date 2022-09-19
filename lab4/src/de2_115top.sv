// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : de2_115top.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//    Interface top level da placa FPGA DE2-115
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module de2_115top
	(
		// Entrada do clock
		input  wire 		 CLOCK_50,			//	Clock de 50 MHz
		// Chaves push buttons
		input	 wire [3:0]	 KEY,					//	Pushbutton[3:0]
		// Chaves DPT switch
		input  wire [17:0] SW,					//	Toggle Switch[17:0]
		// Display de 7 segmentos
		output wire [6:0]  HEX0 				// 7-segment display HEX0
	);

	wire [3:0] digit = SW[3:0]; 
	
	wire clock = CLOCK_50;
	wire reset = KEY[0];

	//--------------------------------------------------------------------------
	//	Lógica de sáida
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	Instâncias
	//--------------------------------------------------------------------------	
	dec7seg dec7seg_u0 (.x(digit), .segments(HEX0));
   //--------------------------------------------------------------------------	

endmodule
