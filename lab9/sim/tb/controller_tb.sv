// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : controller_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Description:
//  Testbench para a unidade de controle do RISC231-M1
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

// Esses são os Opcodes que não são do tipo-R.  

`define LW     6'b 100011
`define SW     6'b 101011

`define ADDI   6'b 001000
`define ADDIU  6'b 001001			// NOTA:  addiu *realiza* extensão do sinal de imm
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


// Esses são todas as instruções do tipo-R, 
// ou seja, OPCODE=0. O campo FUNC é definido aqui:

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

module controller_tb;

   logic enable = 1'b1;
   logic [5:0] op;
   logic [5:0] func;
   logic Z;
   
   wire [1:0] pcsel;
   wire [1:0] wasel; 
   wire sext;
   wire bsel;
   wire [1:0] wdsel; 
   wire [4:0] alufn;
   wire wr;
   wire werf; 
   wire [1:0] asel;

   // Instancia a Unit Under Test (UUT)
   controller uut (.*);                      // O ".*" conecta todos os sinais por seu nome

   initial begin
      enable = 1'b1;

      // Adicione novos estímulos aqui, se necessário
      // Entradas mudam a cada 1 ns
      
      #1 {op, func, Z} = {`LW,    6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`SW,    6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`ADDI,  6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`ADDIU, 6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`SLTI,  6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`SLTIU, 6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`ORI,   6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`LUI,   6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`ANDI,  6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`XORI,  6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`BEQ,   6'b xxxxxx, 1'b 0};
      #1 {op, func, Z} = {`BEQ,   6'b xxxxxx, 1'b 1};
      #1 {op, func, Z} = {`BNE,   6'b xxxxxx, 1'b 0};
      #1 {op, func, Z} = {`BNE,   6'b xxxxxx, 1'b 1};
      #1 {op, func, Z} = {`J,     6'b xxxxxx, 1'b x};
      #1 {op, func, Z} = {`JAL,   6'b xxxxxx, 1'b x};
      
      #1 {op, func, Z} = {6'b 000000, `ADD,   1'b x};
      #1 {op, func, Z} = {6'b 000000, `ADDU,  1'b x};
      #1 {op, func, Z} = {6'b 000000, `SUB,   1'b x};
      #1 {op, func, Z} = {6'b 000000, `AND,   1'b x};
      #1 {op, func, Z} = {6'b 000000, `OR,    1'b x};
      #1 {op, func, Z} = {6'b 000000, `XOR,   1'b x};
      #1 {op, func, Z} = {6'b 000000, `NOR,   1'b x};
      #1 {op, func, Z} = {6'b 000000, `SLT,   1'b x};
      #1 {op, func, Z} = {6'b 000000, `SLTU,  1'b x};
      #1 {op, func, Z} = {6'b 000000, `SLL,   1'b x};
      #1 {op, func, Z} = {6'b 000000, `SLLV,  1'b x};
      #1 {op, func, Z} = {6'b 000000, `SRL,   1'b x};
      #1 {op, func, Z} = {6'b 000000, `SRLV,  1'b x};
      #1 {op, func, Z} = {6'b 000000, `SRA,   1'b x};
      #1 {op, func, Z} = {6'b 000000, `SRAV,  1'b x};
      #1 {op, func, Z} = {6'b 000000, `JR,    1'b x};
      #1 {op, func, Z} = {6'b 000000, `JALR,    1'b x};

      #1 {op, func, Z} = {6'b 000000, `ADD,   1'b x};	// werf deve ser 1
      #1 enable = 1'b0;					                  // desativa o processador
      #1 {op, func, Z} = {6'b 000000, `ADD,   1'b x};	// werf deve ser 0
      #1 enable = 1'b1;					                  // re-ativa o processador
      #1 {op, func, Z} = {`SW,    6'b xxxxxx, 1'b x};	// wr deve ser 1
      #1 enable = 1'b0;					                  // destativa o processador
      #1 {op, func, Z} = {`SW,    6'b xxxxxx, 1'b x};	// wr deve ser 0


      // Espere por outros 2 ns, e então encerre a simulação
      #2 $finish;
   end




   // Código de auto-verificação
   
   selfcheckController selfcheck ();  // c(checker_RD1, checker_RD2, checker_ALUResult, checker_FlagZ);
   
   function mismatch;   // necessário para comparar dois valores com don't cares
       input p, q;      // diferença em uma posição de bit é ignorada de q tem um 'x' naquele bit
       integer p, q;
       mismatch = (((p ^ q) ^ q) !== q);
   endfunction
   
   wire ERROR;
   
   wire ERROR_pcsel = mismatch(pcsel,  selfcheck.pcsel)  ? 1'bX : 1'b0;
   wire ERROR_wasel = mismatch(wasel,  selfcheck.wasel)  ? 1'bX : 1'b0;
   wire ERROR_sext  = mismatch(sext,   selfcheck.sext)   ? 1'bX : 1'b0;
   wire ERROR_bsel  = mismatch(bsel,   selfcheck.bsel)   ? 1'bX : 1'b0;
   wire ERROR_wdsel = mismatch(wdsel,  selfcheck.wdsel)  ? 1'bX : 1'b0;
   wire ERROR_alufn = mismatch(alufn,  selfcheck.alufn)  ? 1'bX : 1'b0;
   wire ERROR_wr    = mismatch(wr,     selfcheck.wr)     ? 1'bX : 1'b0;
   wire ERROR_werf  = mismatch(werf,   selfcheck.werf)   ? 1'bX : 1'b0;
   wire ERROR_asel  = mismatch(asel,   selfcheck.asel)   ? 1'bX : 1'b0;
   
   assign ERROR = ERROR_pcsel | ERROR_wasel | ERROR_sext | ERROR_bsel | ERROR_wdsel | ERROR_alufn | ERROR_wr | ERROR_werf | ERROR_asel;
   

   initial begin
      $monitor("     #%02d {pcsel, wasel, sext, bsel, wdsel, alufn, wr, werf, asel} <= {17'b%b};", $time, {pcsel, wasel, sext, bsel, wdsel, alufn, wr, werf, asel});
   end
   
endmodule
