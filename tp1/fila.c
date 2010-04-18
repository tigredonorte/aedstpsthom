#include "fila.h"
#include "filap.h"
#include <stdio.h>

//verifica se a fila e vazia, retorna 0 se nao for vazia, != 0 se for vazia
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
    pthread_mutex_init (&filaD->mutex, NULL); //inicializa o mutex da fila
}

//insere novo elemento na fila com id ordenado -- O(numDocs)
void insereFilaDoc(FItemDoc it, FilaDoc *filaD)
{
    //bloqueia a thread
    pthread_mutex_lock (&filaD->mutex);
    if(!eVaziaFila(filaD))
    {
        PFilaDoc celula, celulaAnt;
        celula = filaD->frente->prox;
        celulaAnt = celula;
        int encaixou = 0;

        //varrera a fila inteira, enquanto nao chegar a ultima celula, ou enquanto
        //o item a ser encaixado nao for <= a celula
        while(celula->prox != NULL && !encaixou)
        {
            //se item e maior do que o item da fila, pega o proximo da fila para comparar
            if(it.idDoc > celula->item.idDoc)
            {
                celulaAnt = celula;
                celula = celula->prox;
            }
            //se for menor ou igual a celula sera encaixada ou ja existe
            else
            {
                encaixou = 1;
                //se for menor aloca uma nova celula e encaixa na fila
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
        //se for igual incrementa o numero de insercoes da celula
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
    // se a fila e vazia, encaixa na primeira posicao
    else
    {
        it.numInsercoes++;
        filaD->tras->prox = (PFilaDoc)malloc(sizeof(CFilaDoc));
        filaD->tras = filaD->tras->prox;
        filaD->tras->item = it;
        filaD->tras->prox = NULL;
    }

    //desbloqueia a thread
    pthread_mutex_unlock (&filaD->mutex);
}

//inicializa um novo item da uma celula
void inicializaItemDoc(FItemDoc *it, int idDoc)
{
    it->idDoc = idDoc;
    it->numInsercoes = 0;
}

int pesquisaId(FilaDoc *fila, int idDoc)
{
    PFilaDoc celula;

    //se a fila existe
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
    //se nao existir sai do programa para nao dar seg fault
    //mas com a mensagem de erro da localizacao no codigo
    printf("Falha de memoria\n"
            "Arquivo: Fila.c\n"
            "Funcao: PesquisaID\n"
            "Erro: Fila.frente nao foi alocada -- Falha na alocacao\n"
            "O Programa sera encerrado\n");
    exit(EXIT_FAILURE);
    return -1; //anti warning
}

//retorna o id da celula passada por parametro
void recuperaIdCelulaDoc(PFilaDoc celula, int *id)
{
    *id = celula->item.idDoc;
}

//altera o conteudo da celula para que esta seja igual a proxima a ela
void proximaCelulaDoc(PFilaDoc *celula)
{
    if(*celula != NULL)
    {
        *celula = (*celula)->prox;
    }
}

//retorna o numero de insercoes da celula passada por parametro
int getNumInsercoes(PFilaDoc celula)
{
    return(celula->item.numInsercoes);
}

//salva na celula passada por parametro o primeiro elemento da fila de documentos
void primeiroElementoFilaDoc(FilaDoc *filaDoc, PFilaDoc *celulaDoc)
{
    *celulaDoc = filaDoc->frente;
}
