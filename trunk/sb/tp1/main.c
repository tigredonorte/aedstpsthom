/* 
 * File:   main.c
 * Author: thom
 *
 * Created on 7 de Setembro de 2010, 17:39
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Maquina.h"

/*
 * 
 */
int main(int argc, char** argv)
{
    //declaracoes
    int verbose, PC, SP, posInicial;
    char entrada[50];
    char v;

    //Atribuicoes de valores vindos da entrada
    PC = atoi(argv[1]);
    SP = atoi(argv[2]);
    posInicial = atoi(argv[3]);
    strcpy(&v, argv[4]);
    if(strcmp(&v, "v") == 0)
    {
        verbose = 1;
    }
    else
    {
        verbose = 0;
    }
    strcpy(entrada, argv[5]);

    //simulacao
    Simulador(PC, SP, posInicial, verbose, entrada);
    return (EXIT_SUCCESS);
}