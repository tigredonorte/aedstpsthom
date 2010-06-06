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
#include <getopt.h>
#include <string.h>
#include "file.h"
#include "fila.h"

#define TENTATIVA  1
#define HEURISTICA  2

typedef struct datain_str
{
    char* IEntrada;
    char* OSaida;
    char* TTeste;

    int CTamanho;
    int NPaginas;
    int KPontos;

    double RRaio;

    short SPolitica;
}DataIn;

typedef struct dataout_str
{
    int substituicoes;
    Fila *fila;
    double tempo;
}DataOut;

//retorna o tempo atual
double getTime();

//salva e imprime a saida
void SalvaSaida(DataIn *data, DataOut *dataOut);

//le os arqumentos da entrada
void readArgs(int argc, char** argv, DataIn *data);

#endif	/* _INTERFACE_H */
