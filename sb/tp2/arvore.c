#include "arvore.h"

void InicializaRegistro(Registro *x, char *palavra, int posicao)
{
    x->chave = NULL;
    x->chave = malloc(sizeof(char) * strlen(palavra));
    strcpy(x->chave, palavra);
    x->valor = posicao;
}

int PesquisaArvore(PNodo *p, Registro *x)
{
    if(*p == NULL)
    {
        return 0;
    }
    int comp = strcmp(x->chave, (*p)->reg.chave);
    if(comp < 0)
    {
        return(PesquisaArvore(&(*p)->esq, x));
    }
    else if(comp > 0)
    {
        return(PesquisaArvore(&(*p)->dir, x));
    }
    else
    {
        *x = (*p)->reg;
        return 1;
    }
}

void InsereArvore(PNodo *p, Registro x)
{
    if((*p) == NULL)
    {
        (*p) = (PNodo)malloc(sizeof(Nodo));
        (*p)->reg = x;
        (*p)->esq = NULL;
        (*p)->dir = NULL;
        return;
    }
    int comp = strcmp(x.chave, (*p)->reg.chave);
    if(comp < 0)
    {
        InsereArvore(&(*p)->esq, x);
    }
    if(comp > 0)
    {
        InsereArvore(&(*p)->dir, x);
    }
    if(comp == 0)
    {
        printf(" Existe duas definições de um mesmo label\n O programa sera fechado!");
        exit(EXIT_FAILURE);
    }
}

void InicializaArvore(Arvore *ar)
{
    *ar = NULL;
}

void PrintArvore(Arvore *ar)
{
    printf("---------------------------------------");
    printf("\nImprimindo Tabela\n");
    printf("\nLabel \t\t\t Valor\n");
    PrintNodos(ar);
    printf("\nFim da impressao\n");
    printf("--------------------------------------\n\n\n");
}

void PrintNodos(PNodo *n)
{
    if((*n) == NULL){return;}


    if((*n)->esq != NULL)
    {
        PrintNodos(&(*n)->esq);
    }

    printf("%s \t\t\t %d\n", (*n)->reg.chave, (*n)->reg.valor);

    if((*n)->dir != NULL)
    {
        PrintNodos(&(*n)->dir);
    }
}
