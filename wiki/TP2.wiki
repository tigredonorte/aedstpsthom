O trabalho prático 2 consiste em realizar uma análise comparativa de três estratégias para resolver o problema da construção da árvore binária de pesquisa ótima.

Árvores de binárias de pesquisa são estratégias tradicionais de implementar o tipo abstrato de dados dicionário, permitindo determinar rapidamente se uma palavra está num dicionário e, se estiver, recuperar informações a cerca dessa palavra.  O custo de buscar uma palavra na árvore de pesquisa é o número de acessos que é necessário realizar para chegar até ao nodo que contem a palavra. Assim, a raiz tem custo 1, enquanto as folhas têm custo máximo.

Uma árvore binária de pesquisa ótima é aquela cujo custo médio de acesso é o menor possível, dado um vocabulário e a probabilidade de acesso de cada palavra no vocabulário. O custo médio de acesso é calculado como a soma ponderada do
custo de acesso a cada palavra pela sua probabilidade de ser acessada.

Neste trabalho você deverá analisar o custo e a qualidade de três estratégias de
construção de uma árvore binária de pesquisa ótima (ou quase ótima):

- tentativa e erro
- guloso
- programação dinâmica.

A partir do vocabulário fornecido, e as respectivas frequências das palavras que compoem o vocabulário, realize experimentos que avaliem o desempenho
das árvores resultantes. Varie o tamanho do vocabulário e compare o custo
e o benefício das soluções resultantes em termos de tempo de execução e
custo médio de acessos.

Para cada estratégia apresente:

1) a estratégia em si
2) a implementação da estratégia
3) uma avaliação experimental do algoritmo

E conclua apresentando uma análise comparativa das três estratégias.