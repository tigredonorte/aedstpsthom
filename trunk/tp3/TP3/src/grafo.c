#include "grafo.h"

void Insere(LItem *x, Lista *lista)
{ /*-- Insere depois do ultimo item da lista --*/
    lista->Ultimo->Prox = (PLista)malloc(sizeof(CLista));
    lista->Ultimo = lista->Ultimo->Prox;
    lista->Ultimo->Item = *x;
    lista->Ultimo->Prox = NULL;
}

short Vazia(Lista lista)
{
    return (lista.Primeiro == lista.Ultimo);
}

/*--Entram aqui os operadores do Programa 2.4--*/
void FLVazia(Lista *lista)
{
    lista->Primeiro = (PLista)malloc(sizeof(CLista));
    lista->Ultimo = lista->Primeiro;
    lista->Primeiro->Prox = NULL;
    lista->cor = 0;
}

void inicializaGrafo(Grafo *grafo, int nArestas, int nVertices)
{
    grafo->NumVertices = nVertices;
    grafo->NumArestas = nArestas;
    grafo->Adj = calloc(grafo->NumVertices, sizeof(Lista));
    FGVazio(grafo);
}

void FGVazio(Grafo *grafo)
{
    long i;
    for (i = 0; i < grafo->NumVertices; i++)
    {
        FLVazia(&grafo->Adj[i]);
        grafo->Adj[i].cor = 0;
    }
}

void InsereAresta(Grafo *grafo, int V1, int V2)
{
    LItem x;
    x.Vertice = V2;
    Insere(&x, &grafo->Adj[V1]);
}

int getNumVertices(Grafo *grafo)
{
    return(grafo->NumVertices);
}

PLista getPrimeiroLista(Grafo *grafo, int i)
{
    if(!Vazia(grafo->Adj[i]))
    {
        return(grafo->Adj[i].Primeiro->Prox);
    }
    return NULL;
}

void setCorVertice(Grafo *grafo, int i, int cor)
{
    grafo->Adj[i].cor = cor;
}

int getCorVertice(Grafo *grafo, int i)
{
    return(grafo->Adj[i].cor);
}

int calculaGrauGrafo(Grafo *grafo)
{
    int arestas;
    int maxArestas = 0;
    int i;
    PLista aux;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        arestas = 0;
        aux = grafo->Adj[i].Primeiro->Prox;
        while(aux != NULL)
        {
            arestas++;
            aux = aux->Prox;
        }
        if(arestas > maxArestas)
        {
            maxArestas = arestas;
        }
    }
    free(aux);
    return(maxArestas);
}

int getNumArestas(Grafo *grafo)
{
    return(grafo->NumArestas);
}

int getValorVertice(PLista p)
{
    return(p->Item.Vertice);
}

void descoloreGrafo(Grafo *grafo)
{
    int i;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        grafo->Adj[i].cor = 0;
    }
}
