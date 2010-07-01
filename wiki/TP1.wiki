O trabalho prático 1 tem por objetivo implementar um programa paralelo em pthreads. O problema a ser trabalhado é a construção e acesso paralleizado a dicionários de dados implementados utilizando hash.

Um serviço de buscas na Web executa duas tarefas fundamentais. A primeira tarefa é a indexação, que consiste basicamente em armazenar, para cada termo encontrado em um documento indexados, a referência ao documento. A segunda tarefa consiste em, dado um conjunto de termos que compõem a sua consulta, retornar a lista de documentos onde todos os termos aparecem.

O programa possui quatro tipos de processos:

1) processo que insere termos no dicionário
2) processo que recupera listas de documentos para uma consulta
3) processo que gera documentos para inserção, com base em alguma
distribuição estatística
4) processo que gera consultas para  serem respondidas.

São parâmetros do programa a ser executado o número de processos
de inserção e recuperação, assim como a taxa de geração de documentos
e de consultas. O programa deve executar por um número pré-fixado
de gerações, ao fim do qual é emitido um relatório.

A métrica de sucesso mais importante é a lat?ncia, ou seja, quanto tempo
para responder uma consulta, a qual deve ser sempre atual em termos dos
documentos inseridos.