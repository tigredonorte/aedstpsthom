/* 
 * File:   tentativa.h
 * Author: thompson
 *
 * Created on 27 de Maio de 2010, 22:25
 */

#ifndef _TENTATIVA_H
#define	_TENTATIVA_H

#include <stdio.h>
#include <stdlib.h>
#include "grafo.h"
#include "fila.h"
#include "heuristica.h"
#include <math.h>

//calcula os cliques e a melhor mochila
void calculaConfiguracaoTentativa(Grafo *grafo, int **solucao, int *sizeOfSolucao, long long int *configuracoes, double *lucroObtido, double *tempoGasto);

//calcula a combinacao de um vetor v( se v[i] = 1, entao o elemento do vetor deve ser considerado, se nao, nao)
void proxCombinacao(int **v, int size);

#endif	/* _TENTATIVA_H */

