/* 
 * File:   fila.h
 * Author: thompson
 *
 * Created on 10 de Abril de 2010, 19:50
 */

#ifndef _FILA_H
#define	_FILA_H

#include <stdio.h>
#include <stdlib.h>

//apontador para uma celula da fila
typedef struct CFilaDoc_str *PFilaDoc;

//Item da fila
typedef struct FItemDoc
{
    int idDoc;
    int numInsercoes;
}FItemDoc;

//Celula da fila
typedef struct CFilaDoc_str
{
    FItemDoc item;
    PFilaDoc prox;
}CFilaDoc;

//Fila propriamente dita
typedef struct FilaDoc_str
{
    PFilaDoc frente, tras;
}FilaDoc;

//verifica se a fila eh vazia, retorna 1 caso verdadeiro
int eVaziaFila(FilaDoc *filaD);

//Esvazia fila
void esvaziaFilaDoc(FilaDoc *fila);

//insere novo elemento na fila
void insereFilaDoc(FItemDoc it, FilaDoc *fila);

//inicializa um novo item
void inicializaItemDoc(FItemDoc *it, int idDoc);

//verifica se id existe na fila, retorna 1 se existir, 0 se nao existir
int pesquisaId(FilaDoc *fila, int idDoc);

//retorna o id de uma celula
void recuperaIdCelulaDoc(PFilaDoc celula, int *id);

//retorna um ponteiro para a proxima celula da fila
void proximaCelulaDoc(PFilaDoc *celula);

//recupera o numero de tentativas de insercao de um documento
int getNumInsercoes(PFilaDoc celula);

//retorna a celula cabeca da fila
void primeiroElementoFilaDoc(FilaDoc *filaDoc, PFilaDoc *celulaDoc);

#endif	/* _FILA_H */

