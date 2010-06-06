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
#define IGNORA_CHAR " \n\t\0!@#$&%*()_+{}´`'][~;:/?,|'*-/+abcdghijklmnopqrstuvwxyzABCDGHIJKLMNOPQSTUVWXYZ"

/*salva uma string no arquivo passado como parametro*/
void saveFile(char *nome_arquivo, char *string);

//cria um novo arquivo com o nome passado por parametro
void createFileIfNotExists(char *nome_arquivo);

#endif	/* _FILE_H */
