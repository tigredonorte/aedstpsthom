/* 
 * File:   threads.h
 * Author: thompson
 *
 * Created on 16 de Abril de 2010, 14:35
 */

#ifndef _THREADS_H
#define	_THREADS_H

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

//apontador para uma celula da fila de processos
typedef struct CFilaProc_str *PFilaProc;

//Item da fila
typedef struct FItemProc_str
{
    char **Buffer;
}FItemProc;

//Celula da fila
typedef struct CFilaProc_str
{
    FItemProc item;
    PFilaProc prox;
}CFilaProc;

//Fila propriamente dita
typedef struct FilaProc_str
{
    PFilaProc frente, tras;
    pthread_mutex_t mutex;
}FilaProc;

typedef struct t_struct_str
{
    int numTrabGerado;
    FilaProc fila;
}t_struct;

//Esvazia fila de processos
void esvaziaFilaProc(FilaProc *fila);

//insere novo elemento na fila de processos
void insereFilaProc(FItemProc it, FilaProc *fila);

//remove um item da fila
void removeFilaProc(FItemProc *it, FilaProc *fila);

//thead consumidora
void* consumidor(void * argumento);

//thread produtora
void* produtor(void * argumento);

#endif	/* _THREADS_H */
