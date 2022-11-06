// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : datapath_test.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//      Teste de Auto-verificacao para o caminho de dados
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none

module datapath_tb;


   localparam Nreg = 32;                  // Quantidade de registradores
   localparam Dbits = 32;                 // Quantidade de bits de dado (regs, ALU)
                                          // $clog2(Nreg) = Quantidade de bits do registrador de endereços
   
   // Entradas
   logic clock;
   logic WR;
   logic [$clog2(Nreg)-1:0] RA1;
   logic [$clog2(Nreg)-1:0] RA2;
   logic [$clog2(Nreg)-1:0] WA;
   logic [4:0] ALUFN;
   logic [Dbits-1:0] WD;

   // Saídas
   wire [Dbits-1:0] RD1;
   wire [Dbits-1:0] RD2;
   wire [Dbits-1:0] ALUResult;
   wire FlagZ;

   // Instancia a Unit Under Test (UUT)
   datapath #(Nreg, Dbits) uut (
      .clock(clock), 
      .RegWrite(WR), 
      .ReadAddr1(RA1), 
      .ReadAddr2(RA2), 
      .WriteAddr(WA), 
      .ALUFN(ALUFN), 
      .WriteData(WD), 
      .ReadData1(RD1), 
      .ReadData2(RD2), 
      .ALUResult(ALUResult), 
      .FlagZ(FlagZ)
   );

   initial begin
      // Inicializa as entradas
      clock = 0;
      WR    = 0;
      RA1   = 0;
      RA2   = 0;
      WA    = 0;
      ALUFN = 0;
      WD    = 0;

      // Inclua os estímulos arqui
      // Entradas mudam a cada 1 ns, indo de 000 para 111
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
        
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd0,5'd0,5'd0,`ADD,32'd5};     // armazena 5 no registrador 0
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd0,5'd0,5'd1,`ADD,32'd1};     // armazena 1 no registrador 1
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd0,5'd1,5'd2,`ADD,32'd7};     // calcula 0+1=1, 7 no registrador 2
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd2,5'd1,5'd3,`ADD,32'd11};    // calcula 7+1=8, 11 no registrador 3
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd2,5'd3,5'd4,`ADD,32'd3};     // calcula 7+11=18, 3 no registrador 4
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd4,5'd3,5'd5,`SUB,32'd8};     // calcula 3-11=-8, 8 no registrador 5
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd5,5'd3,5'd6,`XOR,32'd40};     // calcula 8^11=3, 40 no registrador 6
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd4,5'd3,5'd7,`SLL,32'd4};      // calcula B<<A, 11<<3=88, 4 no registrador 7
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd4,5'd6,5'd8,`SRL,32'hFFFF_FF00};  // calcula 40>>3=5, -256 no registrador 8
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd4,5'd8,5'd9,`SRA,32'h0000_FFFF};  // calcula -256>>>3=-32, 0000FFFF no registrador 9
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd9,5'd8,5'd10,`AND,32'd10};    // calcula FFFFFF00 & 0000FFFF, 10 no registrador 10
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd8,5'd9,5'd11,`OR,32'd16};     // calcula FFFFFF00 | 0000FFFF, 16 no registrador 11
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd9,5'd8,5'd12,`NOR,32'hFFFF_FFF0}; // calcula ~(FFFFFF00 | 0000FFFF), -16 no registrador 12
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd10,5'd11,5'd13,`LT,32'd0};   // calcula 10 SLT 16?, 0 no registrador 13
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd11,5'd10,5'd14,`LT,32'd0};   // calcula 16 SLT 10?, 0 no registrador 14
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd10,5'd11,5'd15,`LTU,32'd0};  // calcula 10 SLTU 16?, 0 no registrador 15
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd10,5'd12,5'd16,`LT,32'd0};   // 10 SLT 32'hFFFFFFF0 (-16), 0  no registrador 16
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd10,5'd12,5'd17,`LTU,32'd0};  // 10 SLTU 32'hFFFFFFF0 (big +ve number), 0  no registrador 17
      
            
      // Espere por mais outro 1 ns, e então finalize a simulação.
      #1 $finish;
   end
   
   initial begin
      #0.5 clock = 0;
      forever
         #0.5 clock = ~clock;
   end
   

   // Código de auto-verificação
   
   selfcheckDatapath selfcheck();  // selfcheck (checker_RD1, checker_RD2, checker_ALUResult, checker_FlagZ);
      
   wire ERROR_RD1 = (RD1 != selfcheck.RD1) ? 1'bX : 1'b0;
   wire ERROR_RD2 = (RD2 != selfcheck.RD2) ? 1'bX : 1'b0;
   wire ERROR_ALUResult = (ALUResult != selfcheck.ALUResult) ? 1'bX : 1'b0;
   wire ERROR_FlagZ = (FlagZ != selfcheck.FlagZ) ? 1'bX : 1'b0;
   wire ERROR = ERROR_RD1 | ERROR_RD2 | ERROR_ALUResult | ERROR_FlagZ;


   //initial begin
   //   $monitor("#%5d {RD1, RD2, ALUResult, FlagZ} <= {32'h%h, 32'h%h, 32'h%h, 1'b%b};", $time, RD1, RD2, ALUResult, FlagZ);
   //end
   
endmodule


