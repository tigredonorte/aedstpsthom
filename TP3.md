Com base nesse problema, você poderá exercitar os seus conhecimentos sobre modelagem de
problemas usando grafos e paradigmas de projeto de algoritmos.
> Em vários problemas, é preciso particionar os vértices de um grafo em conjuntos de vértices
independentes. Imagine por exemplo que queremos dividir um grupo em subgrupos que contêm
somente elementos compatíveis como o problema de atribuição de horários para entrevista de emprego.
Nele, os vértices são pessoas e existe uma aresta entre dois vértices se elas serão entrevistadas pelo
mesmo gerente. Dessa forma, podemos escalonar os horários utilizando o conjunto de vértices
independentes, na qual pessoas no mesmo conjunto podem ser entrevistadas simultaneamente.
> Considere por exemplo o seguinte grafo:
> > Figura 1

> Eis uma partição dos vértices em conjuntos de vértices independentes: {a},{b, d}, {c,f}, {e}.
Uma solução ótima seria a seguinte: {a,c,e}, {b, d}, {f}. Em teoria dos grafos, esse problema é
representado como um problema de coloração.
> Seja G=(V,E) um grafo e C um conjunto de cores. Uma coloração de G é uma atribuição de
alguma cor de C para cada vértice de G, tal que dois vértices adjacentes sempre possuam cores
distintas. O número cromático do grafo da figura 1 é 3. Formalmente podemos declarar o problema
acima como:
Definição: Uma coloração de um grafo G=(V,E) é uma função                  , onde C é um conjunto de
cores, tal que para cada aresta (v,u) de E tem-se             . Uma k-coloração de G é uma coloração
que utiliza k cores. O número cromático X(G) de um grafo G é o menor número de cores k tal que
existe uma k-coloração para G.
> Neste trabalho, você deverá apresentar, implementar e avaliar os seguintes algoritmos:
1. Um algoritmo tentativa-e-erro para a obtenção do número de cores ótimo X(G).
2. Um algoritmo que utilize uma estratégia de branch and bound para a obtenção do número de cores
ótimo X(G).
3. Um algoritmo com heurística gulosa para obter uma solução ótima ou quase-ótima para o problema.
> Você deverá implementar os três algoritmos em um único programa que receberá como
parâmetros(através de getopt):
> -s <1|2|3> - indicando qual dos algoritmos deve ser utilizado
> -i <nome do arquivo de entrada>
> -o <nome do arquivo de saída>
> Os arquivos de entrada para esse trabalho assim como a descrição do formato de entrada estão
disponíveis em : http://mat.gsia.cmu.edu/COLOR/instances.html. Já o arquivo de saída deve conter o
valor X(G) e o número de soluções testadas para encontrar o número cromático ótimo. Por exemplo :
> 5
> 545
Apresente uma análise contendo os tempos de execução dos algoritmos e constrate os tempos obtidos
com o tamanho do grafo analisado (número de vértices e número de arestas).
Mostre ainda uma avaliação comparativa sobre os algoritmos com relação aos resultados obtidos
(número cromático e soluções testadas). Quão próximo da solução ótima o algoritmo com heurística
gulosa está?
O seu trabalho será avaliado segundo os seguintes critérios:
> > Execução correta
> > •
> > > Código bem-estruturado

> > •
> > > Código legível

> > •
> > > Saída legível

> > •
> > > Conformidade com o padrão de Documentação

> > •
> > > Comentários explicativos

> > •
> > > Análise de resultados

> > •