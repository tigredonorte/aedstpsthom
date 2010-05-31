#include "heuristica.h"

void calculaConfiguracaoHeuristica(Grafo *grafo, int **solucao, int *sizeOfSolucao, long long int *NumeroTestes, double *lucroObtido, double *tempoGasto)
{
    int size = getNumVertices(grafo);
    Experimento *exp = malloc(sizeof(Experimento) * size);
    Experimento *VSolucao = malloc(sizeof(Experimento) * size);

    ExperimentosCopia(grafo, &exp);    
    ordenaExperimento(&exp, size);

    double melhorTempo = 0;
    double tAux = 0;;
    double tempo = getTempo(grafo);
    double lucro = 0;
    int i, j, idExpI, idExpJ;
    int candidato = 0;
    int k = 0;
    
    for(i = size - 1; i >= 0; i--)
    {
        candidato = 1;
        tAux = ExperimentoGetTime(&exp[i]);
        if((melhorTempo + tAux) <= tempo)
        {
            idExpI = ExperimentoGetId(&exp[i]);
            for(j = 0; j < k && candidato; j++)
            {
                idExpJ = ExperimentoGetId(&VSolucao[j]);
                if(!ExisteAresta(grafo, idExpI, idExpJ))
                {
                    candidato = 0;
                }
            }
            if(candidato)
            {
                VSolucao[k] = exp[i];
                k++;
                lucro += ExperimentoGetLucro(&exp[i]);
                melhorTempo += tAux;
            }
        }
    }
    (*sizeOfSolucao) = k;
    (*NumeroTestes) = 1;
    (*lucroObtido) = lucro;
    (*tempoGasto) = melhorTempo;
    (*solucao) = (int*)malloc(sizeof(int) * k);
    for(i = 0; i < k; i++)
    {
        (*solucao)[i] = ExperimentoGetId(&VSolucao[i]);
    }

    if(exp){free(exp);}
    if(VSolucao){free(VSolucao);}
}


double calculaMochilaGuloso(Experimento** exp, double capacidade, int size)
{
    ordenaExperimento(exp, size);
    Experimento Exper;

    double lucro = 0;
    short *mochila = malloc(sizeof(short) * size);
    int i = 0;
    
    for(i = 0; i < size; i++)
    {
        Exper = (*exp)[i];
        if(ExperimentoGetTime(&Exper) < capacidade)
        {
            capacidade -= ExperimentoGetTime(&Exper);
            lucro += ExperimentoGetLucro(&Exper);
        }
    }
    if(mochila){free(mochila);}
    return (lucro);
}

void ordenaExperimento(Experimento** exp, int size)
{
    Experimento elemento, elementoJ;
    double pivo;
    int i, j;
    for(i = 1; i < size; i++)
    {
        elemento = (*exp)[i];
        pivo = ExperimentoGetLucroTime(&elemento);
        j = i - 1;
        elementoJ = (*exp)[j];
        while(j > 0 && ExperimentoGetLucroTime(&elementoJ) > pivo)
        {
            (*exp)[j+1] = (*exp)[j];
            j--;
            elementoJ = (*exp)[j];
        }
        (*exp)[j+1] = elemento;
    }
}
