/*
 * File:   interface.h
 * Author: thompson
 *
 * Created on 14 de Maio de 2010, 22:25
 */

#ifndef _INTERFACE_H
#define	_INTERFACE_H

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include "grafo.h"
#include "file.h"
#include <getopt.h>
#include <string.h>

#define BRANCH  1
#define HEURISTICA  2

//retorna o tempo atual
double getTime();

//salva e imprime a saida
void SalvaSaida(long long int configuracoes, double lucro, double tempoGasto,int nExperimentos, char **experimento, char* saida, char *fileTeste);

//le os arqumentos da entrada
void readArgs(int argc, char** argv, char **entrada, char **saida, char **fileTeste, int *algoritmo);

//cria o grafo e salva o arquivo de entrada no mesmo
void setEntradaGrafo(Grafo *grafo, char *entrada);

#endif	/* _INTERFACE_H */