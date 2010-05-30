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

typedef struct experimento_str
{
    int experimento;
    int empresa;
    double lucro;
    double tempo;
    double lucroTempo;
}Experimento;

typedef struct Grafo_str
{
    int **Mat;
    int NumVertices;
    double tempo;
    Experimento *Exp;
}Grafo;

typedef int  Apontador;

/* ============================================================= */

//inicializa um novo grafo
void inicializaGrafo(Grafo *grafo, double tempo, int NVertices);

//esvazia um grafo
void FGVazio(Grafo *Grafo);

//insere uma nova aresta ao vertice v1
void InsereAresta(Grafo *Grafo, int V1, int V2);

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
void insereExperimento(Grafo *grafo, int experimento, int empresa, double lucro, double tempo);

//destroi um grafo
void LiberaGrafo(Grafo *grafo);

//calcula o complementar do grafo
void GrafoComplementar(Grafo *grafo);

//se uma empresa se relaciona com a outra, os experimentos destas empresas tambem se relacionam
void GrafoMergeRelacoes(Grafo *grafo, Grafo *grafoEmp);

//retorna o numero de vertices do grafo
int getNumVertices(Grafo *grafo);

double getTempo(Grafo *grafo);

//retorna o tempo gasto por um experimento
double ExperimentoGetTime(Experimento *exp);

//retorna o lucro esperado de um experimento
double ExperimentoGetLucro(Experimento *exp);

//retorna o custo beneficio de um experimento
double ExperimentoGetLucroTime(Experimento *exp);

//copia para o vetor exp os experimentos do grafo
void ExperimentosCopia(Grafo *grafo, Experimento *exp);

//retorna o identificador do experimento
int ExperimentoGetId(Experimento *exp);

#endif	/* _GRAFO_H */
