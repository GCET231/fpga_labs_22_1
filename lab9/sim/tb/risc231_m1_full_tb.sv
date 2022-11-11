// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Carlos Bittencourt
// File   : risc231_m1_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Description:
//
// Este é um teste auto-verificável para o seu processador RISC231-M1 
// Use o programa de teste para um teste completo, ou seja, inicialize
// a memória de instruções com full_imem.mem, e a memória de dados com
// full_dmem.mem.
//
// Use esse teste com cuidado! Os nomes das suas entradas/saídas e sinais
// internos podem ser diferentes. Portanto, modifique todos os nomes de sinais
// no lado direito das atribuições de "wire" que aparecem acima da instancia
// da uut. Observe que a uut apenas possui os sinais de clock e reset agora,
// e nenhuma saída de depuração. No lugar delas, os sinais internas são
// "postos para fora" usando o operador seletor de membro, ou ponto (".").
//
// Se você escolher não usar alguns destes sinais internos para depuração, 
// você pode comentar as linhas relevantes. Certifique-se de comentar a linha
// de "ERROR_*" correspondente, a qual aparece logo abaixo.
//
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps

module risc231_m1_full_tb;

   // Inputs
   logic clk;
   logic reset;
   logic enable = 1'b1;

   // Sinais conectados a memoria de instruções
   wire [31:0] pc             = uut.pc;                     // PC
   wire [31:0] instr          = uut.instr;                  // instr vinda da memória de instr

   // Sinais conectados à memódia de dados (módulo uut.dmem)
   wire [31:0] mem_addr       = uut.mem_addr;                     // endereço enviado para a memória de dados
   wire wr                    = uut.risc231_m1.c.wr;              // write enable produzido pelo controlador
   wire        mem_wr         = uut.dmem.wr;                      // write enable para a memória de dados
   wire [31:0] mem_readdata   = uut.mem_readdata;                 // dado lido da memória de dados
   wire [31:0] mem_writedata  = uut.dmem.din;                     // dado enviado para escrita na memória de dados

   // Entrada/saída de controle da ALU (módulo uut.risc231_m1.dp.alu) 
   wire  [4:0] alufn          = uut.risc231_m1.dp.alu.ALUfn;      // função da ALU
   wire        Z              = uut.risc231_m1.Z;                 // flag Zero
   
   // Dadis dentro do caminho de dado (módulo uut.risc231_m1.dp)
   wire [31:0] ReadData1      = uut.risc231_m1.dp.ReadData1;       // Reg[rs]
   wire [31:0] ReadData2      = uut.risc231_m1.dp.ReadData2;       // Reg[rt]
   wire [31:0] alu_result     = uut.risc231_m1.dp.alu_result;      // saída da ALU   
   wire [31:0] signImm        = uut.risc231_m1.dp.signImm;         // imediado sign-/zero-extended
   wire [31:0] aluA           = uut.risc231_m1.dp.aluA;            // operando A da ALU
   wire [31:0] aluB           = uut.risc231_m1.dp.aluB;            // operando B da ALU

   // Atualiações no banco de registradores (módulo uut.risc231_m1.dp.rf)
   wire        werf           = uut.risc231_m1.dp.rf.wr;             // WERF = write enable para o register file
   wire [4:0]  reg_writeaddr  = uut.risc231_m1.dp.rf.WriteAddr;      // registrador de destino
   wire [31:0] reg_writedata  = uut.risc231_m1.dp.rf.WriteData;      // dado a ser escrito no register file
   
   // Sinais de controle dentro do caminho de dados (módulo uut.risc231_m1.dp)
   wire [1:0] pcsel           = uut.risc231_m1.dp.pcsel;
   wire [1:0] wasel           = uut.risc231_m1.dp.wasel;
   wire sext                  = uut.risc231_m1.dp.sext;
   wire bsel                  = uut.risc231_m1.dp.bsel;
   wire [1:0] wdsel           = uut.risc231_m1.dp.wdsel;   
   wire [1:0] asel            = uut.risc231_m1.dp.asel;


   // Instancia a Unit Under Test (UUT)
   top #(
      .WordSize(32),                         // tamanho da palavra do processador
      .Nreg(32),                             // quantidade de registradores
      .imem_size(128),                       // tamanho da imem, deve ser >= # de instruções no programa
      .imem_init("../tests/full_imem.mem"),  // nome do arquivo com o programa a ser carregado na memória de instruções
      .dmem_size(64),                        // tamanho da dmem, deve ser >= # de palavras em dados do programa + tamanho da pilha
      .dmem_init("../tests/full_dmem.mem")   // nome do arquivo com o conteúdo inicial da memória de dados
   ) uut (
      .clk(clk), 
      .reset(reset),
      .enable(enable)
   );

   initial begin
      // Inicializa as entradas
      clk   = 1'b0;
      reset = 1'b0;
      enable = 1'b1;
      #70.5 enable = 1'b0;
      #5  enable = 1'b1;
   end

   initial begin
      #0.5 clk = 0;
      forever
         #0.5 clk = ~clk;
   end

   initial begin
      #90 $finish;
   end

   // Código de auto-verificação

   selfcheckFull selfcheck();

   wire [31:0] c_pc=selfcheck.pc;
   wire [31:0] c_instr=selfcheck.instr;
   wire [31:0] c_mem_addr=selfcheck.mem_addr;
   wire        c_mem_wr=selfcheck.mem_wr;
   wire [31:0] c_mem_readdata=selfcheck.mem_readdata;
   wire [31:0] c_mem_writedata=selfcheck.mem_writedata;
   wire        c_werf=selfcheck.werf;
   wire  [4:0] c_alufn=selfcheck.alufn;
   wire        c_Z=selfcheck.Z;
   wire [31:0] c_ReadData1=selfcheck.ReadData1;
   wire [31:0] c_ReadData2=selfcheck.ReadData2;
   wire [31:0] c_alu_result=selfcheck.alu_result;
   wire [4:0]  c_reg_writeaddr=selfcheck.reg_writeaddr;
   wire [31:0] c_reg_writedata=selfcheck.reg_writedata;
   wire [31:0] c_signImm=selfcheck.signImm;
   wire [31:0] c_aluA=selfcheck.aluA;
   wire [31:0] c_aluB=selfcheck.aluB;
   wire [1:0]  c_pcsel=selfcheck.pcsel;
   wire [1:0]  c_wasel=selfcheck.wasel;
   wire        c_sgnext=selfcheck.sgnext;
   wire        c_bsel=selfcheck.bsel;
   wire [1:0]  c_wdsel=selfcheck.wdsel;
   wire        c_wr=selfcheck.wr;
   wire [1:0]  c_asel=selfcheck.asel;

   function mismatch;  // ajuste necessário para comparar dois valores com don't cares
      input p, q;      // diferença em uma posição de bit é ignorada de q tem um 'x' naquele bit
      integer p, q;
      mismatch = (((p ^ q) ^ q) !== q);
   endfunction

   wire ERROR;

   wire ERROR_pc             = mismatch(pc, selfcheck.pc) ? 1'bx : 1'b0;
   wire ERROR_instr          = mismatch(instr, selfcheck.instr) ? 1'bx : 1'b0;
   wire ERROR_mem_addr       = mismatch(mem_addr, selfcheck.mem_addr) ? 1'bx : 1'b0;
   wire ERROR_mem_wr         = mismatch(mem_wr, selfcheck.mem_wr) ? 1'bx : 1'b0;
   wire ERROR_mem_readdata   = mismatch(mem_readdata, selfcheck.mem_readdata) ? 1'bx : 1'b0;
   wire ERROR_mem_writedata  = selfcheck.mem_wr & (mismatch(mem_writedata, selfcheck.mem_writedata) ? 1'bx : 1'b0);
   wire ERROR_werf           = mismatch(werf, selfcheck.werf) ? 1'bx : 1'b0;
   wire ERROR_alufn          = mismatch(alufn, selfcheck.alufn) ? 1'bx : 1'b0;
   wire ERROR_Z              = mismatch(Z, selfcheck.Z) ? 1'bx : 1'b0;
   wire ERROR_ReadData1      = mismatch(ReadData1, selfcheck.ReadData1) ? 1'bx : 1'b0;
   wire ERROR_ReadData2      = mismatch(ReadData2, selfcheck.ReadData2) ? 1'bx : 1'b0;
   wire ERROR_alu_result     = mismatch(alu_result, selfcheck.alu_result) ? 1'bx : 1'b0;
   wire ERROR_reg_writeaddr  = selfcheck.werf & (mismatch(reg_writeaddr, selfcheck.reg_writeaddr) ? 1'bx : 1'b0);
   wire ERROR_reg_writedata  = selfcheck.werf & (mismatch(reg_writedata, selfcheck.reg_writedata) ? 1'bx : 1'b0);
   wire ERROR_signImm        = mismatch(signImm, selfcheck.signImm) ? 1'bx : 1'b0;
   wire ERROR_aluA           = mismatch(aluA, selfcheck.aluA) ? 1'bx : 1'b0;
   wire ERROR_aluB           = mismatch(aluB, selfcheck.aluB) ? 1'bx : 1'b0;
   wire ERROR_pcsel          = mismatch(pcsel, selfcheck.pcsel) ? 1'bx : 1'b0;
   wire ERROR_wasel          = selfcheck.werf & (mismatch(wasel, selfcheck.wasel) ? 1'bx : 1'b0);
   wire ERROR_sgnext         = mismatch(sgnext, selfcheck.sgnext) ? 1'bx : 1'b0;
   wire ERROR_bsel           = mismatch(bsel, selfcheck.bsel) ? 1'bx : 1'b0;
   wire ERROR_wdsel          = mismatch(wdsel, selfcheck.wdsel) ? 1'bx : 1'b0;
   wire ERROR_wr             = mismatch(wr, selfcheck.wr) ? 1'bx : 1'b0;
   wire ERROR_asel           = mismatch(asel, selfcheck.asel) ? 1'bx : 1'b0;

   assign ERROR = ERROR_pc | ERROR_instr | ERROR_mem_addr | ERROR_mem_wr | ERROR_mem_readdata 
              | ERROR_mem_writedata | ERROR_werf | ERROR_alufn | ERROR_Z
              | ERROR_ReadData1 | ERROR_ReadData2 | ERROR_alu_result | ERROR_reg_writeaddr
              | ERROR_reg_writedata | ERROR_signImm | ERROR_aluA | ERROR_aluB
              | ERROR_pcsel | ERROR_wasel | ERROR_sgnext | ERROR_bsel | ERROR_wdsel | ERROR_wr | ERROR_asel;

   initial begin
      $monitor("#%02d {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sgnext, bsel, wdsel, wr, asel} <= {32'h%h, 32'h%h, 32'h%h, 1'b%b, 32'h%h, 32'h%h, 1'b%b, 5'b%b, 1'b%b, 32'h%h, 32'h%h, 32'h%h, 5'h%h, 32'h%h, 32'h%h, 32'h%h, 32'h%h, 2'b%b, 2'b%b, 1'b%b, 1'b%b, 2'b%b, 1'b%b, 2'b%b};",
         $time, pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sgnext, bsel, wdsel, wr, asel);
   end
   
endmodule
