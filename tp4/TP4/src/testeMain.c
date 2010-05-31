/* 
 * File:   testeMain.c
 * Author: thompson
 *
 * Created on 30 de Maio de 2010, 11:30
 */

#include <stdio.h>
#include <stdlib.h>
#include "grafo.h"
#include "interface.h"
#include "gen_data.h"
#include "heuristica.h"
#include "tentativa.h"

/*
 * 
 */
int novomain(int argc, char** argv)
{
    //argumentos de entrada do algoritmo
    char *entrada = malloc(sizeof(char) * 50); //arquivo de entrada
    char *saida = malloc(sizeof(char) * 50); //arquivo de saida
    char *fileTeste = malloc(sizeof(char) * 50); //arquivo de saida
    int algoritmo = 1; //qual o algoritmo que sera escolhido

    //gera o arquivo de entrada com os parametros definidos
    uint numEmpresas = 5;
    uint numExperimentos = 6;
    double probabilidade = 0.25;
    geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);

    //cria e inicializa o grafo com suas arestas
    Grafo grafo;
    setEntradaGrafo(&grafo, entrada);

    //responsavel pela estatistica de tempo
    double iniTime = getTime();

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
    double tempoFinal = (getTime() - iniTime);

    //salva os valores importantes no arquivo e imprime os resultados na tela
    SalvaSaida(saida, configuracoes, lucro, tempoGasto, nExp, experimentos, fileTeste, tempoFinal);

    //if(entrada) {free(entrada);}
    //if(saida) {free(saida);}
    if(fileTeste) {free(fileTeste);}
    if(experimentos) {free(experimentos);}
    LiberaGrafo(&grafo);
    return (EXIT_SUCCESS);
}
