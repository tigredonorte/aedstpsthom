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
#include "arvore.h"

/*Insere um novo elemento na arvore*/
void insereArvoreGulosa(Arvore *ar, Hash *hash, int *Size);

/*particao*/
void quickSortOrdena(itemH* vetor, int esq, int dir);

/*chamada do metodo quick sort*/
void quickSort( itemH* vetor, int N);

#endif	/* _GULOSO_H */

