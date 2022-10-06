// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Autor  	: joaocarlos joaocarlos@ufrb.edu.br
// Arquivo	: displayNdigit.sv
// Editor 	: Sigasi Studio, tab size (3)
// -----------------------------------------------------------------------------
// Descrição:
//    Controle de exibição de valores hexadecimais em displays de 7 segmentos
// -----------------------------------------------------------------------------
// Entradas: 
// 	  clock : clock do sistema
// 	  value : valor a ser exibido
// -----------------------------------------------------------------------------
// Saidas:
// 	  segments : packad array contendo os segmentos
// -----------------------------------------------------------------------------
// Parâmetros:
// 	  NDIG : quantidade de displays de 7 segmentos
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module displayNdigit #(
	parameter NDIG = 4
)(
	input  wire clock,
   input  wire [(NDIG*4)-1:0] value,   
	output wire [6:0] segments [0:NDIG-1]
);

	logic [3:0] value4bit [0:NDIG-1];
	
	genvar i;

	generate 
		for ( i = 0; i < NDIG; i = i + 1)
      begin : hex_encoder
      /******** SEU CÓDIGO AQUI ********/
		
      /******** FIM DO SEU CÓDIGO ******/
      end
	endgenerate

endmodule
