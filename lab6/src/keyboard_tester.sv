// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : joaocarlos joaocarlos@ufrb.edu.br
// File   : keyboard_tester.sv
// Editor : Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//    Interface top level de uma placa FPGA DE2-115 para teste do teclado PS/2
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module keyboard_tester
   (
   // Entrada do clock
   input 	wire 			CLOCK_50, //	50 MHz
   // Push-buttons
   input	 	wire [3:0]	KEY, //	Pushbutton[3:0]
   // Interface serial PS/2
   input	 	wire 	 		PS2_CLK, //	PS/2 Clock
   input	 	wire 	 		PS2_DAT, //	PS/2 Data
   // Displays de 7 segmentos
   output 	wire [6:0]  HEX0, // Display de 7-segmentos (HEX0)
   output 	wire [6:0]  HEX1, // Display de 7-segmentos (HEX1)
   output 	wire [6:0]  HEX2, // Display de 7-segmentos (HEX2)
   output 	wire [6:0]  HEX3, // Display de 7-segmentos (HEX3)
   output 	wire [6:0]  HEX4, // Display de 7-segmentos (HEX4)
   output 	wire [6:0]  HEX5, // Display de 7-segmentos (HEX5)
   output 	wire [6:0]  HEX6, // Display de 7-segmentos (HEX6)
   output 	wire [6:0]  HEX7  // Display de 7-segmentos (HEX7)
);

   wire [6:0] segments [0:7];
   wire [31:0] keyb_char;

   keyboard keyb (.clock(CLOCK_50), .ps2_clk(PS2_CLK), .ps2_data(PS2_DAT), .keyb_char(keyb_char));
   displayNdigit #(.NDIG(8)) display (.clock(CLOCK_50), .value(keyb_char), .segments(segments));
   
   assign HEX0 = segments[0];
   assign HEX1 = segments[1];
   assign HEX2 = segments[2];
   assign HEX3 = segments[3];	
   assign HEX4 = segments[4];
   assign HEX5 = segments[5];
   assign HEX6 = segments[6];
   assign HEX7 = segments[7];	

endmodule
