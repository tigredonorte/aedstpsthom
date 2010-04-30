/* 
 * File:   main.c
 * Author: thompson
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include "file.h"
#include "hashaberto.h"
#include "guloso.h"
#include "tentativa.h"
#include "dinamica.h"
#include "arvore.h"

#define TENTATIVA 1
#define DINAMICA  2
#define GULOSO    3

int main(int argc, char** argv)
{ //Começa a função "main"
    Hash hash; //estrutura do hash, que calculara as popularidades
    char *entrada; //arquivo de entrada
    char *saida; //arquivo de saida
    int algoritmo; //qual o algoritmo que sera escolhido
    int numPalavras; //numero de palavras que contem o arquivo
    int c; //variavel provisoria para a funcao get opt

    c =0;

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
    while((c = getopt (argc, argv, ":s:i:o:")) != -1)
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
            case '?':
                    return EXIT_FAILURE;
            default:
            abort ();
        }
    }

    char **Buffer;
    numPalavras = 0;
    Buffer = leArquivo(entrada, &numPalavras);

    //o hash tera o tamanho exato do numero de palavras
    inicializaHash(&hash, numPalavras);

    int i;
    //insere todas as palavras no hash
    for(i = 0; i < numPalavras; i++)
    {
        InsereHash(&hash, Buffer[i]);
    }
    calculaPopularidade(&hash);

    Arvore arT;
    InicializaArvore(&arT);
    insereArvoreTentativa(&arT, &hash);

    Arvore arD;
    InicializaArvore(&arD);
    insereArvoreDinamica(&arD, &hash);

    Arvore arG;
    InicializaArvore(&arG);
    insereArvoreGulosa(&arG, &hash);

    /*
    Arvore ar;
    InicializaArvore(&ar);
    switch(algoritmo)
    {
        case TENTATIVA:

                    insereArvoreTentativa(&ar, &hash);
                    break;
        case DINAMICA:
                    insereArvoreDinamica(&ar, &hash);
                    break;
        case GULOSO:
                    insereArvoreGulosa(&ar, &hash);
                    break;
        default:
            printf("nao existe o algoritmo com id %d, por favor consulte o arquivo leiame.txt", algoritmo);
    }
    //Chama a função com nível 1.
    
     */
    return (EXIT_SUCCESS);
} //Fim-função
