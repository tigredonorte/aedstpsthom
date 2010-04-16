#include "fila.h"
#include "filap.h"
#include <stdio.h>

int eVaziaFila(FilaDoc *filaD)
{
    return(filaD->frente == filaD->tras);
}
//Esvazia fila
void esvaziaFilaDoc(FilaDoc *filaD)
{
    filaD->frente = (PFilaDoc)malloc(sizeof(CFilaDoc));
    filaD->tras = filaD->frente;
    filaD->frente->prox = NULL;
}

//insere novo elemento na fila com id ordenado -- O(numDocs)
void insereFilaDoc(FItemDoc it, FilaDoc *filaD)
{
    if(!eVaziaFila(filaD))
    {
        PFilaDoc celula, celulaAnt;
        celula = filaD->frente->prox;
        celulaAnt = celula;
        int encaixou = 0;
        while(celula->prox != NULL && !encaixou)
        {
            if(it.idDoc > celula->item.idDoc)
            {
                celulaAnt = celula;
                celula = celula->prox;
            }
            else
            {
                encaixou = 1;
                if(it.idDoc < celula->item.idDoc)
                {
                    it.numInsercoes++;
                    PFilaDoc novaCelula = (PFilaDoc)malloc(sizeof(CFilaDoc));
                    novaCelula->item = it;
                    novaCelula->prox = celulaAnt->prox;
                    celulaAnt->prox = novaCelula;
                }
                 //se for igual nao encaixa e sai do loop
            }
        }
        if(it.idDoc == celula->item.idDoc)
        {
            celula->item.numInsercoes++;
        }
        else
        {
            //se ainda nao encaixou, coloca a nova celula na ultima posicao da fila
            if(!encaixou)
            {
                it.numInsercoes++;
                filaD->tras->prox = (PFilaDoc)malloc(sizeof(CFilaDoc));
                filaD->tras = filaD->tras->prox;
                filaD->tras->item = it;
                filaD->tras->prox = NULL;
            }
        }
    }
    else
    {
        it.numInsercoes++;
        filaD->tras->prox = (PFilaDoc)malloc(sizeof(CFilaDoc));
        filaD->tras = filaD->tras->prox;
        filaD->tras->item = it;
        filaD->tras->prox = NULL;
    }
}

void inicializaItemDoc(FItemDoc *it, int idDoc)
{
    it->idDoc = idDoc;
    it->numInsercoes = 0;
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

void recuperaIdCelulaDoc(PFilaDoc celula, int *id)
{
    *id = celula->item.idDoc;
}

void proximaCelulaDoc(PFilaDoc *celula)
{
    if(*celula != NULL)
    {
        *celula = (*celula)->prox;
    }
}

int getNumInsercoes(PFilaDoc celula)
{
    return(celula->item.numInsercoes);
}

void primeiroElementoFilaDoc(FilaDoc *filaDoc, PFilaDoc *celulaDoc)
{
    *celulaDoc = filaDoc->frente;
}
