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

/*--Obs.: item a ser retirado e o seguinte ao apontado por p--*/
void Retira(PLista p, Lista *lista, LItem *Item)
{
    PLista q;
    if (Vazia(*lista) || p == NULL || p->Prox == NULL)
    {
        printf("Erro: Lista vazia ou posicao nao existe\n");
        return;
    }
    q = p->Prox;
    *Item = q->Item;
    p->Prox = q->Prox;

    if (p->Prox == NULL)
    {
        lista->Ultimo = p;
    }
    free(q);
}

void inicializaGrafo(Grafo *grafo, int nArestas, int nVertices)
{
    grafo->NumVertices = nVertices + 1;
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
    }
}

void InsereAresta(Grafo *grafo, int V1, int V2)
{
    LItem x;
    x.Vertice = V2;
    Insere(&x, &grafo->Adj[V1-1]);
}

short ExisteAresta(ValorVertice Vertice1, ValorVertice Vertice2, Grafo *Grafo)
{
    PLista Aux;
    short  EncontrouAresta = 0;
    Aux = Grafo->Adj[Vertice1].Primeiro->Prox;
    while (Aux != NULL && EncontrouAresta == 0)
    {
        if (Vertice2 == Aux->Item.Vertice)
        {
            EncontrouAresta = 1;
        }
        Aux = Aux->Prox;
    }
    return EncontrouAresta;
}

/*-- Operadores para obter a lista de adjacentes --*/
short  ListaAdjVazia(ValorVertice *Vertice, Grafo *Grafo)
{
    return(Grafo->Adj[*Vertice].Primeiro == Grafo->Adj[*Vertice].Ultimo);
}

PLista PrimeiroListaAdj(ValorVertice *Vertice, Grafo *Grafo)
{
    return(Grafo->Adj[*Vertice].Primeiro->Prox);
}

 /* --Retorna Adj e Peso do Item apontado por Prox--*/
void ProxAdj(ValorVertice *Adj, PLista *Prox, short *FimListaAdj)
{
    *Adj = (*Prox)->Item.Vertice;
    *Prox = (*Prox)->Prox;
    if (*Prox == NULL)
    {
        *FimListaAdj = 1;
    }
}

void RetiraAresta(Grafo *Grafo, ValorVertice V1, ValorVertice V2)
{
    PLista AuxAnterior, Aux;
    short EncontrouAresta = 0;
    LItem x;
    AuxAnterior = Grafo->Adj[V1].Primeiro;
    Aux = Grafo->Adj[V1].Primeiro->Prox;
    
    while (Aux != NULL && EncontrouAresta == 0)
    {
        if (V2 == Aux->Item.Vertice)
        {
            Retira(AuxAnterior, &Grafo->Adj[V1], &x);
            Grafo->NumArestas--;
            EncontrouAresta = 1;
        }
        AuxAnterior = Aux;
        Aux = Aux->Prox;
    }
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
        printf("Vertice%2d:", i);
        if (!Vazia(Grafo->Adj[i]))
        {
            Aux = Grafo->Adj[i].Primeiro->Prox;
            while (Aux != NULL)
            {
                printf("%3d ", Aux->Item.Vertice);
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
        printf("%3d ", Aux->Item.Vertice);
        Aux = Aux->Prox;
    }
}

void GrafoTransposto(Grafo *grafo, Grafo *GrafoT)
{
    ValorVertice v, Adj;
    PLista Aux;
    short FimListaAdj;
    
    GrafoT->NumVertices = grafo->NumVertices;
    GrafoT->NumArestas = grafo->NumArestas;
    FGVazio(GrafoT);
    for (v = 0; v <= grafo->NumVertices - 1; v++)
    {
        if (!ListaAdjVazia(&v, grafo))
        {
            Aux = PrimeiroListaAdj(&v, grafo);
            FimListaAdj = 0;
            while (!FimListaAdj)
            {
                ProxAdj(&Adj, &Aux, &FimListaAdj);
                InsereAresta(GrafoT, Adj, v);
            }
        }
    }
}

/* ============================================================= */
int fazTudo()
{ /*-- Programa principal --*/
    int TEMP = 20;
    int TEMP1;
    long i;
    ValorVertice V1, V2, Adj;
    Grafo grafo, GrafoT;
    int  NArestas = (int)(TEMP/2);
    PLista Aux;
    short FimListaAdj;

    /* -- NumVertices: definido antes da leitura das arestas --*/
    /* -- NumArestas: inicializado com zero e incrementado a --*/
    /* -- cada chamada de InsereAresta                       --*/
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
        InsereAresta(&grafo, V1, V2);   /* 1 chamada g-direcionado    */
    }
    ImprimeGrafo(&grafo);
    scanf("%*[^\n]");
    getchar();
    printf("Grafo transposto:\n");
    GrafoTransposto(&grafo, &GrafoT);
    ImprimeGrafo(&GrafoT);
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
        /*RetiraAresta(V2, V1, Peso, Grafo);*/
    }
    else
    {
        printf("Aresta nao existe\n");
    }

    ImprimeGrafo(&grafo);
    scanf("%*[^\n]");
    getchar();
    printf("Existe aresta V1 -- V2:");
    /* scanf("%d%d%*[^\n]", &TEMP, &TEMP1); */
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
    
    LiberaGrafo(&grafo);   /* Imprime sujeira normalmente */
    ImprimeGrafo(&grafo);
    return 0;
}

