
/*
 * File:   main.c
 * Author: thompson
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include "file.h"
#include "grafo.h"
#include "tentativa.h"
#include "guloso.h"

#define TENTATIVA 1
#define BRANCH  2
#define GULOSO  3

int main(int argc, char** argv)
{ //Começa a função "main"
    char *entrada; //arquivo de entrada
    char *saida; //arquivo de saida
    char *fileTeste; //arquivo de saida
    int algoritmo = 1; //qual o algoritmo que sera escolhido
    int c; //variavel provisoria para a funcao get opt

    c = 0;

    if(argc < 7)
    {
        printf("Entrada invalida, erro! A entrada deve conter os seguintes parametros: \n"
               "-s <1|2|3> - indicando qual dos algoritmos deve ser utilizado\n"
               "-i <nome do arquivo de entrada>\n"
               "-o <nome do arquivo de saída>\n"
               "Para mais informaçoes cheque o arquivo leiame.txt \n"
               "O Programa sera fechado");
       return EXIT_FAILURE;
    }
    int t = 0;

    while((c = getopt (argc, argv, ":s:i:o:t:")) != -1)
    {
        switch (c)
        {
            case 's':
                    algoritmo = atoi(optarg);
                    break;
            case 'i':
                    entrada = optarg;
                    break;
            case 'o':
                    saida = optarg;
                    break;
            case 't':
                    t = 1;
                    fileTeste = optarg;
                    break;
            case '?':
                     printf("Parametros de entrada incorretos, por favor cheque o arquivo leiame.txt para mais informacoes\n"
                            "o programa sera fechado\n");
                    return EXIT_FAILURE;
            default:
            abort ();
        }
    }
    if(t == 0)
    {
        fileTeste = malloc(sizeof(char) * 10);
        strcpy(fileTeste,"saida.ods");
    }

    char **Buffer;
    int size;
    Buffer = leArquivo(entrada, &size);
    if(Buffer == NULL)
    {
        printf("\nErro ao ler arquivo, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }

    int NVertices = atoi(Buffer[0]);
    int NArestas = atoi(Buffer[1]);

    Grafo grafo;
    inicializaGrafo(&grafo, NArestas, NVertices);

    int i;
    for(i = 2; i < size - 1; i = i+2)
    {
        int V1, V2;
        V1 = atoi(Buffer[i]);
        V2 = atoi(Buffer[i+1]);
      
        //todas as arestas terao uma unidade a menos (facilita busca em vetor)
        V1--;
        V2--;
        InsereAresta(&grafo, V1, V2);
    }
    //coloreGuloso(&grafo);
    coloreTentativa(&grafo);

    switch(algoritmo)
    {
        case TENTATIVA:
                    //coloreTentativa(&grafo);
                    break;
        case BRANCH:
                    break;
        case GULOSO:
                    //coloreGuloso(&grafo);
                    break;
        default:
            printf("nao existe o algoritmo com id %d, por favor consulte o arquivo leiame.txt", algoritmo);
    }
    ImprimeGrafo(&grafo);
 
    return (EXIT_SUCCESS);
} //Fim-função
