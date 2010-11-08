#include "fila.h"

void destroiFila(Fila *fila)
{
    PFila q = fila->frente;
    PFila aux = fila->frente;
    while(aux != NULL)
    {
        aux = q->prox;
        free(q);
        q = aux;
    }
}

//Esvazia fila
void esvaziaFila(Fila *fila)
{
    fila->tamanho = 0;
    fila->frente = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->frente;
    fila->frente->prox = NULL;
}

//insere novo elemento na fila
void insereItemFila(FItem it, Fila *fila)
{
    fila->tras->prox = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->tras->prox;
    fila->tras->item = it;
    fila->tras->prox = NULL;
    fila->tamanho++;
}

void inicializaItem(FItem *it, char **linha)
{
    it->linha = malloc(sizeof(char) * strlen((*linha)));
    strcpy(it->linha, (*linha));
}

void insereFila(Fila *fila, char **linha)
{
    FItem it;
    inicializaItem(&it, linha);
    insereItemFila(it, fila);
}

void imprimeFila(Fila *fila)
{
    PFila aux;
    aux = fila->frente->prox;
    while(aux != NULL)
    {
        fprintf(stdout, "%s", aux->item.linha);
        aux = aux->prox;
    }
}
