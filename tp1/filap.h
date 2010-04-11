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

//apontador para uma celula da fila
typedef struct CFila_str *PFila;

//Item da fila
typedef struct FItem
{
    FilaDoc FilaIdDoc;
    char *palavra;
}FItem;

//Celula da fila
typedef struct CFila_str
{
    FItem item;
    PFila prox;
}CFila;

//Fila propriamente dita
typedef struct Fila
{
    PFila frente, tras;
    int tamanho;
}Fila;

//Esvazia fila
void esvaziaFila(Fila *fila);

//insere novo elemento na fila
void insereFila(FItem it, Fila *fila);

//pesquisa sequencialmente uma palavra
//se a palavra existir, retorna uma celula contendo todas as informaçoes da mesma
//se a palavra nao existir, retorna uma celula nula
void pesquisaPalavraFila(Fila *fila, PFila *celula, char* palavra);

/*insere uma nova palavra na fila e a referencia ao documento que a contem*/
void inserePalavraFila(Fila *fila, char* palavra, int idDoc);

/*insere uma novo documento em uma celula*/
void insereDocumentoCelula(PFila celula, int idDoc);

/*Inicializa um novo item*/
void inicializaItem(FItem *it, char* palavra, int idDoc);

#endif	/* _FILAP_H */

