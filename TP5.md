O tema a ser estudado neste trabalho é a localidade de referência, uma propriedade
importante para o projeto de sistemas computacionais eficientes em diversos cenários reais.
Nesses sistemas, o acesso aos recursos tende a não ser igualmente provável, apresentando
certos padrões. Esses padrões podem ser explorados para a melhoria do desempenho de
sistemas computacionais. Um exemplo de recurso que apresenta alta localidade de
referência é a memória.
Basicamente, existem dois tipos de localidade de referência: a temporal e a espacial. A
localidade de referência temporal refere-se à tendência de acesso a um mesmo recurso
mais de uma vez em um curto intervalo de tempo. A localidade de referência espacial
refere-se à tendência de acesso a recursos que estejam próximos em um curto intervalo de
tempo. Tal tendência ocorre, por exemplo, dentro do corpo de comandos de repetição que
manipulam estruturas de dados como vetores e tabelas, cujos dados se localizam
geralmente em posições consecutivas de memória.
Um exemplo de aplicação da localidade de referência é o uso de cache, que basicamente é
uma área de armazenamento temporária onde dados são disponibilizados para acesso
rápido. Uma cache é constituída por um conjunto de elementos. Cada elemento tem (1)
uma etiqueta que identifica o dado no local de armazenamento original e (2) uma cópia
exata do dado presente no local original.
Nesse trabalho, trataremos o problema conhecido como Detecção de Vizinhos Próximos.
Uma instância desse problema é : existe um ponto q passado como consulta e o algoritmo
deve retornar como resposta os pontos da base de dados que estão a uma distância menor
ou igual a R de q. Em outras palavras, seja D o conjunto de pontos da base de dados e dist
uma função de distancia, o conjunto de pontos retornados S pode ser descrito como:
> S(q) = {                             }
Por exemplo, na figura abaixo, os pontos p1 e p2 pertencem a S(q), enquanto p3 não
pertence.
Nesse trabalho, deverá ser implementado um algoritmo aproximado para esse problema,
isto é,
dado um ponto de consulta q, um valor R e um valor K, o algoritmo deve retornar um
conjunto
W onde           e            . Ou seja, não será necessário retornar todos os pontos da base
que satisfazem                   , mas apenas K pontos quaisquer que satisfazem tal.
Além disso, o algoritmo deve implementar estratégias para políticas de substituição de
páginas
para grandes bases de dados. Considere uma página P um conjunto de pontos da base de
dados D, onde                  e existem n diferentes páginas. Assuma uma estratégia
simples para determinar páginas, como, por exemplo, dividir o arquivo de entrada em n
partes, e assim cada página P terá um número de pontos igual a |D|/n. Note é possível
recuperar qualquer página dentro do arquivo de entrada, conhecendo seu número i e o
número total de páginas n, sem a necessidade de percorrer todo o arquivo. Ou seja, o
primeiro ponto da página        estará
na linha (i 