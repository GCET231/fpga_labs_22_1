// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : joaocarlos joaocarlos@ufrb.edu.br
// File   : keyboard.sv
// Editor : Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		Trata o recebimento de dados através de um conector serial PS/2
// -----------------------------------------------------------------------------
// Entradas: 
// 	clock: clock de 50 MHz
//    ps2_clk: clock do teclado PS/2
//    ps2_clk: dado do teclado PS/2
// -----------------------------------------------------------------------------
// Saidas:
// 	keyb_char: byte correspondente ao caractere introduzido no teclado
// -----------------------------------------------------------------------------
// Histórico de modificações
//    - modificada a lógica para que scancodes parciais sejam armazenados;
//        a saída é atualizada somente quando o scancode completo for recebido
//    - modificada a saída keyb_char para 32 bits no lugar de 24 bits;
//        as versões anteriores possuiam 8 bits MSB flutuando no testador
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module keyboard(
   input wire clock,
   input wire ps2_clk,
   input wire ps2_data,
   output logic [31:0] keyb_char
   );

   logic [31:0] temp_char = 0;
   logic [9:0]  bits = 0;
   logic [3:0]  count = 0;
   logic [1:0]  ps2_clk_prev2 = 2'b11;
   logic [19:0] timeout = 0;
   
   always @(posedge clock)
      ps2_clk_prev2 <= {ps2_clk_prev2[0], ps2_clk};
      
   always @(posedge clock)
   begin
      if((count == 11) || (timeout[19] == 1))
      begin
         count <= 0;
         if((temp_char[7:0] == 8'hE0) || (temp_char[7:0] == 8'hF0)) begin       
            // se o byte anterior foi E0 ou F0
            temp_char[31:0] <= {temp_char[23:0], bits[7:0]};                    
            // introduz o novo byte à direita, ou seja, continua o scancode
            if((bits[7:0] != 8'hE0) && (bits[7:0] != 8'hF0))                    
               // se o novo byte não for E0 ou F0
               keyb_char <= {temp_char[23:0], bits[7:0]};                       
               // atualiza a saída
         end
         else begin                                                             
            // o byte anterior não foi E0 ou F0
            temp_char[31:0] <= {24'b0, bits[7:0]};                              
            // o novo byte se torna o início do scancode
            if((bits[7:0] != 8'hE0) && (bits[7:0] != 8'hF0))                    
            // se o novo byte não for E0 ou F0
               keyb_char <= {24'b0, bits[7:0]};                                 
               // atualiza a saída      
         end
      end
      else
      begin
         if(ps2_clk_prev2 == 2'b10)
         begin
            count <= count + 1;
            bits <= {ps2_data, bits[9:1]};
         end
      end
   end
   
   always @(posedge clock)
      timeout <= (count != 0) ? timeout + 1 : 0;

endmodule
