/* 
 * File:   file.h
 * Author: thompson
 *
 * Created on 25 de Abril de 2010, 09:11
 */

#ifndef _FILE_H
#define	_FILE_H

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>

//Caracteres a serem ignorados caso aparecam no texto
#define IGNORA_CHAR " 0123456789!@#$&%*()_+{}´`'][~;:/?,|'*-/+\"\t\n\0"

/* lê arquivo da lista e retorna uma string que contem o conteudo do mesmo*/
char** leArquivo(char *nomeArquivo, int *numPalavras, int *numLinhas);

/*Retorna a próxima palavra do arquivo ou NULL se não existirem mais palavras*/
char* proxPalavra(char *buffer);

/*conta o numero de linhas e de palavras de um arquivo passado por parametro*/
void contaLinhas(char *nome_arquivo, int *nPalavras);

#endif	/* _FILE_H */

