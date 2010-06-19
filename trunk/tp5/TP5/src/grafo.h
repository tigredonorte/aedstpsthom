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
#include <string.h>

typedef struct Grafo_str
{
    int **Mat;
    int NumVertices;
    int numArestas;
    int grafoCompleto;
}Grafo;

/* ============================================================= */

//inicializa um novo grafo
void inicializaGrafo(Grafo *grafo, int NVertices);

//insere uma nova aresta ao vertice v1
void InsereAresta(Grafo *Grafo, int V1, int V2, int valor);

//verifica se existe uma aresta entre os dois vertices no grafo
int getAresta(Grafo *Grafo, int V1, int V2);

//imprime o grafo
void ImprimeGrafo(Grafo *Grafo);

//destroi um grafo
void LiberaGrafo(Grafo *grafo);

//retorna o numero de vertices do grafo
int getNumVertices(Grafo *grafo);

//retorna a proxima aresta vazia da pagina
int getArestaPagina(Grafo *grafo, int V1);

//retorna 0 caso o grafo nao seja completo, 1 se ele for
short grafoCompleto(Grafo *grafo);

#endif	/* _GRAFO_H */
