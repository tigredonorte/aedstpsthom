/* 
 * File:   dicionario.h
 * Author: thompson
 *
 * Created on 10 de Abril de 2010, 17:43
 */

#ifndef _DICIONARIO_H
#define	_DICIONARIO_H

#include "filap.h"
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct Fila Hash;

typedef struct Dicionario_str
{
    Hash *hash;
    int tam;
}Dicionario;

/* pega o tempo do sistema com a funcao getRusages */
long getTime();

//Retorna uma valor correspondente a posicao do hash na palavra
int Char2Indice(char* palavra, int m);

//inicializa o dicionario com o tamanho estimado que ele assumira
void InicializaDicionario(Dicionario *dic, int tamDic);

//insere uma palavra no dicionario caso ela nao exista,
//adiciona nova ocorrencia caso exista
void InserePalavraDicionario(Dicionario *dic, int idDoc, char *palavra);

//pesquisa uma palavra dentro do dicionario
//retorna o tempo gasto para pesquisar a palavra
PFila PesquisaPalavraDicionario(Dicionario *dic, char *palavra, long *tempoLatencia);

//recupera a fila de documentos presente na celula passada como parametro
void recuperaFilaDocumentos(PFila celula);
#endif	/* _DICIONARIO_H */
