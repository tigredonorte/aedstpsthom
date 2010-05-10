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

typedef int ValorVertice;

typedef struct Item_str
{
    ValorVertice Vertice;
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
}Lista;

typedef struct Grafo_str
{
    Lista *Adj;
    ValorVertice NumVertices;
    short NumArestas;
    int MaxNumVertices;
}Grafo;

/*
 *  Lista
 */

//imprime uma lista encadeada
void ImprimeLista(Lista lista);

//retira um item da lista
void RetiraLista(PLista p, Lista *lista, LItem *Item);

//insere um item na lista
void Insere(LItem *x, Lista *lista);

//retorna verdadeiro se a lista e vazia, falso caso contrario
short Vazia(Lista lista);

//esvazia uma lista
void FLVazia(Lista *lista);


/*
 *  Grafo
 */

//funcao de exemplo
int fazTudo();

//faz o grafo transposto
void TranspostoGrafo(Grafo *grafo, Grafo *grafoT);

//imprime o grafo
void ImprimeGrafo(Grafo *grafo);

//esvazia um grafo
void LiberaGrafo(Grafo *grafo);

//retira uma aresta do grafo
void RetiraAresta(Grafo *Grafo, ValorVertice V1, ValorVertice V2);

//retorna o proximo vertice adjacente
void ProxAdj(ValorVertice *Adj, PLista *Prox, short *FimListaAdj);

//retorna o primeiro da lista de adjacencia
PLista PrimeiroListaAdj(ValorVertice *Vertice, Grafo *grafo);

//retorna 1 se a lista de adjacencia e vazia
short  ListaAdjVazia(ValorVertice *Vertice, Grafo *grafo);

//retorna 1 caso exista uma aresta
short ExisteAresta(ValorVertice Vertice1, ValorVertice Vertice2, Grafo *grafo);

//insere uma nova aresta
void InsereAresta(Grafo *grafo, int V1, int V2);

//esvazia um grafo
void FGVazio(Grafo *grafo);

/*inicializa um novo grafo*/
void inicializaGrafo(Grafo *grafo, int nArestas, int nVertices);

#endif	/* _GRAFO_H */
