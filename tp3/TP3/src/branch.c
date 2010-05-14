#include "branch.h"

void coloreBranch(Grafo *grafo)
{
    int grau = calculaGrauGrafo(grafo);
    int VSize = getNumVertices(grafo);
    int maxCores = grau + 1;
    int numCores = maxCores;

    //se o grafo nao tem arestas, o numero de cores e 1
    if(grau == 0) numCores = 1;

    //se o grafo so possui arestas ligando dois a dois
    if(grau == 1) numCores = 2;

    int i, j;

    //tentara de 2 a maxCores cores nos vertices
    for(i = 2; i <= maxCores; i++)
    {
        for(j = 0; j < VSize; j++)
        {

        }
    }
}

void colore(Grafo *grafo, int *VCores, int k, int i)
{
    int vSize = getNumVertices(grafo);
    if(i == vSize)
    {
        return;
    }

    int *vAux = (int*)malloc(sizeof(int) * vSize);
    int j;

    //zera o vetor
    for(j = 0; j < vSize; j++)
    {
        vAux[i] = 0;
    }

    //se uma cor nao pode ser usada para o vertice atual (vertice i)
    PLista aux = getPrimeiroLista(grafo, i);
    while(aux != NULL)
    {
        //insere na fila todas as cores dos vizinhos
        int vVer = getValorVertice(aux);
        int corVertice = getCorVertice(grafo, vVer);
        if(corVertice != 0)
        {
            vAux[corVertice] = 1;
        }
        aux = aux->Prox;
    }

    for(j = 0; j < vSize; j++)
    {
        int n = 0;
        while(vAux[n] == 1 || n < vSize)
        {
            n++;
        }
        VCores[i] = n+1;
        colore(grafo, VCores, k, i+1);
    }
}
