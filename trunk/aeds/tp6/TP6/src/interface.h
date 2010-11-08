/* 
 * File:   interface.h
 * Author: thompson
 *
 * Created on 2 de Julho de 2010, 20:51
 */

#ifndef _INTERFACE_H
#define	_INTERFACE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>
#include "fila.h"

#define FB 1
#define SA 2

typedef struct datain_str
{
    int K;
    int S;
    char *P;
}DataIn;

typedef struct dataout_str
{
    Fila fila;
}DataOut;

//le a entrada do programa
void leEntrada(DataIn *data);

//imprime a saida na tela
void SalvaSaida(DataOut *datao);

//leitura dos argumentos passados na entrada(getopt)
void readArgs(int argc, char** argv, DataIn *data);

//inicializa a saida
void inicializaSaida(DataOut *datao);

//retorna o tempo decorrido do inicio do programa
double getTime();

#endif	/* _INTERFACE_H */

