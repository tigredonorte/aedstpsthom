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
#include "data.h"
#include "gen_data.h"
#include "filap.h"

#define TERMS_SIZE 100

//apontador para uma celula da fila de processos
typedef struct CFilaProc_str *PFilaProc;

//Item da fila
typedef struct FItemProc_str
{
    termsT *buffer;
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
    PFilaProc frente, tras; //guarda o primeiro e o ultimo elemento da fila
    pthread_mutex_t mutex;  //mutex da fila
    pthread_cond_t generate; //inserindo no buffer
    pthread_cond_t stop; //buffer ocioso
    int empty;       //fila ficou vazia
    int full;        //fila possui elementos
    long max_size;
    int size;
}FilaProc;

typedef struct t_struct_str
{
    int numTrabGerado;
    char *outFile;
    char *statisticFile;
    char** terms;
    int produzindo;
    FilaProc fila;
    DicionarioH *dic;
}t_struct;

//inicializa uma nova estrutura
void inicializaTStruct(t_struct *estrutura, char* outfile, char* statisticFile, char* vocabularioFile, int numTrabGerado, int tamBuffer, DicionarioH *dic);

//inicializa um novo item
void inicializaItemProc(FItemProc *it, termsT *buffer);

//Esvazia fila de processos
void esvaziaFilaProc(FilaProc *fila, int tamBuffer);

//insere novo elemento na fila de processos
void insereFilaProc(FItemProc it, FilaProc *fila);

//remove um item da fila
void removeFilaProc(FItemProc *it, FilaProc *fila);

//thead consumidora
void* consumidor(void * argumento);

//thread produtora
void* produtor(void * argumento);

#endif	/* _THREADS_H */
