/*
 * file.h
 * trata da leitura dos arquivos de entrada
 */

#ifndef _FILE_H
#define	_FILE_H

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>

//Caracteres a serem ignorados caso aparecam no texto
#define IGNORA_CHAR " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$&%*()_+{}´`'][~;:/?,|'*-/+\"\t\n\0"

/* lê arquivo da lista e retorna uma string que contem o conteudo do mesmo*/
char* leArquivo(char *nomeArquivo, char **buffer);

/*Retorna a próxima palavra do arquivo ou NULL se não existirem mais palavras*/
char* proxPalavra(char *buffer);

//escreve dados no arquivo de saida
void writeFile(char *ArqName, double value);

#endif	/* _FILE_H */

