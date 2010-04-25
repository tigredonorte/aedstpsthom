/* 
 * File:   tentativa.h
 * Author: thompson
 *
 * Created on 25 de Abril de 2010, 11:22
 */

#ifndef _TENTATIVA_H
#define	_TENTATIVA_H

#include "hashaberto.h"

typedef struct nodoTentativa *nodoT;

typedef struct item_tentativa
{
    char *chave;
}itemT;

typedef struct nodoTentativa
{
    itemT it;
    nodoT esq;
    nodoT dir;
}nodoTentativa;

typedef struct arvore_tentativa
{
    nodoT nodo; //primeiro nodo da arvore
    itemH *vetorMelhor;
    int tamanho;
}arvoreT;

/*inicializa arvore de tentativa e erro*/
void inicializaArvoreTentativa(arvoreT *ar, int tamanho);

/*Insere um novo elemento na arvore*/
void insereArvoreTentativa(arvoreT *ar, Hash *hash);

/*Encaixara o item no nodo correspondente*/
nodoT insereElementoT(nodoT n, itemT it);

#endif	/* _TENTATIVA_H */

