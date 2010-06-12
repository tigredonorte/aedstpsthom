/* 
 * File:   pontos.h
 * Author: thompson
 *
 * Created on 11 de Junho de 2010, 16:41
 */

#ifndef _PONTOS_H
#define	_PONTOS_H

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "fila.h"

typedef double *Ponto;

typedef struct Pontos_str
{
    int numPontos;
    int numDimensoes;
    Ponto *pontos;
    Fila *PProximos;
    int *id;
}Pontos;

//inicializa a estrutura de pontos
void inicializaPontos(Pontos *pts, int numPontos, int numDimensoes);

//Calcula distancia entre dois pontos
double calculaDistancia(Ponto P, Ponto Q, int numDim);

//le os pontos contidos em um caractere
void lePontos(Pontos *pts, char *buffer, int firstLine);

//calcula a distancia entre os pontos contidos na estrutura
void calculaDistanciaPontos(Pontos *pts, double r, int firstLine);

//desaloca uma estrutura de pontos
void destroiPontos(Pontos *pts);

#endif	/* _PONTOS_H */

