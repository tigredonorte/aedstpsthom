#include "grafo.h"

void inicializaGrafo(Grafo *grafo, int NVertices)
{
    grafo->NumVertices = NVertices;
    grafo->Mat = malloc(sizeof(int*) * NVertices);
    grafo->numArestas = 0;
    grafo->grafoCompleto = NVertices*NVertices;

    int i, j;
    for(i = 0; i < NVertices; i++)
    {
        grafo->Mat[i] = (int*)malloc(sizeof(int) * NVertices);
        for(j = 0; j < NVertices; j++)
        {
            grafo->Mat[i][j] = 0;
        }
    }
}

void InsereAresta(Grafo *grafo, int V1, int V2, int valor)
{
    grafo->Mat[V1][V2] = valor;
    grafo->numArestas++;
}


int getAresta(Grafo *Grafo, int V1, int V2)
{
    return (Grafo->Mat[V1][V2]);
}

void ImprimeGrafo(Grafo *Grafo)
{
    short i, j;

    printf("   ");
    for (i = 0; i < Grafo->NumVertices; i++)
    {
        printf("%3d", i);
    }

    printf("\n");

    for (i = 0; i < Grafo->NumVertices; i++)
    {
        printf("%3d", i);

        for (j = 0; j < Grafo->NumVertices; j++)
        {
            printf("%3d", Grafo->Mat[i][j]);
        }
        printf("\n");
    }
}  /* ImprimeGrafo */

void LiberaGrafo(Grafo *grafo)
{
    int i;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        if(grafo->Mat[i]){free(grafo->Mat[i]);}
    }
    if(grafo->Mat){free(grafo->Mat);}
}

int getNumVertices(Grafo *grafo)
{
    return(grafo->NumVertices);
}

int getArestaPagina(Grafo *grafo, int V1)
{
    int i;
    for(i = 0; i< grafo->NumVertices; i++)
    {
        if(grafo->Mat[V1][i] == 0)
        {
            return i;
        }
    }
    return -1;
}

short grafoCompleto(Grafo *grafo)
{
    return(grafo->NumVertices == grafo->grafoCompleto);
}
