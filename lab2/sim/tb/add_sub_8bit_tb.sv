`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Bittencourt
// File   : addsub_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Description:
//      Módulo de teste para o circuito somador-subtrator
// -----------------------------------------------------------------------------
`default_nettype none

module add_sub_8bit_tb;

	// Entradas
	logic [7:0] A;
	logic [7:0] B;
	logic Subtract;

	// Saídas
	wire [7:0] Result;

	// Instancia a Unit Under Test (UUT)
	add_sub_8bit uut (
		.A(A), 
		.B(B), 
		.Subtract(Subtract), 
		.Result(Result)
	);

	integer i;		// para controlar o laço abaixo que produz os vários conjuntos de entrada

	initial begin
		// Inicializa as entradas
		A = 0;
		B = 0;
		Subtract = 0;

		// Espera 5 ns para que o reset global finalize
		#5;
        
		// Vamos testar algumas somas
		for(i = 0; i < 4; i = i + 1)
		begin
		  #1 A = A + 11; B = B + 15;
		end
		  
		// Vamos tentar algumas subtrações
		#5 Subtract = 1; A = 50; B = 10;
		for(i = 0; i < 4; i = i + 1)
		begin
			#1 A = A - 10; B = B + 10;
		end
		
		#5 $finish;
	end
	
	initial begin
		//  detine o tempo para ser exibido em ns, com duas casas decimais
		//  e uma largura de 10 caracteres
		$timeformat(-9, 2, " ns", 10);
		$monitor("At time %t:  A=%d, B=%d, Subtract=%b, ToBornottoB=%b, Result=%d (%b)", 
					$time, A, B, Subtract, uut.ToBornottoB, Result, Result);
	end
	
endmodule
