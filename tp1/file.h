/* 
 * File:   file.h
 * Author: thompson
 *
 * Created on 11 de Abril de 2010, 07:47
 */

#ifndef _FILE_H
#define	_FILE_H

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include "data.h"

#define IGNORA_CHAR " 0123456789!@#$&%*()_+{}´`'][~;:/?.,|'*-/+.\"\t\n\0"
#define C 20 //numero maximo de letras por palavra

/* lê arquivo da lista e retorna primeira palavra, as próximas palavras são
 * capturadas chamando "proxPalavra( NULL )" */
char* leArquivo(char *nomeArquivo, char **buffer);

/*Retorna a próxima palavra do arquivo ou NULL se não existirem mais palavras*/
char* proxPalavra(char *buffer);

/* formata a palavra fonte com espaços em branco e devolve na palavra  */
void formataPalavra(char* dst, char* src);

/*transforma cada letra da palavra em minuscula*/
void setMinuscula(char* str);

/*Cria o arquivo arqName caso ele nao exista e escreve a string no mesmo*/
void writeFile(char *ArqName, char* string);


#endif	/* _FILE_H */

