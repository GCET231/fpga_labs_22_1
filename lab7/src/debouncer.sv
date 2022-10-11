// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Autor  	: joaocarlos joaocarlos@ufrb.edu.br
// Arquivo	: debouncer.sv
// Editor 	: Sigasi Studio, tab size (3)
// -----------------------------------------------------------------------------
// Descrição:
//    Limpa o sinal do efeito bounce causado por contatos mecânicos.
// -----------------------------------------------------------------------------
// Entradas: 
// 	  raw   : entrada vinda de um botão ou chave
// 	  clk   : clock do sistema
// -----------------------------------------------------------------------------
// Saidas:
// 	  clean : sinal limpo
// -----------------------------------------------------------------------------
// Parâmetros:
// 	  N : Quantidade de pulsos de clock (2^N)
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module debouncer #(parameter N=20)(
   input wire raw,
   input wire clk,
   output logic clean = 0
);

	logic [N:0] count;
	
	always @(posedge clk) begin
		count <= (raw != ...)  ? ........... :  ......... ;
		clean <= (count[N] == ...) ? ......... : .......... ;
	end
	
endmodule
