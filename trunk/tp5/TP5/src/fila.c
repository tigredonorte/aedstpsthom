#include "fila.h"

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

void inicializaItem(FItem *it, int id)
{
    it->id = id;
}

void insereFila(Fila *fila, int id)
{
    FItem it;
    inicializaItem(&it, id);
    insereItemFila(it, fila);
}

int getId(Fila *fila)
{
    return(fila->id);
}

int getIdItem(PFila aux)
{
    return(aux->item.id);
}

void getProxFila(Fila *fila, PFila aux)
{
    if(aux == NULL)
    {
        aux = fila->frente->prox;
        return;
    }

    aux = aux->prox;
}
