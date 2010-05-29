/*
 * File:   filap.h
 * Author: thompson
 *
 * Created on 10 de Abril de 2010, 17:44
 */

#ifndef _FILAP_H
#define	_FILAP_H

#include "fila.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

//apontador para uma celula da fila
typedef struct CFila_str *PFila;

//Item da fila
typedef struct FItem_str
{
    int *clique;
    int size;
}FItem;

//Celula da fila
typedef struct CFila_str
{
    FItem item;
    PFila prox;
}CFila;

//Fila propriamente dita
typedef struct Fila_str
{
    PFila frente, tras;
    int tamanho;
}Fila;

//Esvazia fila
void esvaziaFila(Fila *fila);

//Esvazia fila
short ehVaziaFila(Fila *fila);

//insere novo elemento na fila
void insereFila(FItem it, Fila *fila);

//remove um item da fila
void retiraFila(Fila *fila, FItem *it);

//inicializa um novo item
void inicializaItem(FItem *it, int **clique, int size);

//retorna o tamanho da fila
int getSize(Fila *fila);

#endif	/* _FILAP_H */

