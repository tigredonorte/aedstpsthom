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
    char *fileTeste; //arquivo de saida
    char *string = NULL;
    int algoritmo = 1; //qual o algoritmo que sera escolhido
    readArgs(argc, argv, &entrada, &saida, &fileTeste, &algoritmo);
    long long int testes = 0;

    //variaveis de saida
    long long int configuracoes = 0;
    double lucro = 0;
    double tempoGasto = 0;
    int *experimentos = NULL;
    int nExp = 0;

    int numEmpresas = 0;
    int numExperimentos = 0;
    double probabilidade = 0;

    Grafo grafo;
    saida = malloc(sizeof(char) *100);
    fileTeste = malloc(sizeof(char) *100);
    string = malloc(sizeof(char) *100);
    sprintf(fileTeste, "teste%lld ", testes);

    sprintf(string, "NumeroDeEmpresas NumeroDeExperimentos Probabilidade NumeroConfiguracoes Lucro TempoGasto TempoFinal");
    saveFile(fileTeste, string);
    free(string);
    string = NULL;

    int numTeste = 1;
    int maxNumEmpresas = 30;
    int i;

    //responsavel pela estatistica de tempo
    double iniTime = 0;

        
    printf("Tentativa e erro\n\n");
    algoritmo = 1;
    printf("Variando Empresas\n");
    for(i = 1; i < maxNumEmpresas; i++)
    {
        numEmpresas = i;
        numExperimentos = 20;
        probabilidade = 0.50;

        //gera o arquivo de entrada com os parametros definidos
        geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);

        //cria e inicializa o grafo com suas arestas
        setEntradaGrafo(&grafo, entrada);

        //responsavel pela estatistica de tempo
        iniTime = getTime();

        //variaveis de saida
        configuracoes = 0;
        lucro = 0;
        tempoGasto = 0;
        experimentos = NULL;
        nExp = 0;

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

        string = malloc(sizeof(char) *100);
        sprintf(string, "%d %d %f %lld %f %f %f\n", numEmpresas, numExperimentos, probabilidade, configuracoes, lucro, tempoGasto, tempoFinal);
        saveFile(fileTeste, string);
        free(string);
        string = NULL;

        free(experimentos);
        LiberaGrafo(&grafo);
        printf("teste %d concluido\n", numTeste);
        numTeste++;
    }

    printf("Variando Experimentos\n");
    int maxNumExperimentos = 30;
    for(i = 1; i < maxNumExperimentos; i++)
    {
        numEmpresas = 15;
        numExperimentos = i;
        probabilidade = 0.50;

        //gera o arquivo de entrada com os parametros definidos
        geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);

        //cria e inicializa o grafo com suas arestas
        setEntradaGrafo(&grafo, entrada);

        //responsavel pela estatistica de tempo
        iniTime = getTime();

        //variaveis de saida
        configuracoes = 0;
        lucro = 0;
        tempoGasto = 0;
        experimentos = NULL;
        nExp = 0;

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

        string = malloc(sizeof(char) *100);
        sprintf(string, "%d %d %f %lld %f %f %f\n", numEmpresas, numExperimentos, probabilidade, configuracoes, lucro, tempoGasto, tempoFinal);
        saveFile(fileTeste, string);
        free(string);
        string = NULL;

        free(experimentos);
        LiberaGrafo(&grafo);

        printf("teste %d concluido\n", numTeste);
        numTeste++;
    }


    double prob = 0.05;
    double p = 0;
    int max = 10;
    printf("Variando conectividade\n");
    for(i = 0; i < max; i++)
    {
        numEmpresas = 15;
        numExperimentos = 20;
        p = p + prob;
        probabilidade = p;

        //gera o arquivo de entrada com os parametros definidos
        geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);

        //cria e inicializa o grafo com suas arestas
        setEntradaGrafo(&grafo, entrada);

        //responsavel pela estatistica de tempo
        iniTime = getTime();

        //variaveis de saida
        configuracoes = 0;
        lucro = 0;
        tempoGasto = 0;
        experimentos = NULL;
        nExp = 0;

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

        string = malloc(sizeof(char) *100);
        sprintf(string, "%d %d %f %lld %f %f %f\n", numEmpresas, numExperimentos, probabilidade, configuracoes, lucro, tempoGasto, tempoFinal);
        saveFile(fileTeste, string);
        free(string);
        string = NULL;

        free(experimentos);
        LiberaGrafo(&grafo);

        printf("teste %d concluido\n", numTeste);
        numTeste++;
    }

    double mochila = 0;
    double addMochila = 50.0;
    printf("Variando mochila\n");
    for(i = 0; i < 20; i++)
    {
        mochila += addMochila;
        numEmpresas = 15;
        numExperimentos = 20;
        probabilidade = 0.5;

        //gera o arquivo de entrada com os parametros definidos
        geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);

        //cria e inicializa o grafo com suas arestas
        setEntradaGrafo(&grafo, entrada);
        grafo.tempo = mochila;

        //responsavel pela estatistica de tempo
        iniTime = getTime();

        //variaveis de saida
        configuracoes = 0;
        lucro = 0;
        tempoGasto = 0;
        experimentos = NULL;
        nExp = 0;

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

        string = malloc(sizeof(char) *100);
        sprintf(string, "%d %d %f %lld %f %f %f\n", numEmpresas, numExperimentos, probabilidade, configuracoes, lucro, tempoGasto, tempoFinal);
        saveFile(fileTeste, string);
        free(string);
        string = NULL;

        free(experimentos);
        LiberaGrafo(&grafo);

        printf("teste %d concluido\n", numTeste);
        numTeste++;
    }



    

    printf("Guloso\n\n");
    algoritmo = 2;
    printf("Variando Empresas\n");
    for(i = 1; i < maxNumEmpresas; i++)
    {
        numEmpresas = i;
        numExperimentos = 20;
        probabilidade = 0.50;

        //gera o arquivo de entrada com os parametros definidos
        geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);

        //cria e inicializa o grafo com suas arestas
        setEntradaGrafo(&grafo, entrada);

        //responsavel pela estatistica de tempo
        iniTime = getTime();

        //variaveis de saida
        configuracoes = 0;
        lucro = 0;
        tempoGasto = 0;
        experimentos = NULL;
        nExp = 0;

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

        string = malloc(sizeof(char) *100);
        sprintf(string, "%d %d %f %lld %f %f %f\n", numEmpresas, numExperimentos, probabilidade, configuracoes, lucro, tempoGasto, tempoFinal);
        saveFile(fileTeste, string);
        free(string);
        string = NULL;

        free(experimentos);
        LiberaGrafo(&grafo);
        printf("teste %d concluido\n", numTeste);
        numTeste++;
    }

    maxNumExperimentos = 30;
    printf("Variando Experimentos\n");
    for(i = 1; i < maxNumExperimentos; i++)
    {
        numEmpresas = 15;
        numExperimentos = i;
        probabilidade = 0.50;

        //gera o arquivo de entrada com os parametros definidos
        geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);

        //cria e inicializa o grafo com suas arestas
        setEntradaGrafo(&grafo, entrada);

        //responsavel pela estatistica de tempo
        iniTime = getTime();

        //variaveis de saida
        configuracoes = 0;
        lucro = 0;
        tempoGasto = 0;
        experimentos = NULL;
        nExp = 0;

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

        string = malloc(sizeof(char) *100);
        sprintf(string, "%d %d %f %lld %f %f %f\n", numEmpresas, numExperimentos, probabilidade, configuracoes, lucro, tempoGasto, tempoFinal);
        saveFile(fileTeste, string);
        free(string);
        string = NULL;

        free(experimentos);
        LiberaGrafo(&grafo);

        printf("teste %d concluido\n", numTeste);
        numTeste++;
    }


    prob = 0.05;
    p = 0;
    max = 10;
    printf("Variando probabilidade\n");
    for(i = 0; i < max; i++)
    {
        numEmpresas = 15;
        numExperimentos = 20;
        p = p + prob;
        probabilidade = p;

        //gera o arquivo de entrada com os parametros definidos
        geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);

        //cria e inicializa o grafo com suas arestas
        setEntradaGrafo(&grafo, entrada);

        //responsavel pela estatistica de tempo
        iniTime = getTime();

        //variaveis de saida
        configuracoes = 0;
        lucro = 0;
        tempoGasto = 0;
        experimentos = NULL;
        nExp = 0;

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

        string = malloc(sizeof(char) *100);
        sprintf(string, "%d %d %f %lld %f %f %f\n", numEmpresas, numExperimentos, probabilidade, configuracoes, lucro, tempoGasto, tempoFinal);
        saveFile(fileTeste, string);
        free(string);
        string = NULL;

        free(experimentos);
        LiberaGrafo(&grafo);

        printf("teste %d concluido\n", numTeste);
        numTeste++;
    }

    mochila = 0;
    addMochila = 50.0;
    printf("Variando mochila\n");
    for(i = 0; i < 20; i++)
    {
        mochila += addMochila;
        numEmpresas = 15;
        numExperimentos = 20;
        probabilidade = 0.5;

        //gera o arquivo de entrada com os parametros definidos
        geraEntrada(entrada, numEmpresas, numExperimentos, probabilidade);

        //cria e inicializa o grafo com suas arestas
        setEntradaGrafo(&grafo, entrada);
        grafo.tempo = mochila;

        //responsavel pela estatistica de tempo
        iniTime = getTime();

        //variaveis de saida
        configuracoes = 0;
        lucro = 0;
        tempoGasto = 0;
        experimentos = NULL;
        nExp = 0;

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

        string = malloc(sizeof(char) *100);
        sprintf(string, "%d %d %f %lld %f %f %f\n", numEmpresas, numExperimentos, probabilidade, configuracoes, lucro, tempoGasto, tempoFinal);
        saveFile(fileTeste, string);
        free(string);
        string = NULL;

        free(experimentos);
        LiberaGrafo(&grafo);

        printf("teste %d concluido\n", numTeste);
        numTeste++;
    }
    
    if(fileTeste) {free(fileTeste);}
    if(experimentos) {free(experimentos);}
    return (EXIT_SUCCESS);
}
