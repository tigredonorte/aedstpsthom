#include "fila.h"
#include <stdio.h>

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
    PFilaDoc celula;
    if(fila->frente != NULL)
    {
        celula = fila->frente;

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
    printf("Falha de memoria\n"
            "Arquivo: Fila.c\n"
            "Funcao: PesquisaID\n"
            "Erro: Fila.frente nao foi alocada -- Falha na alocacao\n"
            "O Programa sera encerrado\n");
    exit(EXIT_FAILURE);
    return -1; //anti warning
}

void recuperaFilaId(FilaDoc *fila, int *ids)
{
    PFilaDoc celula;
    celula = fila->frente;
    int i = 0;
    while(celula->prox != NULL)
    {
        celula = celula->prox;
        ids[i] = celula->item.idDoc;
        i++;
    }
}
