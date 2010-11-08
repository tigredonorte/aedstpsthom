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

typedef struct mapa_str
{
    int size;
    int PontosArquivo;
    long *inicio;
    long *final;
    int *firstLine;
}Mapa;

//cria um novo mapa
void inicializaMapa(Mapa *map, int size);

//insere elementos no mapa
void insereMapa(Mapa *map, long *inicio, long* final, int *firstLine, int size, int PPArquivo);

//desaloca um mapa
void desalocaMapa(Mapa *map);

//faz o mapeamento do arquivo
void mapeiaArquivo(Mapa *map, int PPArquivo, int PPPagina, char *nomeArquivo, int *numPags);

/*salva uma string no arquivo passado como parametro*/
void saveFile(char *nome_arquivo, char *string);

//cria um novo arquivo com o nome passado por parametro
void createFileIfNotExists(char *nome_arquivo);

//faz a leitura de uma pagina
void readPage(char **buffer, char *nomeArquivo, long *pageBegin, long *pageEnd);

//le a primeira linha do arquivo e descobre a posicao do ultimo caractere desta linha
void readFirstLine(char *nomeArquivo, int *numPontos, int *numDim);

#endif	/* _FILE_H */
