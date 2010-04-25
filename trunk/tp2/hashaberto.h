/* 
 * File:   hashaberto.h
 * Author: thompson
 *
 * Created on 24 de Abril de 2010, 23:21
 */

#ifndef _HASHABERTO_H
#define	_HASHABERTO_H

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#define RETIRADO -1
#define VAZIO 1
#define CHEIO 0
#define NAO_ENCONTRADO -2

typedef struct itemHash
{
    char *chave;
    int status;
    int numOcorrencias;
    double popularidade;    //popularidade = numero total de ocorrencias/ numero total de termos
    double popularidadeDiferente; //popularidade = numero total de ocorrencias/ numero de termos distintos
}itemH;

typedef struct Hash_str
{
    itemH *hash;
    int tamanho;
    int termosDiferentes;
}Hash;

/*funcao que calcula a posicao da palavra no hash*/
int H(int m, char *palavra);

/*inicializa a estrutura do hash, a variavel tamanho eh o tamanho deste hash*/
void inicializaHash(Hash *hash, int tamanho);

/*Pesquisa a chave no hash, retorna a posicao desta chave no mesmo*/
int PesquisaHash(Hash *hash, char *chave);

/*insere uma chave no hash*/
void InsereHash(Hash *hash, char *chave);

/*retorna o tamanho do hash*/
int getTamanhoHash(Hash *hash);

/*retorna o elemento da posicao i do hash*/
itemH getPositionHash(Hash *hash, int i);

/*verifica se uma posicao do hash eh nula*/
int positionIsFull(Hash *hash, int i);

#endif	/* _HASHABERTO_H */

