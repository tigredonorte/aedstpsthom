/*
 * File:   grafo.h
 * Author: thompson
 *
 * Created on 9 de Maio de 2010, 09:42
 */

#ifndef _GRAFO_H
#define	_GRAFO_H

#include <stdio.h>
#include <stdlib.h>

typedef struct Item_str
{
    int Vertice;
}LItem;

typedef struct Celula_str *PLista;
struct Celula_str
{
    LItem Item;
    PLista Prox;
}CLista;

typedef struct Lista_str
{
    PLista Primeiro, Ultimo;
    int cor;
}Lista;

typedef struct Grafo_str
{
    Lista *Adj;
    int NumVertices;
    int NumArestas;
}Grafo;

/*
 *  Lista
 */

//insere um item na lista
void Insere(LItem *x, Lista *lista);

//retorna verdadeiro se a lista e vazia, falso caso contrario
short Vazia(Lista lista);

//esvazia uma lista
void FLVazia(Lista *lista);


/*
 *  Grafo
 */

/*inicializa um novo grafo*/
void inicializaGrafo(Grafo *grafo, int nArestas, int nVertices);

//esvazia um grafo
void FGVazio(Grafo *grafo);

//insere uma nova aresta
void InsereAresta(Grafo *grafo, int V1, int V2);

//retorna o numero de vertices do grafo
int getNumVertices(Grafo *grafo);

//retorna o primeiro elemento da i-ezima lista
PLista getPrimeiroLista(Grafo *grafo, int i);

//altera a cor do i-ezimo elemento do grafo
void setCorVertice(Grafo *grafo, int i, int cor);

//retorna a cor do i-ezimo vertice
int getCorVertice(Grafo *grafo, int i);

//calcula o grau maximo do grafo
int calculaGrauGrafo(Grafo *grafo);

//retorna o numero de arestas de um grafo
int getNumArestas(Grafo *grafo);

//retorna o valor do vertice do item passado por parametro
int getValorVertice(PLista p);

//remove as cores do grafo
void descoloreGrafo(Grafo *grafo);

#endif	/* _GRAFO_H */
