#include "fila.h"

//Esvazia fila
void esvaziaFila(Fila *fila)
{
    fila->tamanho = 0;
    fila->frente = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->frente;
    fila->frente->prox = NULL;
}

//Esvazia fila
short ehVaziaFila(Fila *fila)
{
    return(fila->frente == fila->tras);
}

//insere novo elemento na fila
void insereFila(FItem it, Fila *fila)
{
    fila->tras->prox = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->tras->prox;
    fila->tras->item = it;
    fila->tras->prox = NULL;
    fila->tamanho++;
}

void retiraFila(Fila *fila, FItem *it)
{
    if(fila->frente == fila->tras)
    {
        it = NULL;
        return;
    }
    PFila q = fila->frente;
    fila->frente = fila->frente->prox;
    (*it) = fila->frente->item;
    free(q);
}

void inicializaItem(FItem *it, int **clique, int size)
{
    it->clique = malloc(sizeof(int) * size);
    int i;
    for(i = 0; i < size; i++)
    {
        it->clique[i] = (*clique)[i];
    }
    it->size = size;
}

int getSize(Fila *fila)
{
    return(fila->tamanho);
}
