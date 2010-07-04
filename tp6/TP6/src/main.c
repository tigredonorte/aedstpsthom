/* 
 * File:   main.c
 * Author: thompson
 *
 * Created on 22 de Maio de 2010, 07:44
 */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "interface.h"
#include "algoritmos.h"

int main(int argc, char** argv)
{
    DataIn data;
    DataOut datao;
    inicializaSaida(&datao);
    readArgs(argc, argv, &data);
    leEntrada(&data);

    switch(data.S)
    {
        case FB:
                break;
        case SA:
                break;
        default:
            printf("nao existe esta politica, erro!", data.S);
            exit(EXIT_FAILURE);
    }
    
/*
    printf("%d", dist);


    int k;

    for(k = 0; k < 20; k++)
    {
        if(DistanciaMenorK(&a, &b, k))
        {
            printf("\n %d", k);
            break;
        }
    }
*/


    SalvaSaida(&datao);
    return (EXIT_SUCCESS);
}

