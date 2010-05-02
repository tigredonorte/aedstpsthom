/* 
 * File:   dinamica.h
 * Author: thompson
 *
 * Created on 25 de Abril de 2010, 11:22
 */

#ifndef _DINAMICA_H
#define	_DINAMICA_H

#include "hashaberto.h"
#include "arvore.h"


/*
 *  FUNCOES DA PILHA (PARA PESQUISA EM LARGURA)
 */

typedef struct CPilha_str *PPilha;

typedef struct ItemP_str
{
    int x;
    int y;
}ItemP;

typedef struct CPilha_str
{
    ItemP item;
    PPilha prox;
}CPilha;

typedef struct
{
    PPilha fundo, topo;
    int tamanho;
}Pilha;

//esvazia uma pilha
void EsvaziaPilha(Pilha *pilha);

//insere novo elemento
void Empilha(ItemP item, Pilha *pilha);

//retira um elemento da pilha
void Desempilha(ItemP *item, Pilha *pilha);

//retorna 1 se pilha vazia, 0 caso contrario
int ehVaziaPilha(Pilha *pilha);

//cria um item da pilha
void criaItem(ItemP *item, int X, int Y);



/*
 *  FUNCOES DA PROGRAMAÇAO DINAMICA
 */

typedef struct dinamica_stc
{
    char *pai;
    double pop;
    int esqX;
    int esqY;
    int dirX;
    int dirY;
}Dinamica;

void insereArvoreDinamica(Arvore *ar, Hash *hash);

//calcula a menor arvore
double calculaMenor(Dinamica ***A, int i, int j, int size);

/*calcula o vetor W (soma dos elementos presentes na arvore atual*/
void CalculaW(double ***W, int size);

/*calcula a melhor arvore*/
void CalculaA(Dinamica ***A, int size);

//copia um elemento src para o dst
void CopiaElemento(Dinamica *src, Dinamica *dst);

//salva a melhor arvore existente na matriz src no vetor dst
void getMelhorArvore(char ***VMelhor, Dinamica **A, int size);

#endif	/* _DINAMICA_H */

