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
typedef struct fitem_str
{
    int id;
}FItem;

//Celula da fila
typedef struct CFila_str
{
    FItem item;
    PFila prox;
}CFila;

//Fila propriamente dita
typedef struct fila_str
{
    PFila frente, tras;
    int tamanho;
    int id;
}Fila;

//desaloca uma fila
void destroiFila(Fila *fila);

//Esvazia fila
void esvaziaFila(Fila *fila);

//insere novo elemento na fila
void insereItemFila(FItem it, Fila *fila);

/*Inicializa um novo item*/
void inicializaItem(FItem *it, int id);

/*insere uma id na fila e*/
void insereFila(Fila *fila, int id);

/*retorna o proximo elemento de aux, caso aux seja nulo, retorna o primeiro elemento,
 caso aux seja o ultimo elemento retorna null*/
void getProxFila(Fila *fila, PFila aux);

//retorna o identificador da fila
int getId(Fila *fila);

//retorna o id de um item da fila
int getIdItem(PFila aux);

#endif	/* _FILAP_H */

