#include "fila.h"

//Esvazia fila
void esvaziaFilaDoc(FilaDoc *filaD)
{
    filaD->frente = (PFilaDoc)malloc(sizeof(CFilaDoc));
    filaD->tras = filaD->frente;
    filaD->frente->prox = NULL;
}

//insere novo elemento na fila
void insereFilaDoc(FItemDoc it, FilaDoc *filaD)
{
    filaD->tras->prox = (PFilaDoc)malloc(sizeof(CFilaDoc));
    filaD->tras = filaD->tras->prox;
    filaD->tras->item = it;
    filaD->tras->prox = NULL;
}

void inicializaItemDoc(FItemDoc *it, int idDoc)
{
    it->idDoc = idDoc;
}

int pesquisaId(FilaDoc *fila, int idDoc)
{
    PFilaDoc celula = fila->frente;
    while(celula->prox != NULL)
    {
        celula = celula->prox;
        if(celula->item.idDoc == idDoc)
        {
            return 1;
        }
    }
    return 0;
}
