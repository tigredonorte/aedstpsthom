#include "arvore.h"

/*copia a arvore fonte para o destino*/
void CopiaArvore(Arvore src, Arvore *dst)
{
    (*dst)->dir = src->dir;
    (*dst)->esq = src->esq;
    (*dst)->reg = src->reg;
}

void InicializaRegistro(Registro *x, char *palavra)
{
    x->chave = malloc(sizeof(char) * strlen(palavra));
    strcpy(x->chave, palavra);
}

int PesquisaArvore(PNodo *p, Registro *x)
{
    if(*p == NULL)
    {
        return 0;
    }
    if(strcmp(x->chave, (*p)->reg.chave) < 0)
    {
        return(PesquisaArvore(&(*p)->esq, x));
    }
    if(strcmp(x->chave, (*p)->reg.chave) < 0)
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
}

void InicializaArvore(Arvore *ar)
{
    *ar = NULL;
}


void PrintArvore(Arvore *ar)
{
    printf("\n\nImprimindo Arvore\n");
    PrintNodos(ar);
    printf("\nFim da impressao\n\n");
}

void PrintNodos(PNodo *n)
{
    if((*n) == NULL){return;}


    if((*n)->esq != NULL)
    {
        PrintNodos(&(*n)->esq);
    }

    printf("%s ", (*n)->reg.chave);
    
    if((*n)->dir != NULL)
    {
        PrintNodos(&(*n)->dir);
    }
}

void criaVetorProfundidadeArvore(Arvore *ar, char ***vString, int **vetor, int *numeroNos)
{
    int i = 0;
    int profundidade = 0;
    criaVetorProfundidade(ar, vString, vetor, &profundidade, &i, numeroNos);
}

void criaVetorProfundidade(PNodo *n, char ***vString, int **vProf, int *prof, int *i, int *numeroNos)
{
    if(*n == NULL){return;}

    (*numeroNos)++;
    (*prof)++;
    
    if((*n)->esq != NULL)
    {
        criaVetorProfundidade(&(*n)->esq,vString, vProf, prof, i, numeroNos);
    }

    (*vString)[(*i)] = malloc(sizeof(char) * strlen((*n)->reg.chave));
    strcpy((*vString)[(*i)], (*n)->reg.chave);

    (*prof)--;
    (*vProf)[(*i)] = (*prof);
    (*i)++;
    (*prof)++;
    if((*n)->dir != NULL)
    {
        criaVetorProfundidade(&(*n)->dir, vString, vProf, prof, i, numeroNos);
    }
    (*prof)--;
}
