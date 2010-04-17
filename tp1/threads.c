#include "threads.h"

//Esvazia fila de processos
void esvaziaFilaProc(FilaProc *fila)
{
    fila->frente = (PFilaProc)malloc(sizeof(CFilaProc));
    fila->tras = fila->frente;
    fila->frente->prox = NULL;
    if (fila)
    {
        pthread_mutex_init (&fila->mutex, NULL);
    }
}

//insere novo elemento na fila de processos
void insereFilaProc(FItemProc it, FilaProc *fila)
{
    pthread_mutex_lock (&fila->mutex);

    fila->tras->prox = (PFilaProc)malloc(sizeof(CFilaProc));
    fila->tras = fila->tras->prox;
    fila->tras->item = it;
    fila->tras->prox = NULL;

    pthread_mutex_unlock (&fila->mutex);
}

//remove um item da fila
void removeFilaProc(FItemProc *it, FilaProc *fila)
{
    PFilaProc celula;
    if(fila->frente == fila->tras)
    {
        return;
    }

    pthread_mutex_lock (&fila->mutex);

    celula = fila->frente;
    fila->frente = fila->frente->prox;
    *it = fila->frente->item;

    pthread_mutex_unlock (&fila->mutex);
    
    free(celula);
}

void* consumidor(void * argumento)
{
    t_struct estrutura_thread;
    while(estrutura_thread.numTrabGerado--)
    {

    }
    return (NULL);
}

void* produtor(void * argumento)
{
    return (NULL);
}
