// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : xycounter.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		Contador X-Y parametrizado
// -----------------------------------------------------------------------------
// Entradas: 
// 	clock: clock do sistem
// 	reset: reset global 
// -----------------------------------------------------------------------------
// Saidas:
// 	value: valor de saída do contador
// -----------------------------------------------------------------------------
// Parameters:
//		WIDTH: bus withs for x
//		HEIGHT: bus withs for y
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module xycounter #(
	parameter WIDTH=2, 
	parameter HEIGHT=2
	)(
	input  wire clock,   
	input  wire enable,  
	output logic [$clog2(WIDTH)-1:0]  x = 0,
	output logic [$clog2(HEIGHT)-1:0] y = 0
	);

always @(posedge clock) begin
	if (enable) begin
		/* Coloque seu código aqui */
	end	
end
endmodule
