#include "fila.h"

//Esvazia fila
void esvaziaFila(Fila *fila)
{
    fila->frente = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->frente;
    fila->frente->prox = NULL;
    fila->numItens = 0;
}

void inicializaItem(FItem *it, char *nome_fila, int numVariaveis, char **Variaveis)
{
    it->nome = malloc(sizeof(char) * strlen(nome_fila));
    strcpy(it->nome, nome_fila);
    esvaziaFila(it->Variaveis);

    //define um novo item
    FItem item;
    item.Variaveis = NULL;

    //inicializa a fila interna
    int i;
    for(i = 0; i < numVariaveis; i++)
    {
        item.nome = malloc(sizeof(char) * strlen(Variaveis[i]));
        strcpy(item.nome, Variaveis[i]);
        insereItemFila(item, it->Variaveis);
        free(item.nome);
    }
}

//insere novo elemento na fila
void insereItemFila(FItem it, Fila *fila)
{
    fila->tras->prox = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->tras->prox;
    fila->tras->item = it;
    fila->numItens++;
}

void insereFila(Fila *fila, char *nome_fila, int numVariaveis, char **Variaveis)
{
    FItem it;
    inicializaItem(&it, nome_fila, numVariaveis, Variaveis);
    insereItemFila(it, fila);
}

int getSizeofFila(Fila *f)
{
    return(f->numItens);
}

void imprimeFila(Fila *f)
{

}
