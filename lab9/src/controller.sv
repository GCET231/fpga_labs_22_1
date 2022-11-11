// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : controller.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		Unidade de controle para o processador RISC231-M1
// -----------------------------------------------------------------------------
// Entradas: 
// 	enable : sinal de controle de escrita
// 	op     : opcode da instrução
// 	func   : função para instruções R-type
//    Z      : flag zero vinda da ALU
// -----------------------------------------------------------------------------					
// Saidas:
// 	pcsel  : seletor do multiplexador de PC.
//    wasel  : seletor do multiplexador do endereço de escrita no register file
//    sext   : controle do sign extend (0 zero-extends, 1 sign-extends)
//    bsel   : seletor do multiplexador da entrada B da ALU
//    wdsel  : seletor do multiplexador de dados de escrita no register file
//    alufn  : função a ser executada pela ALU
//    wr     : write enable da memória de dados
//    werf   : write enable do register file
//    asel   : seletor do multiplexador da entrada A da ALU
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps
`default_nettype none

`define LW     6'b 100011
`define SW     6'b 101011

`define ADDI   6'b 001000
`define ADDIU  6'b 001001     // NOTE:  addiu *estende o sinal* do imediato
`define SLTI   6'b 001010
`define SLTIU  6'b 001011
`define ORI    6'b 001101
`define LUI    6'b 001111
`define ANDI   6'b 001100
`define XORI   6'b 001110

`define BEQ    6'b 000100
`define BNE    6'b 000101
`define J      6'b 000010
`define JAL    6'b 000011


// Essas são todas as instruções tipo-R, i.e., OPCODE=0.  
// Campo FUNC definido aqui:

`define ADD    6'b 100000
`define ADDU   6'b 100001
`define SUB    6'b 100010
`define AND    6'b 100100
`define OR     6'b 100101
`define XOR    6'b 100110
`define NOR    6'b 100111
`define SLT    6'b 101010
`define SLTU   6'b 101011
`define SLL    6'b 000000
`define SLLV   6'b 000100
`define SRL    6'b 000010
`define SRLV   6'b 000110
`define SRA    6'b 000011
`define SRAV   6'b 000111
`define JR     6'b 001000
`define JALR   6'b 001001 

module controller(
   // NÃO MODIFICAR
   input  wire enable,
   input  wire [5:0] op, 
   input  wire [5:0] func,
   input  wire Z,
   output wire [1:0] pcsel,
   output wire [1:0] wasel, 
   output wire sext,
   output wire bsel,
   output wire [1:0] wdsel, 
   output logic [4:0] alufn, 	   // vai virar um wire
   output wire wr,
   output wire werf, 
   output wire [1:0] asel
   ); 

   // MODIFIQUE o código abaixo preenchendo as partes que faltam
   assign pcsel = ((op == 6'b0) & (func == `JR)) ? 2'b11   // controla o multiplexador de  4-entradas
               : ...
               : ...                                       // para beq/bne verifica a flag Z!
               : ...;

  logic [9:0] controls;                // vai virar um conjunt de wires
  wire  _werf_, _wr_;                  // precisa de uma AND com o enable para "congelar" o processador
  assign werf = _werf_ & enable;       // desativa as escritas no registrador quando o processador está desativado
  assign wr = _wr_ & enable;           // destiva a escrita na memória quando o processador está desativado 
 
  assign {_werf_, wdsel[1:0], wasel[1:0], asel[1:0], bsel, sext, _wr_} = controls[9:0];

   always @(*)
     case(op)                                       // instruções não-tipo-R 
        `LW: controls <= 10'b 1_10_01_00_1_1_0;     // LW
        `SW: controls <= ...                        // SW
      `ADDI,                                        // ADDI
     `ADDIU,                                        // ADDIU
      `SLTI: controls <= 10'b 1_01_01_00_1_1_0;     // SLTI
       `ORI: controls <= ...                        // ORI
       ... // adicione as instruções não-tipo-R restantes aqui
      `RTYPE:                                    
         case(func)                                 // Tipo-R
             `ADD,
            `ADDU: controls <= 10'b 1_01_00_00_0_x_0; // ADD e ADDU
             `SUB: controls <= 10'b 1_01_00_00_0_x_0; // SUB
             ... // adicione as instruções Tipo-R restantes aqui
            default:   controls <= 10'b 0_xx_xx_xx_x_x_0; // instrução desconhecida, desative a escrita no registrador e na memória
         endcase
      default: controls <= 10'b 0_xx_xx_xx_x_x_0;         // instrução desconhecida, desative a escrita no registrador e na memória
    endcase
    
   always @(*)
      case(op)                         // instruções que não são do tipo-R
         `LW,                          // LW
         `SW,                          // SW
         `ADDI,                        // ADDI
      `ADDIU: alufn <= 5'b 0xx01;      // ADDIU
         `SLTI: alufn <= 5'b 1x011;    // SLTI
         `BEQ,                         // BEQ
         `BNE: alufn <= ...            // BNE
         ... // adicione as demais instruções que não são do tipo-R aqui
         6'b000000:                      
            case(func)                 // tipo-R
               `ADD:
               `ADDU: alufn <= 5'b 0xx01; // ADD e ADDU
               `SUB: alufn <= 5'b 1xx01;  // SUB
               ... // adicione as demais instruções do tipo-R aqui
               default:   alufn <= 5'b xxxxx; // função desconhecida
            endcase
         default: alufn <= 5'b xxxxx;         // para todas as outras instruções, alufn é um don't-care.
      endcase
    
endmodule
