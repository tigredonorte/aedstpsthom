#include "grafo.h"

void inicializaGrafo(Grafo *grafo, double tempoT, int NVertices)
{
    grafo->NumVertices = NVertices;
    grafo->tempo = tempoT;
    grafo->Mat = (int**)malloc(sizeof(int*) * NVertices);
    
    int i = 0;
    for(i = 0; i < NVertices; i++)
    {
        grafo->Mat[i] = (int*)malloc(sizeof(int) * NVertices);
    }

    grafo->Exp = (Experimento*)malloc(sizeof(Experimento) * NVertices);
}

void FGVazio(Grafo *Grafo)
{
    short i, j;

    for (i = 0; i < Grafo->NumVertices; i++)
    {
        for (j = 0; j < Grafo->NumVertices; j++)
        {
            Grafo->Mat[i][j] = 0;
        }
    }
}


void InsereAresta(Grafo *grafo, int V1, int V2)
{
    grafo->Mat[V1][V2] = 1;
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
    }
    return (ListaVazia == 1);
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
                InsereAresta(grafoT, Adj, v);
            }
        }
    }
}  /* GrafoTransposto */

void LiberaGrafo(Grafo *grafo)
{
    int i;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        free(grafo->Mat[i]);
    }
    free(grafo->Mat);
    free(grafo->Exp);
}

void insereExperimento(Grafo *grafo, int experimento, int empresa, double lucro, double tempo)
{
    int i = experimento;
    grafo->Exp[i].experimento = experimento;
    grafo->Exp[i].empresa = empresa;
    grafo->Exp[i].lucro = lucro;
    grafo->Exp[i].tempo = tempo;
}

void GrafoComplementar(Grafo *grafo)
{
    int i, j;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        for(j = 0; j < grafo->NumVertices; j++)
        {
            if(grafo->Mat[i][j] == 0)
            {
                grafo->Mat[i][j] = 1;
            }
            else
            {
                grafo->Mat[i][j] = 0;
            }
        }
    }
}

void GrafoMergeRelacoes(Grafo *grafo, Grafo *grafoEmp)
{
    int i, j, k, l;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        k = grafo->Exp[i].empresa;
        for(j = 0; j < grafo->NumVertices; j++)
        {
            l = grafo->Exp[j].empresa;
            if(grafoEmp->Mat[k][l] == 1 || k == l)
            {
                InsereAresta(grafo, i, j);
                InsereAresta(grafo, j, i);
            }
        }
    }
}
