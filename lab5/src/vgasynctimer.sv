// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : xycounter.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		Gerador de sincronismo VGA
// -----------------------------------------------------------------------------
// Entradas: 
// 	clock: clock do sistema
// -----------------------------------------------------------------------------					
// Saidas:
// 	hsync: sinal de sincronismo horizontal
// 	vsync: sinal de sincronismo vertical
// 	activevideo: sinal de exibição na tela
// 	x: contador de pixel horizontal
// 	y: contador de pixel vertical
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none
`include "display10x4.svh"

module vgasynctimer (
	input  wire  clock, 
	output logic hsync,
	output logic vsync,
	output logic activevideo,
	output logic [`xbits-1:0] x,
	output logic [`ybits-1:0] y
);

	// As linhas abaixo possibilitam contar a cada 2 ciclos de clock
	// Isso acontece porque, dependendo da resolução escolhida, você pode
	//   precisar contar a 50 MHz ou 25 MHz. Neste roteiro consideramos a  
	//   resolução 640x480 a qual utiliza o clock de 25 MHz.

	logic clock_count = 0;

	always @(posedge clock) begin : proc_clock_count
		clock_count <= clock_count + 1'b1;
	end
	
	wire Every2ndTick;

	assign Every2ndTick = (clock_count == 1'b1);

	// Esta parte instancia um xy-counter usando o contador de clock adequado 
	// xycounter #(`WholeLine, `WholeFrame) xy (clock, 1'b1, x, y); // Conta em 50 MHz
	xycounter #(`WholeLine, `WholeFrame) xy (.clock(clock), .enable(Every2ndTick), .x(x), .y(y)); // Conta em 25 MHz
   
   assign activevideo 	= /* Substitua a sua atribuição aqui */;
   assign hsync 			= /* Substitua a sua atribuição aqui */;
   assign vsync 			= /* Substitua a sua atribuição aqui */;

   
endmodule
