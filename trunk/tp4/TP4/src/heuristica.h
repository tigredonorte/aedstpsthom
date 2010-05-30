/* 
 * File:   heuristica.h
 * Author: thompson
 *
 * Created on 28 de Maio de 2010, 14:46
 */

#ifndef _HEURISTICA_H
#define	_HEURISTICA_H

#include "grafo.h"
#include "fila.h"

//encontrar os cliques de um grafo de maneira euristica
void calculaConfiguracaoHeuristica(Grafo *grafo, int *solucao, int *sizeOfSolucao, int *NumeroTestes, double *lucroObtido);

//metodo guloso para calcular os itens da mochila
double calculaMochilaGuloso(Experimento** exp, double capacidade, int size);

//ordena vetor por insercao
void ordenaExperimento(Experimento** exp, int size);
#endif	/* _HEURISTICA_H */

