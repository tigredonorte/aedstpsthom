/* 
 * File:   guloso.h
 * Author: thompson
 *
 * Created on 24 de Abril de 2010, 09:13
 */

#ifndef _GULOSO_H
#define	_GULOSO_H

#include <stdio.h>
#include <stdlib.h>
#include "hashaberto.h"

/*
 * Arvore propriamente dita
 */
typedef struct nodoGuloso *nodoG;

typedef struct item_guloso
{
    char *chave;
}itemG;

typedef struct nodoGuloso
{
    itemG it;
    nodoG esq;
    nodoG dir;
}nodoGuloso;

typedef struct arvore_gulosa
{
    nodoG nodo; //primeiro nodo da arvore
}arvoreG;

/*Insere um novo elemento na arvore*/
void insereArvoreGulosa(arvoreG *ar, itemG it);

/*Encaixara o item no nodo correspondente*/
nodoG insereElementoG(nodoG n, itemG it);

#endif	/* _GULOSO_H */

