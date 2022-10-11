// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Autor  	: joaocarlos
// Arquivo	: fsm_template.sv
// Editor 	: Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Descrição:
//    Modelo de implementação de FSM em SystemVerilog
// -----------------------------------------------------------------------------
// Entradas: 
//    clk    : clock da FSM
//    rst  : sinal de reset da FSM
//    inputs : especifique os sinais de entrada
// -----------------------------------------------------------------------------
// Saidas:
//    outputs : especifique os sinais de saída
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps
`default_nettype none

module fsm_NAME (
   input  wire  clk,
   input  wire  rst,                   // Comente esta linha caso não tenha um entrada de rst
   input  wire  in1, in2, in3, ...     // Lista de entradas da FSM
   output logic out1, out2, out3, ...  // Lista de saídas da FSM
                                       // As saídas devem ser sintetizadas como lógica combinacional!
);


   // A próxima linha é o nossa codificação de estados
   // Aqui usamos o comando enum da SystemVerilog. 
   // Você enumera os estados e o compilador decide o padrão de codificação
   enum { STATE0, STATE1, STATE2, ... etc. } state, next_state;

   // -- OU --   
   // Você pode especificar a codificação de estados
   enum { STATE0=2'b00, STATE1=2'b01, STATE2=2'b10, ... etc. } state, next_state;



   // Instancia os elementos de armazenamento de estado (flip-flops)
   always @(posedge clk)
      if (rst == 1) state <= STATE_??;    // Remova o "if" se não tiver uma entrada rst
      else state <= next_state;

   // Defina a lógica de próximo estado => combinatória
   // Cada clausula deve ser uma expressão condicional
   // ou um "if" com um "else"
   always @(*)     
   case (state)
      STATE1: next_state <= ( {in1, in2, in3, ...} == ??) ? ... : ...;
      STATE2: next_state <= ...;
      STATE3: ...
      default: next_state <= ...;
   endcase



   // Defina a lógica de saída => combinatória
   // Cada clausula deve ser uma expressão condicional
   // ou um "if" com um "else"
   always @(*)     
   case (state)
      STATE1: {out1, out2, out3, ...} <= ...;
      STATE2: {out1, out2, out3, ...} <= ...;
      STATE3: ...
      default: {out1, out2, out3, ...} <= ...;
   endcase

endmodule