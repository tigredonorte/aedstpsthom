/* 
 * File:   fila.h
 * Author: thompson
 *
 * Created on 21 de Março de 2010, 10:08
 */

#ifndef _FILA_H
#define	_FILA_H

#include "math.h"
#include <stdio.h>
#include <stdlib.h>
#include "file.h"
#include <time.h>

typedef double *Ponto;

/*
 *DEFINICAO DA FILA
 */

//apontador para uma celula da fila
typedef struct CFila_str *PFila;

//Item da fila
typedef struct FItem
{
    Ponto ponto;
    double distU; //guardara a distancia do ponto mais proximo em relacao a um ponto gerado
    double distW; //guardara a distancia do ponto mais proximo em relacao a outro ponto do arquivo
}FItem;

//Celula da fila
typedef struct CFila_str
{
    FItem item;
    PFila prox;
}CFila;

//Fila propriamente dita
typedef struct Fila
{
    PFila frente, tras;
}Fila;

//Esvazia fila
void esvaziaFila(Fila *fila);

//insere novo elemento na fila
void insereFila(FItem it, Fila *fila);

//insere um elemento ja criado na fila
void insertElement(Fila *fila, PFila cel1);

//inicializa um novo item
void inicializaItem(double *P, FItem *item);

//seta o valor W de uma celula
void setW(PFila cel1, double dist);

//seta o valor U de uma celula
void setU(PFila cel1, double dist);

//retorna 1 se a celula for igual ao ultimo elemento da fila
int isLastElement(Fila *fila, PFila cel1);

//copia o valor do primeiro elemento da fila para a celula
void getFirstElement(Fila *fila, PFila *cel1);

//copia o proximo elemento da celula
void getNextElement(PFila *cel1);

//Calcula distancia entre dois pontos
double calculaDistancia(Ponto P, Ponto Q, int numDim);

//recebe duas celulas e envia o valor dos seus pontos para o calculo da distancia euclidiana
double calculaDistanciaCel(PFila cel1, PFila cel2, int numDim);

//gera uma fila com tamanhoAmostras pontos
void geraPontos(Fila *fila, int tamanhoAmostras, int numDim);

//inicializa uma fila a partir de um buffer de entrada
void leEntrada(Fila *fila, int numPontos, int numDim);

//soma os termos W de uma fila
double getW(Fila *fila);

//soma os termos U de uma fila
double getU(Fila *fila);

//realiza a estatistica de hopkins conforme especificado na documentacao
double makeHopkinsStatistic(double U, double W);

//cria uma amostra a partir da fila src e devolve em filaDst
void criaAmostra(Fila *fsrc, Fila *fdst, int numPontos, int tamAmostras);

//calcula U e W para criacao de estatisticas
void calculaUW(Fila *filaAmostra, Fila *filaGerada, int numDim);

//gera as estatisticas finais do programa e salva no arquivo 'file'
void geraEstatisticas(double *NValues, int numTestes, char *file);

#endif	/* _FILA_H */

