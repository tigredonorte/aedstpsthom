/* 
 * File:   main.c
 * Author: thompson
 *
 * Created on 22 de Maio de 2010, 07:46
 */

#include <stdio.h>
#include "pontos.h"
#include <stdlib.h>
#include "interface.h"

int main(int argc, char** argv)
{
    DataIn data;
    readArgs(argc, argv, &data);


    long tamPagina = 0;
    char *buffer;
    long pageBegin = 0;
    readFirstLine(data.IEntrada, &buffer, &pageBegin);
    free(buffer);
    buffer = malloc(sizeof(char*));

    tamPagina = sizePage(data.IEntrada,  data.NPaginas);
    
    int i = 1;
    pageBegin = i*tamPagina + 1;
    long pageEnd = (i+1)*tamPagina;

    readPage(&buffer, data.IEntrada, &pageBegin, &pageEnd);
    printf("%s", buffer);
    
    Pontos pts;
    inicializaPontos(&pts, 2, 2);
    lePontos(&pts, buffer, 2);

    return (EXIT_SUCCESS);
}

