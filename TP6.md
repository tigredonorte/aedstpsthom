1      Introdução
> Buscar padrões em uma sequência é um problema com várias aplicações
em Ciência da Computação, que vão desde busca simples em texto até proces-
samento de sequências de DNA. Você mesmo, provavelmente, se depara com
esse problema várias vezes ao dia: toda vez que você faz uma pesquisa em
uma máquina de busca (Google, Bing, Yahoo!, Duck Duck Go e outras) essenci-
almente você está pedindo as ocorrências de um determinado padrão (de texto,
no caso) em uma base de documentos vistos como sequências de caracteres.
> Existem várias situações, porém, nas quais você não quer encontrar apenas
ocorrências exatas de um dado padrão, mas sim ocorrências aproximadas. Isso
ocorre quando o padrão ou a base de busca podem ter sofrido algum tipo
de corrupção. Em pesquisas na Web, temos que frequentemente os usuários
cometem erros de ortografia. Em processamento de sinais, o sinal pode ter
sofrido interferência durante a transmissão. Em processamento de cadeis de
DNA, mutações ocorrem. Assim, há várias aplicações nas quais você quer
encontrar ocorrências de um padrão, porém aceitando um certo número limite
de erros.
> Nesse trabalho, você deverá encontrar soluções para o problema de casa-
mento aproximado de padrões em texto. Para tanto, você irá implementar uma
versão do programa grep1 que lista todas as linhas de um arquivo de texto nas
quais há alguma ocorrência aproximada do padrão de busca. Dizemos que há
um casamento aproximado de um padrão P num texto T se existe uma substring
de T que é aproximadamente igual a P .
> Há vários subproblemas a serem resolvidos. Inicialmente, você deverá de-
terminar quando, exatamente, duas strings podem ser ditas aproximadamente
  1. 
> > http://en.wikipedia.org/wiki/Grep
      1. 
> > > > 2
iguais. Em seguida, você irá propor uma estratégia de força bruta para en-
contrar substrings aproximadamente iguais a um padrão num texto. Por fim,
você irá implementar um algoritmo mais eficiente para o mesmo problema. As
próximas seções descreverão essas etapas em detalhes.
2     Quando duas sequências de caracteres são aproxi-

> > > madamente iguais?

> > O primeiro passo para resolver esse problema consiste em determinar quando,
exatamente, podemos considerar que duas sequências de caracteres são apro-
ximadamente iguais. Sejam x = x1 x2 . . . xn e y = y1 y2 . . . ym duas sequências
de caracteres de tamanho n e m, respectivamente, e seja d uma função de dis-
tância (a ser definida posteriormente). Dizemos que as sequências x e y são
aproximadamente iguais se
> > > d(x, y) ≤ k
para um dado limite k , que é parâmetro de entrada, i.e., elas são aproxima-
damente iguais se estão a uma distância menor ou igual a um certo limite de
tolerância.

> > Resta-nos, agora, escolher uma função d que seja uma boa métrica para a
distância entre duas sequências. Para esse trabalho, usaremos a função de dis-
tância de Levenshtein LD(x, y), que mede o número mínimo de operações que
precisam ser feitas para transformar uma sequência na outra, onde as opera-
ções disponíveis são:

> • Inserção. Inserir um caractere na sequência. Por exemplo, transformar a
> > sequência abcy na sequência adbcy , inserindo o caractere d entre a primeira
> > e a segunda posição da sequência original.

> • Remoção. Remover um caractere existente na sequência. Por exemplo,
> > transformar W ololo! em W ololo através da remoção de “!”.

> • Substituição. Trocar um caractere da sequência por outro. Por exemplo,
> > transformar a sequência ratatat em ratutat trocando um “a” por “u”.
> > Alguns exemplos:
  1. LD(abcd, abcd) = 0. A distância entre uma sequência e ela mesma é zero.
> > 3
> > 2. LD(kitten, sitting) = 3. O menor número de operações para transformar
> > > uma string na outra é exatamente três, que corresponde a substituir o ʻkʼ
> > > por ʼsʼ, substituir o ʼeʼ por ʼiʼ e inserir ʼgʼ ao fim.

> > 3. LD(xyz, abcd) = 4.
> > 4. LD(programming, pogramming) = 1.
> > > Sua primeira tarefa nesse trabalho prático será desenvolver um algoritmo de

> > programação dinâmica para calcular a distância entre duas sequências.
Questão 1 Prove que o problema de calcular a distância de Levenshtein entre duas
> > > sequências tem sub-estrutura ótima. Há sobreposição de sub-problemas?
Questão 2 Desenvolva um algoritmo de programação dinâmica para realizar esse
> > > cálculo. Qual a complexidade do seu algoritmo? Justifique.

> > 3     Casamento aproximado de padrões
> > > Agora que você já sabe quando é que duas sequências de caracteres são

> > aproximadamente iguais, você deve resolver o problema de casamento apro-
> > ximado de sequências. Dado um padrão P , um texto T e um threshold de
> > similaridade k , o problema de casamento aproximado é o de encontrar todas
> > as ocorrências em T de padrões P ′ tais que d(P, P ′ ) ≤ k , i.e., encontrar todas
> > as subsequências de T que estejam a uma distância máxima k do padrão P .
Questão 3 Usando o algoritmo que você desenvolveu anteriormente para o cálculo
> > > da distância de Levenshtein, construa um algoritmo de tentativa e erro
> > > para o problema. Qual a complexidade de seu algoritmo? Justifique.
Questão 4 Descreva o algoritmo Shift-And para casamento aproximado [2](2.md). Mostre
> > > qual é a complexidade desse algoritmo.

> > 4     O que deve ser implementado
> > > Você deve implementar os algoritmos que apresentou anteriormente (tenta-

> > tiva e erro e shift-and aproximado) para resolver o problema do casamento
> > aproximado, criando um programa que, dado um arquivo de texto, um padrão
> > > 4
> > > e um limite de distância, retorne todas as linhas do arquivo nas quais há um
> > > casamento aproximado para o padrão.
> > > > O executável do seu programa deve obrigatoriamente se chamar fuzzygrep

> > > e deve aceitar os seguintes parâmetros:
-p <padrão> indicando o padrão a ser pesquisado
-k 

&lt;limite&gt;

 indicando o limite máximo de distância entre sequências para o casamento
> > > > aproximado

> -s <fb|sa> indicando o algoritmo a ser utilizado:
> > fb algoritmo de força bruta;
> > sa algoritmo Shift-And aproximado.
> > Se o parâmetro -s não for passado via linha de comando, deve-se usar o
> > Shift-And aproximado.
> > O texto no qual o casamento deve ser realizado deverá ser lido da entrada
> > padrão (stdin) e a saída do seu programa deve ser escrita na saída padrão
> > (stdout). A saída do programa deve conter todas as linhas que casem com o
> > padrão e apenas elas, sem nenhuma informação adicional.
> > > Seu programa será corrigido de forma automática, logo é muito importante

> > que o padrão de parâmetros de entrada, nome do executável e formato de saída
> > seja seguido à risca.
> > > Exemplo de invocação do programa:
> > > > ./fuzzygrep -p patapon -k 3 -s sa < entrada.txt > saída.txt

> > 5    Exemplos
> > > A seguir, mostramos alguns exemplos de invocações do programa, com os

> > parâmetros de linha de comando, o texto do arquivo de entrada e a saída
> > esperada em cada caso. Leia com atenção e entenda cada um desses exemplos.
> > > 5
5.1   Exemplo 1
Comando: ./fuzzygrep -p Rachmaninov -k 3
Texto de Entrada:
Sergei Vasilievich Rachmaninoff was a Russian composer,
pianist, and conductor. He was considered one of the
finest pianists of his day and, as a composer, very
nearly the last great representative of Russian late
Romanticism in classical music. Early influences of
Tchaikovsky, Rimsky-Korsakov and other Russian composers
gave way to a thoroughly personal idiom which included a
pronounced lyricism, expressive breadth, structural
ingenuity and a tonal palette of rich, distinctive
orchestral colors.
Saída Esperada:
Sergei Vasilievich Rachmaninoff was a Russian composer,
Comentários: a sequência “Rachmaninoff”, na primeira linha, está à distância
dois do padrão desejado e, portanto, a primeira linha deve ser incluída na
saída. Nenhuma das demais linhas deve ser incluída, pois nenhuma delas possui
uma subsequência que esteja à distância menor ou igual a 3 do padrão pedido.
5.2    Exemplo 2
Comando: ./fuzzygrep -p rock -k 1
Texto de Entrada:
Rock! Robot Rock!
Saída Esperada:
Rock! Robot Rock!
Comentários: há duas subsequências da primeira linha que estão à distância um
do padrão pedido (as duas ocorrências de “Rock”). Note que a comparação é
sensível à caixa, e logo LD(rock, Rock) é 1 e não zero, pois é preciso substituir
ʻRʼ por ʼrʼ. Observe também que apesar de haver múltiplos casamentos de
padrão na mesma linha, ela só é impressa uma vez.
> > > 6
5.3    Exemplo 3
Comando: ./fuzzygrep -p we -k 0
Texto de Entrada:
Water is life.
It has become a rare commodity here in Outland.
A commodity that we alone shall control.
We are the Highborne,
and the time has come at last
for us to retake our rightful place in the world!
Saída Esperada:
A commodity that we alone shall control.
Comentários: Zero é um valor válido para o limite de distância. Nesse caso,
pela definição de distância de Levenshtein, deve ocorrer casamento exato.
5.4    Exemplo 4
Comando: ./fuzzygrep -p patapon -k 10
Texto de Entrada:
I can see what you see not
Vision milky then eyes rot
When you turn they will be gone
Whispering their hidden song
Then you see what cannot be
Shadows move where light should be
Out of darkness, out of mind
Cast down into the Halls of the Blind.
Saída Esperada:
I can see what you see not
Vision milky then eyes rot
When you turn they will be gone
Whispering their hidden song
> > > 7
Then you see what cannot be
Shadows move where light should be
Out of darkness, out of mind
Cast down into the Halls of the Blind.
Comentários: Como o limite é maior que o tamanho do padrão, é sempre pos-
sível transformar o padrão em uma outra string de mesmo tamanho, de forma
que, nesse caso, todas as linhas vão constar na saída.
5.5     Exemplo 5
Comando: ./fuzzygrep -p “que vou passar” -k 3
Texto de Entrada:
O semestre esta acabando.
Meus Deus! Será que fou passar?
Bom, eu fui um bom aluno e fiz
todos os trabalhos práticos e provas.
Claro que eu vou passar!
Saída Esperada:
Meus Deus! Será que fou passar?
Comentários: o padrão é uma sequência de caracteres qualquer, e pode inclu-
sive conter mais de uma palavra
5.6     Exemplo 6
Comando: ./fuzzygrep -p “fiz todos os trabalhos” -k 3
Texto de Entrada:
O semestre esta acabando.
Meus Deus! Será que fou passar?
Bom, eu fui um bom aluno e fiz
todos os trabalhos práticos e provas.
Claro que eu vou passar!
Saída Esperada:
> > > > 8

> > Comentários: o casamento é feito linha-a-linha. Ainda que o padrão “fiz todos
> > os trabalhos” apareça no texto, ele aparece em parte na linha 3 e em parte na
> > linha 4, de forma que nenhuma linha apresenta o padrão inteiro. Portanto, a
> > saída é vazia.
> > 6     Extras!
> > > Nós sabemos que você adora os TPs de AEDS 3. Infelizmente, esse é o

> > último TP do semestre, após ele você não terá mais trabalhos práticos com os
> > quais se divertir. Entendemos que isso pode ser uma experiência estressante
> > para você e, para aliviar o impacto dessa situação, vamos lhe oferecer alguns
> > ítens adicionais que você pode fazer para esse trabalho, valendo pontos extras.
Questão 5 Paralelize os algoritmos para casamento aproximado que você implemen-
> > > tou. Descreva como foi feita a paralelização, calcule analiticamente o spe-
> > > edup esperado e faça testes para verificar se o speedup real corresponde
> > > ao que você calculou.
Questão 6 Nesse trabalho, a função de distância leva em conta apenas o número de
> > > operações realizadas. Em vários cenários práticos, algumas operações
> > > podem ter custo maior ou menor que outras. A Distância de Levenshtein
> > > Generalizada é uma modificação da função de distância que leva em
> > > conta não o número de operações, mas o custo total das operações reali-
> > > zadas, onde cada tipo de operação tem um custo definido. A distância de
> > > Levenshtein que usamos nesse trabalho é um caso especial, onde o custo
> > > de todas as operações é fixado em 1. Implemente a versão generalizada
> > > da distância de Levenshtein.
Questão 6 Os algoritmos que você implementou não são os únicos existentes para
> > > resolver esse problema. Consulte a literatura e implemente um outro algo-
> > > ritmo qualquer para ele. Descreva-o e analise sua complexidade. Quais
> > > são as vantagens e desvantagens desse algoritmo comparado ao Shift-
> > > And aproximado?

> > 7     Observações
> > > • A principal referência sobre o assunto é o estudo de Navarro [1](1.md).
> > > > 9

> > • A principal referência em português é o livro de Ziviani [2](2.md).
> > • Não há possibilidade de entrega com atraso para esse trabalho. Entregue
> > > no dia certo!

> > • A data de entrega é 5/7/2010 e não há possibilidade de adiamento de-
> > > vido ao fim do semestre.
Referências
[1](1.md) G. Navarro, A guided tour to approximate string matching, ACM compu-
> > > ting surveys (CSUR) 33 (2001), no. 1, 88.
[2](2.md) Nivio Ziviani, Projeto de algoritmos: com implementações em pascal e c,
> > > Pioneira Thomson, 2004.