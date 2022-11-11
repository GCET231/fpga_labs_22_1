// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : risc231.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		Estrutura top level do processador RISC231
// -----------------------------------------------------------------------------
// Entradas: 
// 	enable : sinal de controle de escrita
// 	clk    : clock do processador
// 	reset  : sinal de reset
//    instr  : palavra da instrução de 32 bits
//    mem_readdata : dado lido da memória
// -----------------------------------------------------------------------------					
// Saidas:
// 	pc       : endereço da memória de instruções.
//    mem_wr   : habilita escrita na memória
//    mem_addr : endereço da memória de dados
//    mem_writedata   : dado a ser escrito na memória de dados
// -----------------------------------------------------------------------------
//   Não deve ser necessário modificar nada no código a seguir!!!
//   Qualquer mudança nos parâmtros deve ser feita no test bench, a partir
//   qual os parâmetros são herdados.
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module risc231_m1 #(
   // NÃO ALTERAR ESSES VALORES
   parameter WordSize=32,                     // tamanho da palavra do processador 
   parameter Nreg=32                          // quandidade de registradores
)(
   // NÃO ALTERAR
   input  wire clk, 
   input  wire reset,
   input  wire enable,    
   output wire [WordSize-1:0] pc,
   input  wire [WordSize-1:0] instr, 
   output wire mem_wr, 
   output wire [WordSize-1:0] mem_addr,
   output wire [WordSize-1:0] mem_writedata,
   input  wire [WordSize-1:0] mem_readdata
);
   
   // NÃO ALTERAR
   wire [1:0] pcsel, wdsel, wasel;
   wire [4:0] alufn;
   wire Z, sgnext, bsel, dmem_wr, werf;
   wire [1:0] asel; 

   controller c ( .enable(enable), .op(instr[31:26]), .func(instr[5:0]), .Z(Z),
                  .pcsel(pcsel), .wasel(wasel[1:0]), .sext(sext), .bsel(bsel), 
                  .wdsel(wdsel), .alufn(alufn), .wr(mem_wr), .werf(werf), .asel(asel));

   // Granta que a implementação do seu módulo datapath é parametrizado com dois parâmetros,
   //   como apresentado à seguir:
   //
   //     Nreg = quantidade de registradores no banco de registradores
   //     Dbits = quantidade de bits de dados (tanto para o tamanho dos registradores e largura da ALU)

   datapath #(.Nreg(Nreg), .Dbits(WordSize)) dp ( .clk(clk), .reset(reset), .enable(enable),
               .pc(pc), .instr(instr),
               .pcsel(pcsel), .wasel(wasel[1:0]), .sgnext(sgnext), .bsel(bsel), 
               .wdsel(wdsel), .alufn(alufn), .werf(werf), .asel(asel),
               .Z(Z), .mem_addr(mem_addr), .mem_writedata(mem_writedata), .mem_readdata(mem_readdata));

endmodule
