#include "heuristica.h"

void calculaConfiguracaoHeuristica(Grafo *grafo, int *solucao, int *sizeOfSolucao, int *NumeroTestes, double *lucroObtido)
{
    int size = getNumVertices(grafo);
    Experimento *exp = (Experimento*)malloc(sizeof(Experimento) * size);
    Experimento *VSolucao = (Experimento*)malloc(sizeof(Experimento) * size);

    ExperimentosCopia(grafo, exp);
    ordenaExperimento(&exp, size);

    double tempo = getTempo(grafo);
    double lucro = 0;
    int i, j, idExpI, idExpJ;
    int candidato = 0;
    int k = 0;
    
    for(i = 0; i < size; i++)
    {
        solucao[i] = 0;
        candidato = 1;
        if(ExperimentoGetTime(&exp[i]) <= tempo)
        {
            idExpI = ExperimentoGetId(&exp[i]);
            for(j = i -1; j >= 0 && candidato; j--)
            {
                idExpJ = ExperimentoGetId(&exp[j]);
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
            }
        }
    }
    (*sizeOfSolucao) = k;
    (*NumeroTestes) = 1;
    (*lucroObtido) = lucro;

    solucao = (int*)malloc(sizeof(int) * k);
    for(i = 0; i < k; i++)
    {
        solucao[i] = ExperimentoGetId(&VSolucao[i]);
    }

    free(exp);
    free(VSolucao);
}


double calculaMochilaGuloso(Experimento** exp, double capacidade, int size)
{
    ordenaExperimento(exp, size);

    double lucro = 0;
    short *mochila = malloc(sizeof(short) * size);
    int i = 0;
    
    for(i = 0; i < size; i++)
    {
        if(ExperimentoGetTime(exp[i]) < capacidade)
        {
            capacidade -= ExperimentoGetTime(exp[i]);
            lucro += ExperimentoGetLucro(exp[i]);
        }
    }
    free(mochila);
    return (lucro);
}

void ordenaExperimento(Experimento** exp, int size)
{
    Experimento elemento;
    double pivo;
    int i, j;
    for(i = 1; i < size; i++)
    {
        pivo = ExperimentoGetLucroTime(exp[i]);
        elemento = *exp[i];
        j = i - 1;
        while(j > 0 && ExperimentoGetLucroTime(exp[i]) > pivo)
        {
            *exp[j+1] = *exp[j];
            j--;
        }
        *exp[j+1] = elemento;
    }
}
