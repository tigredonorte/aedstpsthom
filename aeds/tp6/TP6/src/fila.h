/* 
 * File:   filap.h
 * Author: thompson
 *
 * Created on 10 de Abril de 2010, 17:44
 */

#ifndef _FILAP_H
#define	_FILAP_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//apontador para uma celula da fila
typedef struct CFila_str *PFila;

//Item da fila
typedef struct fitem_str
{
    char *linha;
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
}Fila;

//desaloca uma fila
void destroiFila(Fila *fila);

//Esvazia fila
void esvaziaFila(Fila *fila);

//insere novo elemento na fila
void insereItemFila(FItem it, Fila *fila);

/*Inicializa um novo item*/
void inicializaItem(FItem *it, char **linha);

/*insere uma id na fila e*/
void insereFila(Fila *fila, char **linha);

//imprime os itens da fila
void imprimeFila(Fila *fila);

#endif	/* _FILAP_H */

