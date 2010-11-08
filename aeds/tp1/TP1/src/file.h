/* 
 * File:   file.h
 * Author: thompson
 *
 * Created on 11 de Abril de 2010, 07:47
 */

#ifndef _FILE_H
#define	_FILE_H

#include <stdlib.h>
#include <stdio.h>

/*Cria o arquivo arqName caso ele nao exista e escreve a string no mesmo*/
void writeFile(char *ArqName, char* string);

//Escreve no arquivo um inteiro, retorna 1 se escreveu com sucesso, 0 se nao escreveu
void writeFileInt(char *ArqName, int number);

//apaga o conteudo de um arquivo
void deleteFileContent(char *ArqName);

//salva em um arquivo as estatisticas geradas pelo arquivo threads.c
void writeFileThread(char *ArqName, int cid, double lTP, double lMP, double lTI, double lMI, double FTime);

#endif	/* _FILE_H */
