/* 
 * File:   tentativa.h
 * Author: thompson
 *
 * Created on 25 de Abril de 2010, 11:22
 */

#ifndef _TENTATIVA_H
#define	_TENTATIVA_H

#include <stdio.h>
#include <stdlib.h>
#include "hashaberto.h"
#include "arvore.h"

#define MAX_SIZE 8

/*insere os elementos do hash na arvore tentativa*/
void insereArvoreTentativa(Arvore *ar, Hash *hash);

//Permuta um elemento do vSrc e copia no vDst
void permutacaoN(itemH *vSrc, itemH **vDst, int size, int k);

/*calcula o fatorial de n*/
int fatorial(int n);
#endif	/* _TENTATIVA_H */

