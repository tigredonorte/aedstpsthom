
/*
 * File:   main.c
 * Author: thompson
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "grafo.h"
#include "tentativa.h"
#include "guloso.h"
#include "branch.h"
#include "interface.h"

#define TENTATIVA 1
#define BRANCH  2
#define GULOSO  3


int main(int argc, char** argv)
{
    //argumentos de entrada do algoritmo
    char *entrada; //arquivo de entrada
    char *saida; //arquivo de saida
    char *fileTeste; //arquivo de saida
    int algoritmo = 1; //qual o algoritmo que sera escolhido
    readArgs(argc, argv, &entrada, &saida, &fileTeste, &algoritmo);

    //cria e inicializa o grafo com suas arestas
    Grafo grafo;
    setEntradaGrafo(&grafo, entrada);

    int cor = 0; //numero de cores
    long long tentativas = 0; //guardara o numero de tentativas do algoritmo
    double iniTime, finalTime; //responsavel pela estatistica de tempo

    //escolhe entre os tres algoritmos
    iniTime = getTime();
    switch(algoritmo)
    {
        case TENTATIVA:
                    cor = coloreTentativa(&grafo, &tentativas);
                    break;
        case BRANCH:
                    cor = coloreBranch(&grafo, &tentativas);
                    break;
        case GULOSO:
                    cor = coloreGuloso(&grafo, &tentativas);
                    break;
        default:
            printf("nao existe o algoritmo com id %d, por favor consulte o arquivo leiame.txt", algoritmo);
    }
    finalTime = (getTime() - iniTime);

    //salva os valores importantes no arquivo e imprime os resultados na tela
    SalvaSaida(cor, tentativas, finalTime, saida, fileTeste);
    return (EXIT_SUCCESS);
}
