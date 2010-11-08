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


int main2(int argc, char** argv)
{
    //argumentos de entrada do algoritmo
    char *entrada = NULL; //arquivo de entrada
    char *saida = NULL; //arquivo de saida
    char *fileTeste = NULL; //arquivo de saida
    int algoritmo = 1; //qual o algoritmo que sera escolhido
    readArgs(argc, argv, &entrada, &saida, &fileTeste, &algoritmo);
   
    //cria e inicializa o grafo com suas arestas
    Grafo grafo; 
    setEntradaGrafo(&grafo, entrada);

    //variaveis de saida
    long long int configuracoes = 0;
    double lucro = 0;
    double tempoGasto = 0;
    int *experimentos = NULL;
    int nExp = 0;
    
    //escolhe entre os tres algoritmos
    switch(algoritmo)
    {
        case TENTATIVA:
                    calculaConfiguracaoTentativa(&grafo, &experimentos, &nExp, &configuracoes, &lucro, &tempoGasto);
                    break;
        case HEURISTICA:
                    calculaConfiguracaoHeuristica(&grafo, &experimentos, &nExp, &configuracoes, &lucro, &tempoGasto);
                    break;
        default:
            printf("nao existe o algoritmo com id %d, por favor consulte o arquivo leiame.txt", algoritmo);
    }
    
    //salva os valores importantes no arquivo e imprime os resultados na tela
    SalvaSaida(saida, configuracoes, lucro, tempoGasto, nExp, experimentos);

    LiberaGrafo(&grafo);
    return (EXIT_SUCCESS);
}
