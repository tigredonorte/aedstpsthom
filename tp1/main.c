/* 
 * File:   main.c
 * Author: thompson
 *
 * Created on 10 de Abril de 2010, 20:20
 */

#include <stdio.h>
#include <stdlib.h>
#include "data.h"

#define tDic 1000
/*
 * 
 */
int main(int argc, char** argv)
{
    DicionarioH dic;
    int tamDic = tDic;
    novoIndiceInvertido(&dic, tamDic);

    char *documento;
    documento = (char*) malloc(11 * sizeof(char));

    strcpy(documento, "insere.txt");

    insereIndiceInvertido(documento, &dic);
    return (EXIT_SUCCESS);
}

