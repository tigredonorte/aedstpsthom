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
}

int getNumVertices(Grafo *grafo)
{
    return(grafo->NumVertices);
}

PLista getPrimeiroLista(Grafo *grafo, int i)
{
    return(grafo->Adj[i].Primeiro->Prox);
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
    int maxArestas = 0;
    int i;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        int arestas = 0;
        PLista aux = grafo->Adj[i].Primeiro->Prox;
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
    grafo->NumArestas = maxArestas;
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
/* ============================================================= *
int fazTudo()
{ 
    int TEMP = 20;
    int TEMP1;
    long i;
    int V1, V2, Adj;
    Grafo grafo;
    int  NArestas = (int)(TEMP/2);
    PLista Aux;
    short FimListaAdj;

    //NumVertices: definido antes da leitura das arestas
    //NumArestas: inicializado com zero e incrementado a
    //cada chamada de InsereAresta
    int NVertices = TEMP;
    inicializaGrafo(&grafo, NArestas, TEMP);
    grafo.NumVertices = NVertices;
    FGVazio(&grafo);

    for (i = 0; i < NArestas; i++)
    {
        printf("Insere V1 -- V2 -- Peso:");
        scanf("%d%d%*[^\n]", &TEMP, &TEMP1);

        getchar();
        V1 = TEMP;
        V2 = TEMP1;
        InsereAresta(&grafo, V1, V2);   // 1 chamada g-direcionado
    }
    ImprimeGrafo(&grafo);
    scanf("%*[^\n]");
    getchar();
    printf("Insere V1 -- V2 -- Peso:");
    scanf("%d%d%*[^\n]", &V1, &V2);
    if (ExisteAresta(V1, V2, &grafo))
    {
        printf("Aresta ja existe\n");
    }
    else
    {
        grafo.NumArestas++;
        InsereAresta(&grafo, V1, V2);
    }
    ImprimeGrafo(&grafo);
    scanf("%*[^\n]");
    getchar();
    printf("Lista adjacentes de: ");
    scanf("%d*[^\n]", &TEMP);
    V1 = TEMP;
    if(!ListaAdjVazia(&V1, &grafo))
    {
        Aux = PrimeiroListaAdj(&V1, &grafo);
        FimListaAdj = 0;
        while (!FimListaAdj)
        {
            ProxAdj(&Adj, &Aux, &FimListaAdj);
            printf("%2d ", Adj);
        }
        putchar('\n');
        scanf("%*[^\n]");
        getchar();
    }
    printf("Retira aresta V1 -- V2:");
    scanf ("%d %d", &V1, &V2);
    if (ExisteAresta(V1, V2, &grafo))
    {
        grafo.NumArestas--;
        RetiraAresta(&grafo, V1, V2);
    }
    else
    {
        printf("Aresta nao existe\n");
    }

    ImprimeGrafo(&grafo);
    scanf("%*[^\n]");
    getchar();
    printf("Existe aresta V1 -- V2:");
    scanf("%d*[^\n]", &TEMP);
    scanf("%d*[^\n]", &TEMP1);


    getchar();
    V1 = TEMP;
    V2 = TEMP1;
    if (ExisteAresta(V1, V2, &grafo))
    {
        printf(" Sim\n");
    }
    else
    {
        printf(" Nao\n");
    }
    
    LiberaGrafo(&grafo);   // Imprime sujeira normalmente
    ImprimeGrafo(&grafo);
    return 0;
}
*/
