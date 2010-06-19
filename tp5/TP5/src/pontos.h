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
}Pagina;

//inicializa a estrutura de pontos
void inicializaPagina(Pagina *pts, int numPontos, int numDimensoes);

//desaloca uma estrutura de pontos
void destroiPagina(Pagina *pts);

//copia o ponto fonte para o destino
void copiaPagina(Pagina *src, Pagina *dst);

//Calcula distancia entre dois pontos
double calculaDistancia(Ponto P, Ponto Q, int numDim);

//le os pontos contidos em um caractere
void lePontos(Pagina *pts, char *buffer, int firstLine);

//calcula a distancia entre os pontos contidos na estrutura
void calculaDistanciaPontos(Pagina *pts, double r, int firstLine, int K, int *numK);

//calcula a distancia dentre os pontos de duas paginas
void calculaDistanciaDuasPagina(Pagina *pagSrc, Pagina *pagDst, double r, int firstLineI, int firstLineJ, int k, int *numK);

#endif	/* _PONTOS_H */

