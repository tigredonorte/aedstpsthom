#include "guloso.h"

int coloreGuloso(Grafo *grafo, long long *tentativas)
{
    int nCores = 0;
    int grau = calculaGrauGrafo(grafo);
    int size = getNumVertices(grafo);
    int *vAux = (int*)malloc(sizeof(int) * size + 1);
    int nVertices = getNumVertices(grafo);
    int i, j, vVer, corVertice, cor, encontrou;

    PLista aux = NULL;
    grau++; //o maior numero de cores eh o grau do grafo + 1

    //varrera todos os vertices
    for(i = 0; i < nVertices; i++)
    {
        //zera o vetor auxiliar, que ira conter as cores ja preenchidas
        for(j = 0; j < grau; j++)
        {
            vAux[j] = 0;
        }

        //varrera as arestas do vertice i
        aux = getPrimeiroLista(grafo, i);
        while(aux != NULL)
        {
            //insere no vetor todas as cores dos vizinhos ja preenchidas
            vVer = getValorVertice(aux);
            corVertice = getCorVertice(grafo, vVer);
            if(corVertice != 0)
            {
                vAux[corVertice] = 1;
            }
            aux = aux->Prox;
        }
        cor = 1;
        encontrou = 0;
        for(j = 1; j <= grau && !encontrou; j++)
        {
            //a cada iteracao ele tenta uma nova cor
            (*tentativas)++;

            //verifica se ha uma cor vazia
            if(vAux[j] == 0)
            {
                cor = j;
                encontrou = 1;
            }
        }

        //guarda o maior numero de cores
        if(nCores < cor)
        {
            nCores = cor;
        }
        //encontrou uma cor satisfatoria, entao colore
        setCorVertice(grafo, i, cor);
    }
    free(aux);
    free(vAux);
    return(nCores);
}
