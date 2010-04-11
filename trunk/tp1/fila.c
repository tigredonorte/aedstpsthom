#include "fila.h"
#include "filap.h"

//Esvazia fila
void esvaziaFilaDoc(FilaDoc *fila)
{
    fila->frente = (PFilaDoc)malloc(sizeof(CFilaDoc));
    fila->tras = fila->frente;
    fila->frente->prox = NULL;
}

//insere novo elemento na fila
void insereFilaDoc(FItemDoc it, FilaDoc *fila)
{
    fila->tras->prox = (PFilaDoc)malloc(sizeof(CFilaDoc));
    fila->tras = fila->tras->prox;
    fila->tras->item = it;
    fila->tras->prox = NULL;
}

void inicializaItemDoc(FItemDoc *it, int idDoc)
{
    it->idDoc = idDoc;
}

int pesquisaId(FilaDoc *fila, int idDoc)
{
    PFilaDoc celula = fila->frente;
    while(celula != NULL)
    {
        celula = celula->prox;
        if(celula->item.idDoc == idDoc)
        {
            return 1;
        }
    }
    return 0;
}
