`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Bittencourt
// File   : addsub_test.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Description:
//      Módulo de teste para o Lab2b Parte 0
// -----------------------------------------------------------------------------

`default_nettype none

module addsub_param_tb;

   localparam N=8;   // Tente modificar este valor para 32
    
   // Entradas
   logic [N-1:0] A;
   logic [N-1:0] B;
   logic Subtract;

   // Saídas
   wire [N-1:0] Result;
   wire FlagN, FlagC, FlagV;

   // Instancia a Unit Under Test (UUT)
   // O parâmetro #(N) instancia um addsub de N-bit
   addsub #(N) uut (A, B, Subtract, Result, FlagN, FlagC, FlagV);     

   integer i;

   initial begin
      // Inicializa Entradas
      A = 0;
      B = 0;
      Subtract = 0;

      // Espera 5 ns para que o reset global finalize
      #5;
        
      // Vamos testar algumas somas
      for(i=0; i<4; i=i+1)
      begin
        #1 A = A + 11; B = B + 15;
      end
        
      // Vamos tentar algumas subtrações
      #5 Subtract = 1; A = 50; B = 10;
      for(i=0; i<4; i=i+1)
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
