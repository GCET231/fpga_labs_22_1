# Lab 1: Primeiros Passos - Contas, Quartus Prime e Verilog Básico

<p align="center">
Prof. João Bittencourt
</p>
<p align="center">
Centro de Ciências Exatas e Tecnológicas
</p>
<p align="center">
Universidade Federal do Recôncavo da Bahia, Cruz das Almas
</p>

## Configurando suas Contas

### Onde obter informações

- Na [página do curso](https://gctec231.github.io) você encontrará os materiais de aula, links para os laboratórios, atividades, e vídeos.
- Utilizaremos o [Gradescope](https://www.gradescope.com/courses/374894) para submeter as listas de exercício.
  - Você deve ter recebido um convite por e-mail para ingressar no Gradescope. Se não recebeu, procure seu professor.
- Nosso grupo no [Telegram](https://t.me/+31MEWLPbBY4wNTcx) será utilizado para anúncios e discussão sobre assuntos tratados em sala, trabalhos e práticas de laboratório.

### Criando uma Conta no GitHub

Se você nunca utilizou antes, crie uma [conta no Github](https://github.com/signup) utilizando o seu endereço de e-mail `aluno.ufrb.edu.br`.

Se você já possui uma conta no GitHub registrada com seu e-mail pessoal, não crie uma nova conta. Ao invés disso, entre na sua conta do Github, usando [este link](https://github.com/settings/emails), e adicione o seu endereço de e-mail `aluno.ufrb.edu.br` à sua conta no Github.

### Chaves SSH

O GitHub autentica você para acessar os seus repositórios remotos localmente utilizando chaves SSH.

Certifique-se de ter o OpenSSH instalado em seu computador digitando o comando `ssh` no seu terminal Linux ou PowerShell. Em seguida, execute siga as instruções a seguir:

- Criando uma nova Chave SSH:

```shell
ssh-keygen -t rsa -b 4096 -C "seu_email@ufrb.edu.br"`
```

Pressione enter e use as configurações padrão. Não é necessário introduzir uma senha.

- Copie sua chave pública:

```shell
cat ~/.ssh/id_rsa.pub
```

Se estiver no Windows, você pode utilizar o comando abaixo (substitua `WINUSER` pelo seu diretório pessoal):

```shell
notepad C:\Users\WINUSER\.ssh\id_rsa.pub
```

- Adicione sua chave pública ao GitHub.

Acesse [este endereço](https://github.com/settings/keys), clique no botão **New SSH Key**, cole sua chave pública na caixa de texto e clique em **Add SSH key**.

- Finalmente, teste sua conexão SSH:

```shell
ssh -T git@github.com
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

> 💁 Se enfrentar algum problema durante o processo, pergunte ao seu professor ou ao monitor.

### Funcionamento básico do Git

> 💁 Sinta-se à vontade para pular esta seção se você já tiver alguma experiência anterior com o uso do git.

Sistemas de controle de versão ajudam na busca por modificações nos códigos-fonte ao longo do tempo e facilitam o compartilhamento de mudanças provenientes dos seus colaboradores. Para projetos classificados em qualquer nível de complexidade, ter algum mecanismo de controle de versão é fundamental.

> 🏫 No nosso curso, usaremos o Git, um dos sistemas de controle de versão mais populares.

Dedique um tempo para entender como o Git funciona, pois isso tornará a compreensão de como realmente utilizá-lo muito mais fácil. Acesse [este link](http://git-scm.com/book/en/Getting-Started-Git-Basics), para ter uma boa visão geral sobre o Git.

Assim que você achar que entendeu o material acima, conclua [este tutorial](http://try.github.com).

O Git é uma ferramenta muito poderosa, mas que pode ser um pouco complicada no começo. Se você não sabe o que está fazendo, pode acabar provocando muitas dores de cabeça tanto para você mesmo como para aqueles à que trabalham com você. Então seja cuidadoso!

> ⚠️ Se estiver em dúvida sobre como fazer algo com Git, pergunte ao seu professor ou a algum colega mais experiente.

Para o propósito das nossas atividades, você provavelmente precisará dominar os comandos a seguir:

- `git status`
- `git add`
- `git commit`
- `git pull`
- `git push`
- `git clone`

Entretanto, se você deseja realmente entender como usar alguns recursos mais poderosos (`diff`, `blame`, `branch`, `log`, `mergetool`, `rebase`, e muitos outros), saiba que eles podem aumentar muito a sua sua produtividade.

> 💁 Se você deseja explorar mais alguns comandos avançados, confira [um tutorial um pouco mais avançado](https://github.com/GCET231/tutorial1-github/tree/main/Git_to_Manage_RTL).

## Obtendo os Arquivos de Laboratório

Os arquivos de laboratório estão em um repositório Git no [GitHub](https://github.com/GCET231/fpga_labs_22_1). Antes de começar, crie uma pasta no seu computador onde você irá salvar todo material do curso.

> 👉 Certifique-se de que não há espaços nos nomes dos diretório do caminho para os arquivos!

No Terminal, execute o comando dentro do diretório que você escolheu:

```shell
git clone git@github.com:GCET231/fpga_labs_22_1.git
```

Sempre que um novo laboratório for lançado, você só precisará executar o comando `git pull` para obter os novos arquivos. Se houver alguma atualização no repositório, o `git pull` irá buscar todas as mudanças e junta-las com o que você já tem.

> 🔐 Você pode criar seu próprio repositório para armazenar os códigos do laboratório, mas certifique-se de que ele seja **privado**. Com sua conta institucional é possível solicitar acesso ao [GitHub Student Development Pack](https://education.github.com/pack)

No final do semestre, cada equipe terá seu próprio repositório privado dedicado ao projeto final, e você será capaz de realizar operações de `push` e `pull` a partir dele.

## Instalação do Intel Quartus Prime Lite Edition

> Se você já realizou o Tutorial de [Instalação do Intel Quartus Prime](https://github.com/GCET231/tut2-instalando-quartus-modelsim) pode pular para a próxima etapa.

Baixe o instalador para Windows ou Linux [diretamente do site da Intel](https://www.intel.com/content/www/us/en/collections/products/fpga/software/downloads.html?s=Newest&f:guidetmD240C377263B4C70A4EA0E452D0182CA=%5BIntel®%20Quartus®%20Prime%20Design%20Software%3BIntel®%20Quartus®%20Prime%20Lite%20Edition%3B20.1.1%5D) para o Quartus Prime Lite Edition. Você precisará criar um conta Intel (gratuita). Na aba **Combined Files** faça o download do arquivo de instalação.

> 💁‍♂️ No nosso laboratório, utilizaremos a versão 20.1.1 do Quartus Prime.

No Windows, apenas instale o Quartus Prime como outro programa qualquer. No Linux, descompacte o arquivo baixado, em seguida configure o executável dentro do diretório de descompactação `chmod +x setup.sh` e execute o script `./setup.sh`.

Durante a instalação, selecione apenas "Quartus Prime Lite Edition (free)" e "ModelSim - Intel FPGA Starter Edition (free)". Na escolha das bibliotecas, selecione a caixa para selecionar apenas os dispositivos "Cyclone IV".

> 💾 Ao todo, essa instalação irá demandar cerca de 14 GB após ser completada.

O _Quartus Prime Lite Edition_ vem com uma licença gratuita adequado para as nossas intenções. Ao abrir o Quartus Prime, você deverá visualizar uma janela de diálogo que possibilita adquirir uma licença. Na janela de diálogo Selecione **Run the Quartus Prime software** e clique em _OK_.

## Seu Primeiro projeto no Quartus Prime

Nesse laboratório, você vai projetar um circuito combinacional de três entradas e uma saída. O circuito representa um **Somador Completo** de um bit, com entradas `A`, `B` e `Carry_in`, e saída `Sum`. Observe que um somador completo, geralmente, possui ainda uma segunda saída, chamada `Carry_out`. Por enquanto, você vai ignorar este sinal, mas irá adiciona-lo mais adiante.

Nesta primeira parte do procedimento você deverá:

- Criar um novo projeto no Quartus Prime;
- Adicionar um arquivo SystemVerilog que descreve o circuito;
- Adicionar um arquivo SystemVerilog que alimenta as entradas do circuito; e
- Observar as saídas verificando se elas estão corretas.

### Criando o Projeto

Em cada roteiro, você receberá um conjunto de arquivo contendo a seguinte estrutura de diretórios:

- `fpga`: diretório onde será criado o projeto do Quartus Prime.
- `sim`: diretório onde serão armazenados os arquivos de simulação.
- `src`: diretório onde serão armazenados os arquivos fonte SystemVerilog.

Abra o Quartus Prime, e crie um novo projeto usando o **New Project Wizard**.

Na primeira caixa de diálogo, escolha o caminho para o diretório do projeto:

`caminho/para/a/pasta/gcet231/fpga_labs_21_2/lab1/fpga`

Na segunda caixa de diálogo, digite o nome do projeto. Chamaremos esse projeto de `lab1`. A terceira caixa de diálogo indica qual será o circuito a ser analisado. Deixe como está por enquanto e clique em **Next**.

Na janela de diálogo **Project Type** escolha **Empty project** e então clique em **Next**.

Na janela de diálogo **Add Files**, clique em **Next**.

Na janela **Family, Device & Board Settings** escolha a família **Cyclone IV E** e o dispositivo `EP4CE115F29C7`.

Por último, clique no botão **Finish** para encerrar o assistente e criar o novo projeto.

### Adicionando um Novo Arquivo SystemVerilog

Ao longo deste semestre, você vai desenvolver projetos usando a linguagem Verilog/SystemVerilog, uma linguagem de descrição de hardware (HDL - _Hardware Description Language_) largamente utilizada na indústria.

Na barra de tarefas do Quartus Prime, clique em no botão **New**, escolha a opção SystemVerilog HDL File e clique em **OK**. Salve o arquivo e chame-o de `halfadder.sv`.

Na janela de tarefas **Project Navigator**, selecione a aba **File**. Clique com o botão direito sobre o arquivo `halfadder.sv` e marque **Set as Top-Level Entity**.

Agora, vamos escrever nosso primeiro arquivo SystemVerilog. Para isso, preencha o arquivo `halfadder.sv` com o código apresentado a seguir:

```verilog
module halfadder (
   input  wire A,
   input  wire B,
   input  wire Cin,
   output wire Sum
);

   assign Sum = Cin ^ A ^ B;

endmodule
```

Observe que o símbolo `^` corresponde à operação ou-exclusivo (XOR). O fragmento de código acima corresponde à equação Booleana extraída da tabela verdade de um circuito somador completo.

### Simulação Simples

Para simular seu circuito, você precisará especificar um conjunto de valores de entradas (que mudarão ao longo do tempo). Para isso, clique com o botão direito na janela **Project Navigator** e selecione **Add/Remove Files in Project...**

Na janela de diálogo **Add Files**, clique no botão indicado por `...` para selecionar os arquivos do projeto. Navegue até o diretório `sim`, selecione o arquivo `halfadder_test.sv` e clique em **OK**.

O papel do testador é fornecer entradas e receber saídas do módulo meio somador. Para isso, o testador envolve o meio somador, de modo que ele não possua nenhuma entrada ou saída:

![Testbench Verilog](img/verilog_tb.png)

Antes de darmos início aos testes, entretanto, iremos configurar o ModelSim para ser executado a partir do Quartus Prime. Nos próximo tutoriais, aprenderemos como utilizar as ferramentas separadamente.

> 💁 Essa abordagem de simulação é útil para projetos pequenos, mas você verá que ela é limitada quando você precisa de mais flexibilidade.

Na janela principal do Quartus Prime, acesse o menu **Tools** `>` **Options** `>` **EDA Tool Options** para especificar a localização do simulador. Em **ModelSim-Intel**, introduza o caminho onde se encontra o executável do **ModelSim - Intel Starter Edition** no seu computador.

- No Linux: `/caminho-de-instalacao/21.1/modelsim_ase/linuxaloem`
- No Windows: `C:\Caminho-de-Instalacao/21.1/modelsim_ase/win32aloem`

Clique em **Assignments** `>` **Settings** `>` **EDA Tool Settings** `>` **Simulation** e especifique os valores especificados a seguir:

![EDA Settings](img/eda_settings.png)

Em **NativeLink settings**, selecione a opção **Compile test bench**, e então clique no botão **TestBenches**. Clique em **New**. Especifique o **Testbench name** e o **Top level module in test bench** como `halfadder_test`. Em **Testbench and simulation files**, selecione o arquivo `halfadder_test.sv`, clique em **Add**, e então clique em **OK**.

Antes de executarmos uma simulação, é preciso compilar seu projeto. Para compilar, clique em **Processing** `>` **Start** `>` **Start Analysis and Elaboration**. Agora clique em **Tools** `>` **Run Simulation Tool** `>` **RTL Simulation** para executar o simulador.

O ModelSim será aberto logo em seguida e uma janela de saída será produzida exibindo os resultados do seu teste. Para visualizar a toda forma de onda da simulação, clique na aba **Wave**, em seguida clique em **Wave** `>` **Zoom** `>` **Zoom Full**.

> 💁 Você verá a forma de onda resultante de todas as entradas, e também os sinais de saída!

Finalmente, vamos analisar a implementação do circuito que nós acabamos de descrever. Feche a janela do ModelSim e volte para o Quartus Prime. Clique em **Tools** `>` **Netlist Viewers** `>` **RTL Viewer**.

Você deverá visualizar o seguinte esquemático:

![Esquemático do Somador Completo](img/fa_schm.png)

Se suas formas de onda e diagrama esquemático coincidem com os apresentados aqui, então você completou a primeira parte do roteiro!

## Somador Completo

Nessa etapa, modifique seu trabalho da **Parte 1** para incluir a segunda saída ao seu circuito: `Carry_out`. Para isso, será preciso fazer duas pequenas mudanças no arquivos da Parte 1:

1. Adicionar a outra saída (`Carry_out`) à interface do módulo;
2. Adicionar outra atribuição (usando o comando `assign`) para especificar a equação lógica correspondente ao cálculo do `Carry_out` em um somador completo.

Note que o símbolo para uma operação AND é `&`, e para a operação OR é `|`. Para ver a lista completa dos operadores em SystemVerilog, acesse [este link](https://verilogguide.readthedocs.io/en/latest/verilog/datatype.html?highlight=operators#operators).

> ⚠️ Certifique-se de usar parênteses `(...)` se você não tiver certeza da precedência entre os operadores `&`, `|` e `ˆ`.

Crie um novo arquivo e chame-o de `fulladder.sv`. Copie e cole o conteúdo do módulo `halfadder` dentro dele, e então modifique o código realizando as duas modificações apresentadas acima. Elas são apresentadas com comentários no código abaixo (preencha os espaços vazios).

```verilog
module fulladder (
   input  wire A,
   input  wire B,
   input  wire Cin,
   output wire Sum,
   output wire /* Complete aqui */
);

 assign Sum = Cin ^ A ^ B;
 assign /* Complete aqui */ = /* Complete aqui */

endmodule
```

Depois de completar o código, você irá simular o novo módulo `fulladder`, repetindo todas as etapas da simulação, apresentadas na Parte 1. Lembre-se de primeiro adicionar o arquivo `fulladder_tb.sv` ao seu projeto.

Nas configurações de simulação crie um novo Testbench em **Native link settings**. Chame-o de `fulladder_tb` e inclua o novo arquivo. Certifique-se de selecionar o novo _testbench_ no item **Compile testbench**.

Clique em **Assignments** `>` **Settings** `>` **General** e selecione a nova **Top Level entity** (`fulladder`).

Clique em **Processing** `>` **Start** `>` **Start Analysis and Elaboration**, e em seguida clique em **Tools** `>` **Run Simulation Tool** `>` **RTL Simulation** para iniciar a simulação.

Selecione a janela de forma de onda e utilize a ferramenta de Zoom para analisar toda a simulação.

Observe a forma de onda e certifique-se de que a saída produzida pelo _carry out_ está correta, juntamente com a soma. O comportamento apresentado deve ser equivalente à tabela verdade do somador completo.

Por último, analise o diagrama esquemático do circuito que você acabou de projetar. Na janela do Quartus Prime clique em **Tools** `>` **Netlist Viewers** `>` **RTL Viewer**.

## Acompanhamento (entrega: próximo laboratório)

Para este laboratório, tenha estes itens prontos para mostrar ao seu professor/monitor:

1. O diagrama do circuitos Somador Completo, juntamente com a tabela verdade equivalente;
2. A janela da forma de onda apenas do **Somador Completo**, apontando as formas de onda das três entradas e duas saídas do somador;
3. Diagrama esquemático produzido pela ferramenta **RTL Viewer**;

## Agradecimentos

Este laboratório é o resultado do trabalho de docentes e monitores de GCET231 ao longo dos anos, incluindo:

- **18.1:** Caio França dos Santos
- **18.2:** Matheus Rosa Pithon
- **20.2:** Matheus Rosa Pithon
- **21.1:** Matheus Rosa Pithon, Éverton Gomes dos Santos
- **21.2:** Éverton Gomes dos Santos
