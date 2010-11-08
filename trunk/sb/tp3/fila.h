/*
 * File:   filap.h
 * Author: thompson
 *
 * Created on 10 de Abril de 2010, 17:44
 */

#ifndef _FILA_H
#define _FILA_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

/*fila*/
//apontador para uma celula da fila
typedef struct CFila_str *PFila;

typedef struct fila_str *Fila2;

//Item da fila
typedef struct fitem_str
{
    char *nome;
    Fila2 Variaveis;
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
    int numItens;
    PFila frente, tras;
}Fila;

//Esvazia fila
void esvaziaFila(Fila *fila);

//insere novo elemento na fila
void insereFila(Fila *fila, char *nome_fila, int numVariaveis, char **Variaveis);

/*Inicializa um novo item*/
void inicializaItem(FItem *it, char *nome_fila, int numVariaveis, char **Variaveis);

/*insere uma id na fila e*/
void insereItemFila(FItem it, Fila *fila);

/*retorna o tamanho da fila*/
int getSizeofFila(Fila *f);

/*imprime o conteudo da fila*/
void imprimeFila(Fila *f);
#endif  /* _FILA_H */