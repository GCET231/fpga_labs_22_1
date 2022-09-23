`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Bittencourt
// File   : alu_32bit_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Description:
//      Módulo de teste para a ALU com 32 bits do Lab2b
// -----------------------------------------------------------------------------

`default_nettype none

module alu_32bit_tb;

   localparam width = 32;      // se você modificar a largura, certifique-se de redimensionar
                              // os operando A e B nos testes finais
   
   // Entradas
   logic [width-1:0] A;
   logic [width-1:0] B;
   logic [4:0] ALUfn;

   // Saídas
   wire [width-1:0] R;
   //wire FlagN, FlagC, FlagV;  // Retire este comentário para Parte 3
   wire FlagZ;

   // Instancia a Unit Under Test (UUT)
   alu #(width) uut (.A(A), .B(B), .R(R), .ALUfn(ALUfn),
      //.FlagN(FlagN), .FlagC(FlagC), .FlagV(FlagV), // Retire este comentário para Parte 3
      .FlagZ(FlagZ)
        );
   
   initial begin
      // Inicializa Entradas
      A = 0;
      B = 0;
      ALUfn = 0;

      // Espera 2 ns
      #2;
        
      // Adicione os estímulos aqui
      // Entradas mudam a cada 1 ns, indo de 000 até 111

      `define ADD 5'b0xx01
      `define SUB 5'b1xx01
      `define SLL 5'bx0010
      `define SRL 5'bx1010
      `define SRA 5'bx1110
      `define AND 5'bx0000
      `define OR  5'bx0100
      `define XOR 5'bx1000
      `define NOR 5'bx1100
      `define LT  5'b1x011
      `define LTU 5'b1x111

      #1 {A, B, ALUfn} = {32'd_10, 32'd_20, `ADD};            // 10 + 20
      #1 {A, B, ALUfn} = {32'd_100, 32'd_30, `ADD};           // 100 + 30
      #1 {A, B, ALUfn} = {32'd_10, 32'd_20, `SUB};            // 10 - 20      
      #1 {A, B, ALUfn} = {32'd_1, 32'd_1, `SUB};              // 1 - 1
      #1 {A, B, ALUfn} = {32'd_2, 32'd_20, `SLL};             // 20 << 2
      #1 {A, B, ALUfn} = {32'd_2, 32'd_20, `SRL};             // 20 >> 2
      #1 {A, B, ALUfn} = {32'd_1, 32'h_FFFFFFFE, `SRA};       // -2 >>> 1
      #1 {A, B, ALUfn} = {32'b11110000, 32'b00111100, `AND};  // and
      #1 {A, B, ALUfn} = {32'b11110000, 32'b00111100, `OR};   // or
      #1 {A, B, ALUfn} = {32'b11110000, 32'b00111100, `XOR};  // xor
      #1 {A, B, ALUfn} = {32'b11110000, 32'b00111100, `NOR};  // nor
      #1 {A, B, ALUfn} = {32'b00001010, 32'b00010100, `LT};   // 10 LT 20
      #1 {A, B, ALUfn} = {32'b00001010, 32'b00010100, `LTU};  // 10 LTU 20
      #1 {A, B, ALUfn} = {32'b00001010, {{24{1'b1}},8'b11101100}, `LT};   // 10 LT -20
      #1 {A, B, ALUfn} = {32'b00001010, 32'b11101100, `LTU};  // 10 LTU 236
                                
      // Espera outros 5 ns, e então finaliza a simulação
      #5 $finish;
   end
      
endmodule