#include "branch.h"

int coloreBranch(Grafo *grafo, long long *tentativas)
{
    //guardara o numero de cores calculado no momento, o numero total de cores e o numero de cores a tentar no momento
    int cor, cores;
    int NArestas = getNumArestas(grafo);

    //se nao possui arestas, so pode haver uma cor para o grafo
    if(NArestas == 0)
    {
        cor = 1;
        return cor;
    }

    //se o maior grau de uma aresta eh 2, so podem existir duas cores no grafo
    cores = calculaGrauGrafo(grafo);
    if(cores == 1)
    {
        return cores;
    }
    if(cores == 2)
    {
        return cores;
    }
    cores++;

    int size = getNumVertices(grafo);
    long long fat = fatorial(size); //calcula o fatorial do numero de vertices do grafo
    long long k = 0;                //k-ezima permutacao
    int *ordem = malloc(sizeof(int) * size); //vetor de permutacao
    long long tent = 0;
    (*tentativas) = 0;

    for(k = 0; k < fat; k++)
    {
        cor = 0;
        descoloreGrafo(grafo);
        ordem = Factoradic(size, k);
        cor = coloreGulosoTentativa(grafo, cores, ordem, &tent);
        (*tentativas) += tent;
        if(cores > cor)
        {
            cores = cor;
        }
    }
    free(ordem);
    return cores;
}
