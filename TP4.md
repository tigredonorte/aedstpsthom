TP4
O mundo capitalista e maximização de lucros
Disponível a partir quarta, 14 abril 2010,
de:                                    23:40
> segunda, 31 maio 2010,
Data de entrega:
> 23:55
Neste trabalho, você foi convidado a participar da seleção de experimentos para a
realização de um grande projeto científico. O laboratório científico Xulambs, responsável
pela execução da pesquisa, possui um conjunto de experimentos de diversas empresas de
software a serem realizados dentro de um prazo. Os experimentos precisam respeitar um
prazo sob o risco de não conseguir entregar os resultados ao financiadores do projeto. Além
disso, as empresas decidiram, através de um contrato, que está proibido que experimentos
de empresas concorrentes no mercado sejam executados pela Xulambs. Em outras
palavras : os experimentos de uma empresa X não podem ser executados se os cientistas
decidirem executar os experimentos da empresa concorrente Y.
Você foi contratado para aumentar o lucro do laboratório Xulambs, escolhendo o conjunto
de empresas cujos experimentos serão executados dentro do prazo dado. Devido a crise
economica, a Xulambs disponibilizou a você apenas um computador. Ademais foi lhe
informado o prazo máximo para execução dos experimentos, uma lista contendo as tarefas
de cada empresa (lucro e o tempo gasto para executá-la na máquina fornecida) e uma lista
com a relação de concorrência entre as empresas.
O chefe do laboratório Xulambs é um matemático que tem paixão por modelagem em
grafos. Ele lhe pediu, pessoalmente, para resolver esse problema utilizando grafos. Ele lhe
disse também para pesquisar sobre CLIQUES em grafos, e para apresentar uma prova
formal de que o problema de identificação de todas as cliques é NP-Completo.
Você deverá implementar 2 algoritmos:
  1. Um algoritmo que obtenha a solução ótima para o problema
> 2.    Uma heurística para resolver o problema
Entrada:
Seu programa receberá como entrada uma tabela contendo informações sobre cada um dos
experimentos a serem realizados e o tempo esperado para a execução do experimento em
um computador padrão e o prazo dado para você entregar os resultados às empresas
escolhidas. Essa tabela é um arquivo contendo na primeira linha o tempo total para
execução dos experimentos, o número de experimentos e o número de empresas que
solicitaram o serviço da Xulambs. Em seguida temos as informações sobre os experimentos,
um experimento por linha. Cada linha nos dá : identificador do experimento, identificador
da empresa que requisitou o experimento, seguido pelo lucro e o custo (tempo gasto) por
esse experimento. Por fim,
temos a relação de concorrência, onde cada empresa é descrita por linha (identificador da
empresa seguido dos identificadores das empresas concorrentes).
A seguir, é dado um exemplo de arquivo de entrada:
600 3 3
exp1 1 100 270
exp2 2 250 320
exp3 3 330 230
exp4 4 120 400
134
2
31
41
Nesse exemplo, temos 4 experimentos que devem ser realizados num prazo de 600 dias. O
primeiro experimento (segunda linha) é requisitado pela empresa 1, ele gera um lucro de
100 reais
e gasta um tempo de 270 dias para ser executado. A linha 4 mostra que a empresa 1
considera como concorrente a empresa 3 e 4.
Saída:
Seu programa deve retornar como resultado o número de configurações possíveis que
respeitem os critérios de prazo e contrato.
Além disso, você deve retornar a configuração ótima e com seu tempo de execução e lucro
obtido.
Primeira linha : configurações possíveis.
Segunda linha : lucro e tempo gasto pela solução ótima
Terceira linha : lista de experimentos da solução ótima
8
580 550
exp2 exp3
O que deve ser implementado:
Você irá implementar um programa que recebe como parâmetros o nome do arquivo de
entrada (contendo os experimentos a serem realizados), a estratégia a ser aplicada:
solução ótima (1) ou heurística proposta por você (2), e o nome do arquivo de saída. O
programa deve receber os parâmetros através da função getopt e ser executado através de
um comando na forma:
\>    ./tp3 -i <arquivo de entrada> -s <1|2> -o <arquivo de saída>
O que deve ser avaliado:
-Sua modelagem do problema e a prova que ele é NP-Completo.
-Os resultados obtidos pela heurística e pelo algoritmo que obtém a solução ótima para
diferentes entradas (tempo total para a execução dos experimentos e experimentos a serem
realizados) em termos de tempo de execução do seu programa e qualidade da resposta, ou
seja, diferenças entre lucro gerado.
-Outras avaliações que você considerar importantes serão valorizadas na correção do
trabalho.
-Não se esqueça de que realizar experimentos significativos é essencial, já que você precisa
convencer um grupo de cientistas.