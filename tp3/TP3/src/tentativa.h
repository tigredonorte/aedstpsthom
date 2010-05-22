/*
 * File:   tentativa.h
 * Author: thompson
 *
 * Created on 10 de Maio de 2010, 16:30
 */

#ifndef _TENTATIVA_H
#define	_TENTATIVA_H
#include "grafo.h"
#include "guloso.h"


//colore o grafo por tentativa e erro
int coloreTentativa(Grafo *grafo, long long *tentativas);

//calcula a k-ezima permutaçao do vSrc e coloca no vDst
void Factoradic(int size, long long k, int **permut);

//calcula o fatorial de n
long long fatorial(int n);

//Colore um elemento alterando a ordem de coloracao do grafo
int coloreGulosoTentativa(Grafo *grafo, int maxCores, int *ordem, long long *tentativas);

#endif	/* _TENTATIVA_H */
