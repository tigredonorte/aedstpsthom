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

void bronKerbosch(int** adjMatrix, int size, Fila *fila);

void encontraValorTentativa(Grafo *grafo);

void encontraCliquesTentativa(int **adjMatrix, int* oldMD, int oldTestedSize, int oldCandidateSize, int *actualMD, int *best, int *actualMDSize, int *bestSize, Fila *fila);

void addClique(int **clique, int size, Fila *fila);
#endif	/* _TENTATIVA_H */

