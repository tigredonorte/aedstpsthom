/* 
 * File:   data.h
 * Author: thompson
 *
 * Created on 11 de Abril de 2010, 07:33
 */

#ifndef _DATA_H
#define	_DATA_H

#include "dicionario.h"
#include "file.h"
#include "filap.h"
#include "fila.h"
#include <stdio.h>
#include <stdlib.h>

typedef Dicionario DicionarioH;

/*inicializa um novo indice invertido*/
void novoIndiceInvertido(DicionarioH *dic, int tamDic);

/*insere no indice invertido a partir de um arquivo de entrada*/
//void insereIndiceInvertido(char *documento, DicionarioH *dic);

/*insere no indice invertido a partir de uma matriz de strings "buffer"*/
void insereIndiceInvertido(char **Buffer, DicionarioH *dic, int size);

/*Pesquisa as palavras no indice invertido*/
void PesquisaIndiceInvertido(char **palavra, DicionarioH *dic, char *ArqName, int size);

#endif	/* _DATA_H */

