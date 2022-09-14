# Lab 3: Projetando uma Unidade Lógica e Aritmética Simples

<p align="center">
Prof. João Carlos Bittencourt
</p>
<p align="center">
Centro de Ciências Exatas e Tecnológicas
</p>
<p align="center">
Universidade Federal do Recôncavo da Bahia, Cruz das Almas
</p>

## Introdução

Este roteiro consiste de várias etapas, cada uma construída a partir da anterior. Instruções detalhadas são fornecidas ao longo do texto.

> 💁 Códigos SystemVerilog foram fornecidos para praticamente todos os circuitos, mas algumas partes foram apagadas. Nesses casos, sua tarefa será completar e testar seu código cuidadosamente.

A partir dessa prática você vai aprender a:

- Projetar um sistema hierárquico com níveis de hierarquia muito mais profundos;
- Projetar circuitos lógicos e aritméticos;
- Usar constantes do tipo `parameter`;
- Simular circuitos Verilog, lidar com _test bench_ e estímulos de entrada;

## Modifique o Somador-Subtrator do Lab 2 para torná-lo parametrizável

Tendo em vista personalizar a quantidade de bits dos operandos do somador, apresento a seguir uma versão parametrizada do somador _ripple-carry_.

```verilog
`default_nettype none

module adder #(
   parameter N=32
)(
   input  wire [N-1:0 ] A, B,
   input  wire Cin,
   output wire [N-1:0] Sum,
   output wire FlagN, FlagC, FlagV
);

   wire [N:0] carry;

   assign carry[0] = Cin;

   assign FlagN = Sum[N-1];
   assign FlagC = carry[N];
   assign FlagV = carry[N] ^ carry[N-1];

   fulladder a[N-1:0] (A, B, carry[N-1:0], Sum, carry[N:1]);

endmodule
```

Neste caso, a palavra-chave `parameter` é usada para especificar a constante com valor padrão, que pode ser sobrescrito ao declarar uma instância do circuito em um módulo de nível superior na hierarquia.

Ao modificar o parâmetro `N`, a largura do somador pode ser facilmente alterada. O valor `32` é especificado como padrão de `N`, mas pode ser sobrescrito por um novo valor quando este módulo é instanciado.

Note ainda que foram adicionadas mais saídas com o intuito de produzir as _flags_ `Negative`, `Carry out` e `Overflow`. A unidade Somador-Subtrator foi também modificada, como apresentado a seguir.

> 💁 A flag `Negative` é ativa quando o resultado da operação é negativo (bit mais significativo, na representação sinal magnitude). A flag `Overflow` é acionada quando não é possível representar o resultado.

```verilog
`default_nettype none

module addsub #(
   parameter N = 32
)(
   input  wire [N-1:0] A, B,
   input  wire Subtract,
   output wire [N-1:0] Result,
   output wire FlagN, FlagC, FlagV
);

   wire [N-1:0] ToBornottoB = {N{Subtract}} ^ B;
   adder #(N) add (A, ToBornottoB, Subtract, Result, FlagN, FlagC, FlagV);

endmodule
```

Dessa vez o circuito Somador-Subtrator é parametrizado com a largura padrão de 32 bits. O parâmetro `N` é transferido para o módulo `adder` sempre que ele é instanciado. Deste modo, ao modificar o valor de `N` na linha acima do módulo `addsub`, digamos para 64, o novo valor do parâmetro é utilizado dentro do módulo somador, chamado `adder`.

O _test bench_ do Lab 2 foi modificado para testar ambos os módulos.

> 💁 No _test bench_, onde você declara a _unit under test_ (`uut`), é possível definir o valor do parâmetro como no exemplo abaixo:
>
> ```verilog
> addsub #(width) uut ( ... );
> ```

O _test bench_ fornecido no diretório `sim` (`addsub_tb`) utiliza uma palavra de 8-bits. Você deve tentar outras larguras (ex., 16 bits) também, simplesmente modificando o valor `localparam N` dentro do _test bench_.

Um `localparam` é outra forma de declarar constantes em Verilog. Todavia, ela é definida apenas como atributo **local** do módulo. Ou seja, essa constante não é visível ou modificável no módulo pai dentro da hierarquia. Observe no _test bench_ como o `localparam` é declarado e utilizado.

Você precisará definir a largura apenas **uma vez**, onde a `uut` é declarada. Isso sobrescreverá o valor padrão da largura a medida em que for transferida através da hierarquia.

A saída da sua simulação deve ser semelhante àquela apresentada a seguir (após definir a exibição para **Decimal**).

![Novo Somador-subtrator.](./img/addsub_sim.png)

## Entendendo a estrutura e operação de uma ULA

A seguir apresentamos um diagrama de bloco para a Unidade Lógica e Aritmética (ULA) que iremos projetar, juntamente com seu sinal de controle de 5 bits **ALUFN**.

![Esquemático de uma Unidade Lógica e Aritmética.](./img/alu.png)

> Na figura acima, `X` significa "don't care". Ou seja, esse bit não tem importância.
>
> - O sinal de 2 bits `Bool` é usado também para determinar o tipo de deslocamento.
> - No deslocamento, o valor de `A` determina a quantidade bits que deve ser deslocado de `A`.

Sua primeira tarefa é apenas revisar as informações sobre as estruturas acima e garantir que entendeu como os 5 bits de controle codificam as operações, além de como os multiplexadores selecionam o resultado na saída.

> ⚠️ Operações de comparação serão incorporadas na última parte desse roteiro.

## Módulos Lógicos e de Deslocamento

Utilize os trechos de código a seguir, para completar o circuito de uma unidade lógica e a unidade de deslocamento bi-direcional.

> 💁 Salve o módulo lógico em um arquivo chamado `logical.sv`, e o deslocador em um arquivo chamado `shifter.sv` dentro do diretório `src`.

Começaremos pelo módulo de operações lógicas. Verifique novamente como as operações foram codificadas e preencha as lacunas cuidadosamente.

```verilog
`default_nettype none

module logical #(
   parameter N=32
)(
   input  wire [N-1:0] A, B,
   input  wire [1:0]   op,
   output wire [N-1:0] R
);

   assign R = (op == 2'b00) ?      :
              (op ==      ) ?      :
              (op ==      ) ?      :
              (op ==      ) ?        :    ;

endmodule
```

Você deve utilizar os operadores _bitwise_ da SystemVerilog que correspondam às quatro operações lógicas listadas na tabela acima para os 5 bits de controle da ULA.

> 🙇‍♂️ **_Nota de depuração_**
>
> O último comando `else` no código acima não é realmente necessário. Você poderia modifica-lo para eliminar a última construção `if-else`, ou pode deixar como está e utilizá-la como elemento de depuração.
>
> De maneira geral, digamos que aconteceu um erro na codificação de uma instrução, e os dois bits de `op` recebidos foram `1x`. Esse valor não irá coincidir com nenhuma dos casos, e portanto irá cair na cláusula padrão final `else`.
>
> Atribuir um valor **padrão para todos** nesse tipo de situação pode ser útil no futuro. Em mais detalhes, digamos que seu valor padrão corresponde a todos os bits iguais a 1 (o que poderia ser escrito como `{N{1'b1}`), e então, quando você estiver testando seu circuito completo, nota que a ULA está produzindo um resultado inesperado igual a vários `1's`. Isso poderia lhe direcionar ao problema oriundo de um valor de `op` inválido na entrada do seu módulo.

Agora projete o circuito de deslocamento utilizando o esqueleto apresentado à seguir.

```verilog
`default_nettype none

module shifter #(
   parameter N=32
)(
   input  wire signed [N-1:0] IN,
   input  wire        [$clog2(N)-1:0] shamt, // arredondando para log2
   input  wire left, logical,
   output wire [N-1:0] OUT
);

   assign OUT = left ?  (IN << shamt) :
                        (logical ? IN >> shamt : IN >>> shamt);

endmodule
```

No código acima, observe que `IN` é do tipo `signed`, e que o tamanho do deslocamento pode variar de `0` até `N-1`. Portanto, a quantidade de bits em `shamt` foi arredondada usando a função:

$$
ceiling(log_2(N))
$$

Observe o papel dos sinais de controle `left` e `logical`. Se `left` for verdadeiro, o módulo realiza um deslocamento à esquerdado (que é sempre lógico). Caso contrário, o circuito realiza um deslocamento para a direita. Para essa operação, se `logical` é verdadeiro, um deslocamento lógico para a direita é realizado; caso contrário o circuito realiza um deslocamento aritmético para a direita.

Note ainda que o `shamt` só possui `$clog2(N)` bits (ex. 5 bits para operandos de 32 bits). A lista abaixo apresenta os operadores de deslocamento utilizados na ULA.

- `<<` é o operador de deslocamento lógico à esquerda (`sll`)
- `>>` é o operador de deslocamento lógico à direita (`srl`)
- `>>>` é o operador de deslocamento aritmético à direita (`sra`)

> ✅ O circuito acima está usando operadores Verilog para os os três tipo de operação de deslocamento. Observe que o tipo de dado de `IN` é declarado como `signed`. Por que?

<!-- Por padrão, os tipos de dado em SystemVerilog são `unsigned`. Entretanto, para que operações de deslocamento aritmético à direita funcionem corretamente, a entrada deve ser declarada como do tipo `signed`, de modo que o bit mais significativo seja utilizado para indicar seu sinal. -->

Agora você deve analisar a estrutura de cada um dos dois módulos descritos acima, através da visualização dos seus esquemáticos no RTL Viewer.

## Módulo da ULA (sem comparações)

Utilize o código abaixo para projetar uma ULA capaz de realizar operações de soma, subtração, deslocamento e lógicas.

```verilog
`default_nettype none

module alu #(
   parameter N=32
)(
   input  wire [N-1:0] A, B,
   output wire [N-1:0] R,
   input  wire [4:0]   ALUfn,
   output wire         FlagN, FlagC, FlagV, FlagZ
);

   wire subtract, bool1, bool0, shft, math;

   // Separando ALUfn em bits nomeados
   assign {subtract, bool1, bool0, shft, math} = ALUfn[4:0];

   // Resultados dos três componentes da ALU
   wire [N-1:0] addsubResult, shiftResult, logicalResult;

   addsub   #(N) AS (A, B,      ,         ,       ,      ,      );
   shifter  #(N) S (B, A[$clog2(N)-1:0],       ,       ,      );
   logical  #(N) L (A, B, {         },             );

   // Multiplexador de 4 entradas para selecionar a saída
   assign R =  (~shft & math)  ?              :
               (shft & ~math)  ?              :
               (~shft & ~math) ?              : 0;

   // Utilize o operador de redução aqui
   assign FlagZ =    ;

 endmodule
```

> 💁 **_Dica Importante_**
>
> Certifique-se de fornecer corretamente as entradas `left` e `logical` para o deslocador dentro do módulo da ULA. Observe primeiro quais valores entre `bool1` e `bool0` representam os deslocamentos `sll`, `srl` e `sra`. Agora determine como `left` e `logical` devem ser produzidos a partir de `bool1` e `bool0`.
>
> Isso pode ser um pouco complicado! Complete a tabela verdade a seguir, para determinar a relação que existe entre `{bool1, bool0}` e `{left,logical}`.

| Entradas |         | Saídas |           |
| :------: | :-----: | :----: | :-------: |
| `bool1`  | `bool2` | `left` | `logical` |
|    0     |    0    |        |           |
|    0     |    1    |        |           |
|    1     |    0    |        |           |
|    1     |    1    |        |           |

Escreva uma equação lógica para `left`, e uma para `logical`, em termos de `bool1` e `bool0`. Utilize as expressões para `left` e `logical` que você acabou de desenvolver para completar o módulo `alu`.

Use o _test bench_ fornecido (`alu_tb.sv`) para testar a ULA sem as operações de comparação. Lembre-se de selecionar **Decimal** como modo de representação (**Radix**), para exibir as entradas `A` e `B`, e a saída `R`. Selecione a representação binária para `ALUfn`.

## Modifique a ULA e Inclua Comparações

A seguir são apresentados dois diagramas de blocos para a nossa ULA: aquele que você implementou, e uma versão modificada que você irá desenvolver agora.

### ULA Sem Comparação

![ALU Sem Comparação](img/alu.png)

### ULA Com Comparação

![ALU com circuito de comparação.](img/alu_comp.png)

A figura acima inclui algumas funcionalidades adicionais. Especificamente, as operações comparação entre operandos `A` e `B`. Ambas as comparações,`signed` e `unsigned` são implementadas:

- _Less-then signed_ (LT); e
- _Less-than-unsigned_ (LTU).

> 💁 Perceba as diferenças entre as duas imagens (novas funcionalidades foram destacadas em **vermelho**). Revise essa nova informação com cuidado antes de continuar.

A comparação entre os dois operandos `A` e `B`, é realizada a partir da subtração (`A-B`), seguida da verificação das _flags_ (`N`, `V` e `C`) produzidas. Observe que, em ambos os casos, o bit `Sub` de `ALUfn` está ativo. O bit menos significativo de `Bool` determina quando a comparação é deve considerar o sinal (_signed_) ou não (_unsigned_). Quando comparando números sem sinal, o resultado para `A-B` é negativo se e somente se _o carry out mais significativo do somador-subtrator (ou seja, a `flag` `C`) for igual a `0`_.

Não pode haver _overflow_ quando dois números positivos são subtraídos, mas quando os números estão sendo comparados como _signed_ (na notação de complemento de 2), o resultado da operação `A-B` é negativo se:

1. tanto o resultado possui seu bit negativo (_flag_ `N` ativo) **e** não houve _overflow_ na operação; ou
2. o resultado é positivo e não houve _overflow_ (_flag_ `V` ativa).

Para implementar a nova ULA, primeiro crie um módulo chamado `comparator` em um arquivo SystemVerilog chamado `comparator.sv`. Aqui está o esqueleto do código:

```verilog
`default_nettype none

module comparator (
   input  wire FlagN, FlagV, FlagC, bool0,
   output wire comparison
);

   assign comparison =                 ;

endmodule
```

> 💁 Observe que o valor de `bool0` determina se deve ser realizada uma comparação com sinal ou sem sinal (veja a tabela ALUfn ao lado do diagrama). Assim, escolha a equação Booleana apropriada para relizar a comparação.

Em seguida, modifique o módulo `alu` para incluir uma instância do comparador que você acabou de projetar. Em seguida, modifique a linha da atribuição `assign R` para torná-la um multiplexador de 4 entradas, no lugar do multiplexador de 3 entradas.

> 🎯 O último `else` da ULA pode ser usado agora para lidar com o resultado do comparador!

Tenha em mente que o resultado do comparador é um único bit `0` ou `1`, mas o resultado da ULA é multi-bit. Para evitar alertas do compilador neste sentido, _dentro do módulo alu_ você deve completar o resultado de 1 bit do comparador com (`N-1`) zeros à esquerda. A expressão SystemVerilog que contempla tal operação é:

```verilog
{{(N-1){1'b0}}, compResult}
```

A expressão `{(N-1){1'b0}}` replica um bit zero `N-1` vezes e em seguida concatena o resultado de 1 bit do comparador a ele.

Finalmente, elimine as _flags_ `N`, `V` e `C` da saída da ULA. Essas _flags_ são usadas apenas para instruções de comparação, e, uma vez que o comparador foi incluído dentro da ULA, elas não são mais necessárias. A _flag_ `Z`, entretanto, ainda precisa ser uma saída.

> 💁 A flag `Z` será usada pela unidade de controle para implementar as funções `beq` e `bne` do nosso processador.

### Simulando a ALU com Comparação no ModelSim

Utilize o _test bench_ fornecido junto com os arquivos de laboratório para testar sua ULA (em ambas as versões de 8-bits e 32-bits).

Lembre-se de selecionar a representação **decimal** para exibir as entradas `A` e `B`, e a saída `R`. Selecione a representação **binária** para representar `ALUfn`.

Primeiro, você deve testar sua ULA com a largura definida como 8 bits (use o arquivo `alu_8bit_tb.sv`). Se tudo der certo, você deve visualizar uma forma de onda como essa:

![Simulação da ALU com 8 bits.](./img/alu_8bit_sim.png)

Em seguida, teste seu projeto utilizando a versão 32-bits do _test bench_ (`alu_32bit_tb.sv`). Se tudo ocorrer como esperado, novamente você deve visualizar uma forma de onda como a que segue.

![Simulação da ALU com 32 bits](./img/alu_32bit_sim.png)

Alguns resultados podem mudar, como por exemplo, a operação `100 + 30`, que provocava um _overflow,_ quando em 8 bits, graças à limitação na representação com sinal, não causará o mesmo efeito com 32 bits.

> 💁 Observe, cuidadosamente, todas as diferenças entre as saídas de 8 bits e de 32 bits e verifique se você é capaz de explicá-las.

### Visualização Esquemático da ALU

Encerre a simulação, e crie uma visualização do esquemático da sua ULA utilizando o RTL Viewer. Em seguida tente relacionar o esquemático produzido com a estrutura desses componentes.

> ✅ Você ainda vai aprender muito sobre como relacionar o esquemático do circuito com a descrição Verilog, e como identificar as correspondências entre os componentes do circuito e as linhas do código Verilog. Isso será importante para os futuros projetos!

## Acompanhamento (entrega: próximo laboratório)

### O que entregar

Para este laboratório, tenha os itens a seguir prontos para mostrar ao seu professor:

- As equações Booleanas para os sinais `left` e `logical`.
- Em um documento de texto, apresente sua resposta para a pergunta na seção [Módulos Lógicos e de Deslocamento](#módulos-lógicos-e-de-deslocamento).
- Seu código Verilog para os módulos: `alu`, `comparator`, `logical` e `shifter`.
- As formas de onda da simulação, mostrando claramente **os resultados da simulação final da ALU tanto para a versão 8-bits, quanto para a versão 32-bits**.
- O diagrama do circuito final (32-bits), utilizando a ferramenta **RTL Viewer**.

## Agradecimentos

Este laboratório é o resultado do trabalho de docentes e monitores de GCET231 ao longo dos anos, incluindo:

- **18.1:** Caio França dos Santos
- **18.2:** Matheus Rosa Pithon
- **20.2:** Matheus Rosa Pithon
- **21.1:** Matheus Rosa Pithon, Éverton Gomes dos Santos
- **21.2:** Éverton Gomes dos Santos
