// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : countermod7.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		Contador módulo 7
// -----------------------------------------------------------------------------
// Entradas: 
// 	clock: clock do sistem
// 	reset: reset global 
// -----------------------------------------------------------------------------	
// Saidas:
// 	value: valor de saída do contador
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module countermod7 (
	input  wire  clock, 
	input  wire  reset,
	output logic [2:0] value // Observe como esta linha é diferente do countermod4
	);

	always @(posedge clock) begin
		value <= reset ? 3'b000 : (value /* complete o código aqui */);
	end

endmodule
