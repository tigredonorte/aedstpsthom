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

//Esvazia fila
void esvaziaFilaDoc(FilaDoc *fila);

//insere novo elemento na fila
void insereFilaDoc(FItemDoc it, FilaDoc *fila);

//inicializa um novo item
void inicializaItemDoc(FItemDoc *it, int idDoc);

//verifica se id existe na fila, retorna 1 se existir, 0 se nao existir
int pesquisaId(FilaDoc *fila, int idDoc);

//retorna um vetor com os ids de todos os documentos presentes na fila
void recuperaFilaId(FilaDoc *fila, int *ids);
#endif	/* _FILA_H */

