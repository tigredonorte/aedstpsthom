#include "grafo.h"

/*--Entram aqui os operadores do Programa 2.4--*/
void FLVazia(Lista *lista)
{
    lista->Primeiro = (PLista)malloc(sizeof(CLista));
    lista->Ultimo = lista->Primeiro;
    lista->Primeiro->Prox = NULL;
}

short Vazia(Lista lista)
{
    return (lista.Primeiro == lista.Ultimo);
}

void Insere(LItem *x, Lista *lista)
{ /*-- Insere depois do ultimo item da lista --*/
    lista->Ultimo->Prox = (PLista)malloc(sizeof(CLista));
    lista->Ultimo = lista->Ultimo->Prox;
    lista->Ultimo->Item = *x;
    lista->Ultimo->Prox = NULL;
}

void inicializaGrafo(Grafo *grafo, int nArestas, int nVertices)
{
    grafo->NumVertices = nVertices;
    grafo->NumArestas = nArestas;
    grafo->Adj = calloc(grafo->NumVertices, sizeof(Lista));
    grafo->NumCores = 0;
    grafo->maxArestas = 0;
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

void LiberaGrafo(Grafo *Grafo)
{
    PLista AuxAnterior, Aux;
    int i;
    for (i = 0; i < Grafo->NumVertices; i++)
    {
        Aux = Grafo->Adj[i].Primeiro->Prox;
        free(Grafo->Adj[i].Primeiro);   /*Libera celula cabeca*/
        Grafo->Adj[i].Primeiro=NULL;
        while (Aux != NULL)
        {
            AuxAnterior = Aux;
            Aux = Aux->Prox;
            free(AuxAnterior);
        }
    }
    Grafo->NumVertices = 0;
}


void ImprimeGrafo(Grafo *Grafo)
{
    int i;
    PLista Aux;
    for (i = 0; i < Grafo->NumVertices; i++)
    {
        if (!Vazia(Grafo->Adj[i]))
        {
            printf("Vertice %d:", i+1);
            printf(" cor %d: \n", Grafo->Adj[i].cor);
            Aux = Grafo->Adj[i].Primeiro->Prox;
            while (Aux != NULL)
            {
                printf("%d ", Aux->Item.Vertice+1);
                Aux = Aux->Prox;
            }
        }
        putchar('\n');
    }
    free(Aux);
}

void ImprimeLista(Lista Lista)
{
    PLista Aux;
    Aux = Lista.Primeiro->Prox;
    while (Aux != NULL)
    {
        printf("%d\n", Aux->Item.Vertice+1);
        Aux = Aux->Prox;
        printf("\n");
    }
    free(Aux);
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
    if(grafo->NumCores < cor)
    {
        grafo->NumCores = cor;
    }
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
    grafo->maxArestas = maxArestas;
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

//copia o grafo fonte no grafo destino
void copiaGrafo(Grafo *grafoSrc, Grafo *grafoDst)
{
    int i;
    for(i = 0; i < grafoSrc->NumVertices; i++)
    {
        grafoDst->Adj[i] = grafoSrc->Adj[i];
    }
}
