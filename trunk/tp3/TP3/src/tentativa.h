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
int coloreTentativa(Grafo *grafo);

//calcula a k-ezima permutaçao do vSrc e coloca no vDst
void Factoradic(Grafo *grafoSrc, Grafo **grafoDst, int size, long long k);

//calcula o fatorial de n
long long fatorial(int n);

#endif	/* _TENTATIVA_H */
