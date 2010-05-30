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
#include "heuristica.h"
#include "tentativa.h"


int main(int argc, char** argv)
{
    //argumentos de entrada do algoritmo
    char *entrada = NULL; //arquivo de entrada
    char *saida = NULL; //arquivo de saida
    char *fileTeste = NULL; //arquivo de saida
    int algoritmo = 1; //qual o algoritmo que sera escolhido
    readArgs(argc, argv, &entrada, &saida, &fileTeste, &algoritmo);

    //gera o arquivo de entrada com os parametros definidos
    uint numEmpresas = 8;
    uint numExperimentos = 20;
    double probabilidade = 0.15;
    geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);
    
    //cria e inicializa o grafo com suas arestas
    Grafo grafo; 
    setEntradaGrafo(&grafo, entrada);

    //responsavel pela estatistica de tempo
    double iniTime = getTime();

    //variaveis de saida
    int configuracoes = 0;
    double lucro = 0;
    int *experimentos = NULL;
    int nExp = 0;
    int numTestes = 0;
    
    //escolhe entre os tres algoritmos
    switch(algoritmo)
    {
        case TENTATIVA:
                    calculaConfiguracaoTentativa(&grafo);
                    break;
        case HEURISTICA:
                    calculaConfiguracaoHeuristica(&grafo, experimentos, &nExp, &numTestes, &lucro);
                    break;
        default:
            printf("nao existe o algoritmo com id %d, por favor consulte o arquivo leiame.txt", algoritmo);
    }
    double tempoGasto = (getTime() - iniTime);
    
    //salva os valores importantes no arquivo e imprime os resultados na tela
    SalvaSaida(saida, configuracoes, lucro, tempoGasto, nExp, experimentos, fileTeste, numTestes);

    free(experimentos);
    LiberaGrafo(&grafo);
    return (EXIT_SUCCESS);
}