// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : de2_115top.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//    Top level interface from a DE2-115 FPGA board
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none
module de2_115top #(
   parameter Nchars=4,                 // quantidade de caracteres/sprites
   parameter smem_size=1200,           // tamanho da memória da tela, 30 linhas x 40 colunas
   parameter smem_init="screen.mem", 	// arquivo de texto que inicializa a screen memory
   parameter bmem_init="bitmap.mem" 	// arquivo de texto que inicializa a bitmap memory
)(
   // Entrada do clock
   input  wire CLOCK_50,					//	50 MHz
   // Saídas do DAC VGA
   output wire VGA_CLK,					   // Clock para o controlador VGA
   output wire VGA_SYNC_N,				   // Sincronismo VGA
   output wire VGA_BLANK_N, 				// Ativação do vídeo
   output wire [7:0] VGA_R,				// Cor Red
   output wire [7:0] VGA_G,				// Cor Green
   output wire [7:0] VGA_B,				// Cor Blue
   // Sinais de controle de sincronismo VGA
   output wire VGA_HS,						// Sincronismo horizontal
   output wire VGA_VS						// Sincronismo vertical
);

   wire clk = CLOCK_50;
   wire [3:0] red, green, blue;
   wire hsync, vsync, avideo;

   wire [$clog2(smem_size)-1:0] smem_addr;
   wire [$clog2(Nchars)-1:0] charcode;

   assign VGA_R = {red,4'b0000};
   assign VGA_G = {green,4'b0000};
   assign VGA_B = {blue,4'b0000};
   assign VGA_HS = hsync;
   assign VGA_VS = vsync;
   assign VGA_CLK = CLOCK_50;
   assign VGA_BLANK_N = avideo;
   
   rom #(.Nloc(smem_size), .Dbits($clog2(Nchars)), .initfile(smem_init)) screenmem (...);
   vgadisplaydriver #(.Nchars(Nchars), .smem_size(smem_size), .bmem_init(bmem_init)) display (.clk(clk), .smem_addr, .charcode, .hsync, .vsync, .red, .green, .blue, .avideo);

endmodule