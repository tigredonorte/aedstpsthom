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
    int nOcorrencias;
    double pop;    //popularidade = numero total de ocorrencias/ numero total de termos
    double popD; //popularidade = numero total de ocorrencias/ numero de termos distintos
}itemH;

typedef struct Hash_str
{
    itemH *hash;
    int tamanho;
    int termosDif;
}Hash;

/*funcao que calcula a posicao da palavra no hash*/
int H(int m, char *palavra);

/*inicializa a estrutura do hash, a variavel tamanho eh o tamanho deste hash*/
void inicializaHash(Hash *hash, int tamanho);

/*Pesquisa a chave no hash, retorna a posicao desta chave no mesmo*/
int PesquisaHash(Hash *hash, char *chave);

/*insere uma chave no hash*/
void InsereHash(Hash *hash, char *chave);

/*calcula a popularidade dos termos do hash*/
void calculaPopularidade(Hash *hash);

/*retorna o status da posicao i do hash*/
int getStatus(Hash *hash, int i);

/*compara duas chaves, se forem iguais retorna0,
 * se a primeira maior que a segunda retorna 1
 * se a segunda maior que a primeira retorna -1*/
int comparaChave(itemH *k1, itemH *k2);

/*compara a popularidade de duas chaves*/
int comparaPopularidadeChave(itemH *k1, itemH *k2);

/*Retorna a popularidade do i-ezimo termo do hash*/
double getPopularidade(Hash *hash, int i);

/*Retorna a popularidade do i-ezimo termo do hash*/
double getPop(itemH *k1);

/*Retorna o numero de termos distintos do */
int getTermosDiferentes(Hash *hash);

/*retorna a chave de um item*/
char *getChave(itemH *k1);

/*transforma o hash(vetor esparço) em um vetor denso. Retorna size, o tamanho deste vetor*/
void criaVetor(Hash *hash, itemH **vetor, int *size);
#endif	/* _HASHABERTO_H */

