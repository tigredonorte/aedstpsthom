#include "grafo.h"

void inicializaGrafo(Grafo *grafo, int tempoT, int NEmp)
{
    grafo->NumVertices = NEmp;
    grafo->tempo = tempoT;
    grafo->Mat = (int**)malloc(sizeof(int*) * (NEmp + 1));
    
    int i = 0;
    for(i = 0; i < NEmp; i++)
    {
        grafo->Mat[i] = (int*)malloc(sizeof(int) * (NEmp + 1));
    }
}

void FGVazio(Grafo *Grafo)
{
    short i, j;

    for (i = 0; i <= Grafo->NumVertices; i++)
    {
        for (j = 0; j <=Grafo->NumVertices; j++)
        {
            Grafo->Mat[i][j] = 0;
        }
    }
}


void InsereAresta(Grafo *Grafo, int *V1, int *V2)
{
    Grafo->Mat[*V1][*V2] = 1;
}


short ExisteAresta(Grafo *Grafo, int Vertice1, int Vertice2)
{
    return (Grafo->Mat[Vertice1][Vertice2] > 0);
}


short ListaAdjVazia(Grafo *Grafo, int *Vertice)
{
    Apontador Aux = 0;
    short ListaVazia = 1;

    while (Aux < Grafo->NumVertices && ListaVazia)
    {
        if (Grafo->Mat[*Vertice][Aux] > 0)
        {
            ListaVazia = 0;
        }
        else
        {
            Aux++;
        }
        return (ListaVazia == 1);
    }  /* ListaAdjVazia */
}

Apontador PrimeiroListaAdj(Grafo *Grafo, int *Vertice)
{
    int Result;
    Apontador Aux = 0;
    short ListaVazia = 1;

    while(Aux < Grafo->NumVertices && ListaVazia)
    {
        if(Grafo->Mat[*Vertice][Aux] > 0)
        {
            Result = Aux;
            ListaVazia = 0;
        }
        else
        {
            Aux++;
        }
    }
    if (Aux == Grafo->NumVertices)
    {
        printf("Erro: Lista adjacencia vazia (PrimeiroListaAdj)\n");
    }
    return Result;
}  

void ProxAdj(Grafo *Grafo, int *Vertice, int *Adj, Apontador *Prox, short *FimListaAdj)
{
    /* --Retorna Adj apontado por Prox--*/
    *Adj = *Prox;
    (*Prox)++;
    while (*Prox < Grafo->NumVertices && Grafo->Mat[*Vertice][*Prox] == 0)
    {
        (*Prox)++;
    }
    if (*Prox == Grafo->NumVertices)
    {
        *FimListaAdj = 1;
    }
}  

void RetiraAresta(Grafo *Grafo, int *V1, int *V2)
{
    if (Grafo->Mat[*V1][*V2] == 0)
    {
        printf("Aresta nao existe\n");
    }
    else
    {
        Grafo->Mat[*V1][*V2] = 0;
    }
}

void ImprimeGrafo(Grafo *Grafo)
{
    short i, j;

    printf("   ");
    for (i = 0; i <= Grafo->NumVertices - 1; i++)
    {
        printf("%3d", i);
    }

    printf("\n");

    for (i = 0; i <=  Grafo->NumVertices - 1; i++)
    {
        printf("%3d", i);

        for (j = 0; j <=Grafo->NumVertices - 1; j++)
        {
            printf("%3d", Grafo->Mat[i][j]);
        }
        printf("\n");
    }
}  /* ImprimeGrafo */

void GrafoTransposto(Grafo *grafo, Grafo *grafoT)
{
    int v, Adj;
    Apontador Aux;
    short FimListaAdj = 0;

    FGVazio(grafoT);
    grafoT->NumVertices = grafo->NumVertices;
    for (v = 0; v <= grafo->NumVertices - 1; v++)
    {
        if (!ListaAdjVazia(grafo, &v))
        {
            Aux = PrimeiroListaAdj(grafo, &v);
            FimListaAdj = 0;
            while (!FimListaAdj)
            {
                ProxAdj(grafo, &v, &Adj, &Aux, &FimListaAdj);
                InsereAresta(grafoT, &Adj, &v);
            }
        }
    }
}  /* GrafoTransposto */

//cria um novo experimento associado a um vertice do grafo
void adicionaExperimento(Grafo *grafo, int vertice, int lucro, int tempo, char *nomeExperimento)
{

}
