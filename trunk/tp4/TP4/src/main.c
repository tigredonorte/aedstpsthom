/*
 * File:   main.c
 * Author: thompson
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "grafo.h"
#include "interface.h"
#include "gen_data.h"


int main(int argc, char** argv)
{
    //argumentos de entrada do algoritmo
    char *entrada; //arquivo de entrada
    char *saida; //arquivo de saida
    char *fileTeste; //arquivo de saida
    int algoritmo = 1; //qual o algoritmo que sera escolhido
    readArgs(argc, argv, &entrada, &saida, &fileTeste, &algoritmo);

    uint numEmpresas = 3;
    uint numExperimentos = 5;
    double probabilidade = 0.5;
    geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);
    
    //cria e inicializa o grafo com suas arestas
    Grafo grafo; 
    setEntradaGrafo(&grafo, entrada);

/*
    double iniTime, finalTime; //responsavel pela estatistica de tempo

    //escolhe entre os tres algoritmos
    iniTime = getTime();
    switch(algoritmo)
    {
        case TENTATIVA:
                    //coloreTentativa(&grafo, &tentativas);
                    break;
        case HEURISTICA:
                    //coloreBranch(&grafo, &tentativas);
                    break;
        default:
            printf("nao existe o algoritmo com id %d, por favor consulte o arquivo leiame.txt", algoritmo);
    }
    finalTime = (getTime() - iniTime);
*/
    //salva os valores importantes no arquivo e imprime os resultados na tela
    //SalvaSaida(cor, tentativas, finalTime, saida, fileTeste);
    return (EXIT_SUCCESS);
}