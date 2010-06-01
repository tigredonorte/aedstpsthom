#include "tentativa.h"

void proxCombinacao(int **v, int size)
{
    int terminou = 0;
    int carry = 0;
    int i =0;

    for(i = 0; i < size && !terminou; i++)
    {
        if((*v)[i] == 0)
        {
            carry = 0;
            terminou = 1;
            (*v)[i] = 1;
        }
        else
        {
            carry = 1;
            (*v)[i] = 0;
        }
    }
}

void calculaConfiguracaoTentativa(Grafo *grafo, int **solucao, int *sizeOfSolucao, long long int *configuracoes, double *lucroObtido, double *tempoGasto)
{
    //recupera informacoes a serem usadas no grafo
    int size = getNumVertices(grafo);
    double TTotal = getTempo(grafo);
    
    //guarda os experimentos do grafo
    Experimento *e = malloc(sizeof(Experimento) * size);
    ExperimentosCopia(grafo, &e);

    //definicao de variaveis auxiliares
    Experimento *VSolucao = malloc(sizeof(Experimento) * size); //guarda os elementos adicionados, que ainda serao verificados
    int *v = malloc(sizeof(int) * size);    //usado para verificar se um elemento pode ou nao ser incluido
    int *solucaoAux = malloc(sizeof(int) * size);  //guarda a melhor solucao do problema

    double tempo = 0;
    double MelhorTempo = 0;
    double tAux = 0;
    double valor = 0;
    double MValor = 0;

    int i, j, k, l;     //variaveis de iteracao em loop
    int nSolucoes = 0;  //numero de solucoes viaveis
    int idExpJ, idExpL; //guarda os ids de experimentos
    int melhorK = 0; //tamanho da melhor solucao adotada
    int coubeTodos = 0; //verifica se todos os elementos couberam na mochila, neste caso pode parar a iteracao
    int candidato = 0;  //verifica se um experimento concorre com o outro
    int verificou = 0;

    //vetor que guardara o ou 1, se for 0, o elemento pode ser incluido, se for 1 nao pode
    for(i = 0; i < size; i++)
    {
        v[i] = 1;
    }

    //fara 2exp(size) combinacoes
    long long int numVezes = (int)pow(2, size);
    for(i = 0; i < numVezes && !coubeTodos; i++)
    {
        k = 0;
        valor = 0;
        tempo = 0;
        for(j = 0; j < size; j++)
        {
            //todo vertice eh candidato, a priori
            candidato = 1;

            //verifica dentre os experimentos combinados, quais devem ser considerados
            if(v[j] == 1)
            {
                verificou = 1;
                tAux = ExperimentoGetTime(&e[j]);
                //verifica se o experimento cumpre as condicoes de tempo
                if((tempo + tAux) <= TTotal)
                {
                    //identificador do experimentoJ
                    idExpJ = ExperimentoGetId(&e[j]);

                    //percorre o vetor solucao parcial com os indices ja adicionados
                    for(l = 0; l < k && candidato; l++)
                    {
                        //identificador do ExperimentoL
                        idExpL = ExperimentoGetId(&VSolucao[l]);

                        //se nao existe aresta no grafo entao o elemento indice l nao eh candidato
                        if(!ExisteAresta(grafo, idExpJ, idExpL))
                        {
                            candidato = 0;
                        }
                    }
                    //se o elemento for candidato adiciona o mesmo no vetor solucao parcial
                    if(candidato)
                    {
                        VSolucao[k] = e[j];
                        k++;
                        valor += ExperimentoGetLucro(&e[j]);
                        tempo += tAux;
                    }
                }
            }
        }
        //verifica se o valor calculado eh maior do que o maiorValor salvo
        if(MValor < valor)
        {
            //valor < MValor, salva a solucao
            for(j = 0; j < k; j++)
            {
                solucaoAux[j] = ExperimentoGetId(&VSolucao[j]);
            }
            //salva o tamanho da melhor solucao
            melhorK = k;

            //salva o melhor tempo
            MelhorTempo = tempo;

            //salva o melhor valor
            MValor = valor;
        }
        
        //se todos os elementos couberam na mochila, entao retorne
        if((k+1) == size)
        {
            coubeTodos = 1;
        }
        if(candidato && verificou)
        {
            nSolucoes++;
        }
        proxCombinacao(&v, size);
    }

    //salva saida
    *configuracoes = nSolucoes;
    *lucroObtido = MValor;
    *tempoGasto = MelhorTempo;
    *solucao = malloc(sizeof(int) * melhorK);
    for(i = 0; i < melhorK; i++)
    {
        (*solucao)[i] = solucaoAux[i];
    }
    *sizeOfSolucao = melhorK;

    //libera memoria
    free(solucaoAux);
    free(VSolucao);
    free(v);
    free(e);
}
