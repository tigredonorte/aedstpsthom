/* 
 * File:   main.c
 * Author: thompson
 *
 * Created on 10 de Abril de 2010, 20:20
 */

#include <stdio.h>
#include <stdlib.h>
#include "data.h"
#include "file.h"
#include <getopt.h>

#define tDic 1000
/*
 * 
 */
int main(int argc, char** argv)
{
    char *vocabularioFile;
    char *outFile;
    int numTrabGerado, numThreads, tamBuffer;
    int c;

    if(argc < 5)
    {
        printf("Numero de arqumentos invalido, o programa necessita dos 5 argumentos: "
               "\n -n numero de trabalhos gerados (consulta, ou documento)"
               "\n-t numero de threads usadas para consumir o trabalho"
               "\n-k tamanho do buffer usado pelo gerador (em MB)"
               "\n-i nome arquivo de vocabulario"
               "\n-o nome arquivo de saida com as respostas para as consultas feitas"
               "\n\n Consulte as especificacoes do programa no leiame.txt"
               "\nO Programa sera fechado.");
        exit(EXIT_FAILURE);
    }
    while((c = getopt (argc, argv, ":n:t:k:i:o:")) != -1)
    {
        switch (c)
        {
            case 'n':
                    numTrabGerado = atoi(optarg);
                    break;
            case 't':
                    numThreads = atoi(optarg);
                    break;
            case 'k':
                    tamBuffer = atoi(optarg);
                    break;
            case 'i':
                    vocabularioFile = optarg;
                    break;
            case 'o':
                    outFile = optarg;
                    break;
            case '?':
                    printf("Argumentos invalidos para a execussao do programa,"
                            "por favor cheque o arquivo leiame.txt"
                            "o programa sera encerrado");
                    return EXIT_FAILURE;
            default:
            abort ();
        }
    }
    deleteFileContent(outFile);

    DicionarioH dic;
    int tamDic = tDic;
    novoIndiceInvertido(&dic, tamDic);

    //insereIndiceInvertido("insere.txt", &dic);
    
    char *aux;
    char *buffer;
    buffer = leArquivo("insere.txt", &aux);

    insereIndiceInvertido2(buffer, &dic);

    char palavra1[] = "lol lil";
    PesquisaIndiceInvertido(palavra1, &dic, outFile);

    return (EXIT_SUCCESS);
}

