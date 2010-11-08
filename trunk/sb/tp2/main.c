/* 
 * File:   main.c
 * Author: thom
 *
 * Created on 8 de Outubro de 2010, 21:48
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "montador.h"
#include "Maquina.h"

int main(int argc, char** argv)
{
    //declaracoes
    int verbose;
    char entrada[50];
    char saida[50];
    char v;

    //Atribuicoes de valores vindos da entrada
    strcpy(&v, argv[1]);
    if(strcmp(&v, "v") == 0)
    {
        verbose = 1;
    }
    else
        
    {
        verbose = 0;
    }
    strcpy(entrada, argv[2]);
    strcpy(saida, argv[3]);

    //simulacao
    Montador(entrada, verbose, saida);   
    Simulador(0, 1000, 0, verbose, saida);

    return (EXIT_SUCCESS);
}
