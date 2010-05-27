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

typedef struct Grafo_str
{
    int **Mat;
    int NumVertices;
    int tempo;
}Grafo;

typedef int  Apontador;

/* ============================================================= */

//inicializa um novo grafo
void inicializaGrafo(Grafo *grafo, int tempoT, int NEmp);

//esvazia um grafo
void FGVazio(Grafo *Grafo);

//insere uma nova aresta ao vertice v1
void InsereAresta(Grafo *Grafo, int *V1, int *V2);

//verifica se existe uma aresta entre os dois vertices no grafo
short ExisteAresta(Grafo *Grafo, int Vertice1, int Vertice2);

//verifica se o vertive e ligado a outro
short ListaAdjVazia(Grafo *Grafo, int *Vertice);

//retorna o primeiro item da lista de adjacencia
Apontador PrimeiroListaAdj(Grafo *Grafo, int *Vertice);

//retorna o proximo item da lista de adjacencia de um vertice
void ProxAdj(Grafo *Grafo, int *Vertice, int *Adj, Apontador *Prox, short *FimListaAdj);

//retira uma aresta do grafo
void RetiraAresta(Grafo *Grafo, int *V1, int *V2);

//imprime o grafo
void ImprimeGrafo(Grafo *Grafo);

//calcula o grafo transposto
void GrafoTransposto(Grafo *grafo, Grafo *grafoT);

//cria um novo experimento associado a um vertice do grafo
void adicionaExperimento(Grafo *grafo, int vertice, int lucro, int tempo, char *nomeExperimento);

#endif	/* _GRAFO_H */
