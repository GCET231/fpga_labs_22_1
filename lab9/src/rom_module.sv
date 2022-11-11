// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : rom_module.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//    Single-port ROM com leitura assíncrona
// -----------------------------------------------------------------------------
// Entradas: 
//      addr   : endereço para especificar a posição da memória
// -----------------------------------------------------------------------------
// Saidas:
//      dout   : dado lido da memória 
// -----------------------------------------------------------------------------
// NOTE:  
//       Não é necessário MODIFICAR *NADA* nesse template.
//       Você NÃO precisa modificar nenhum parâmetro no top level, nem nenhuma
//       das largura de bits de endereço ou dados.
//
//       Simplesmente use diferentes valores de parâmetro quando o módulo
//       for instanciado.
//
//       Modificar qualquer coisa aqui pode gerar dores de cabeça depois!
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

// NÃO MODIFIQUE NADA NO CÓDIGO ABAIXO !!!!!!!!!!!!!!!!
// NÃO MODIFIQUE NADA NO CÓDIGO ABAIXO !!!!!!!!!!!!!!!!
// NÃO MODIFIQUE NADA NO CÓDIGO ABAIXO !!!!!!!!!!!!!!!!
// NÃO MODIFIQUE NADA NO CÓDIGO ABAIXO !!!!!!!!!!!!!!!!
// NÃO MODIFIQUE NADA NO CÓDIGO ABAIXO !!!!!!!!!!!!!!!!
// NÃO MODIFIQUE NADA NO CÓDIGO ABAIXO !!!!!!!!!!!!!!!!

module rom_module #(
   parameter Nloc = 16,                         // Quantidade de posições de memória
   parameter Dbits = 4,                         // Número de bits do dado
   parameter initfile = "mem_data.mem"          // Nome do arquivo contendo os valores iniciais
)(
   input wire [$clog2(Nloc)-1 : 0] addr,        // Endereço para especificar a posição da memória
                                                //   número de bits em addr é ceiling(log2(quantidade de posições))
   output wire [Dbits-1 : 0] dout               // Dado lido da memória (assíncrono, ou seja, contínuo)
   );

   logic [Dbits-1 : 0] mem [Nloc-1 : 0];        // Unidade de armazenamento onde o dado será guardado
   initial $readmemh(initfile, mem, 0, Nloc-1); // Inicializa o conteúdo da memória a partir de um arquivo
   
   assign dout = mem[addr];                     // Leitura da memória: leitura contínua, sem envolvimento do clock

endmodule
