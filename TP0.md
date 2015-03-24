O trabalho prático 0 tem por objetivo exercitar primitivas básicas da linguagem C e iniciar a discussão sobre problemas complexos e a sua solução. Um instrumento importante para a avaliação de soluções para problemas é o que se conhece por análise de Monte Carlo, e esse trabalho prático tem por objetivo implementar tal análise no contexto de agrupamentos de dados.

O problema a ser tratado é o problema de avaliar a tendência de agrupamento de um conjunto de pontos através do escore conhecido como Hopkins Statistic.

O seu programa recebe como entrada o nome de um arquivo e o número de testes
a serem realizados e gera como saída a probabilidade que os pontos quem compoem
o arquivo sejam agrupáveis.

Assim, elabore um programa com as seguintes características:

  1. Projete o programa, incluindo as estruturas de dados a serem utilizadas, em particular a estrutura que permite calcular eficientemente a distância entre dois pontos.
> 2. O programa deve ser implementado em 3 módulos. O primeiro módulo deve tratar os procedimentos de entrada e saída. O segundo módulo contém a lógica da análise de Monte Carlo. E o terceiro módulo o programa principal. A compilação do programa deve utilizar o utilitário Make.
> 3. Todas as estruturas de dados devem ser alocadas dinamicamente.
> 4. A passagem de parâmetros para o programa deve utilizar a primitiva getopt
> 5. Realize várias execuções do seu programa, mostrando a correção do mesmo e utilizando as funções getrusage e gettimeofday para medir o seu desempenho. Analise de forma diferenciada entre os tempos de usuário e tempo de relógio. Comente sobre os tempos de usuário e tempos de sistema e sua relação com os tempos de relógio.