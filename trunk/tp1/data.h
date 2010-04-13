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

typedef Dicionario DicionarioH;

void novoIndiceInvertido(DicionarioH *dic, int tamDic);

void insereIndiceInvertido(char *documento, DicionarioH *dic);

void PesquisaIndiceInvertido(char *palavra, DicionarioH *dic, char *ArqName);
#endif	/* _DATA_H */

