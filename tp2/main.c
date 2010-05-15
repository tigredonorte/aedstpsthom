/* 
 * File:   main.c
 * Author: thompson
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <sys/time.h>
#include "file.h"
#include "hashaberto.h"
#include "guloso.h"
#include "tentativa.h"
#include "dinamica.h"
#include "arvore.h"

#define TENTATIVA 1
#define DINAMICA  2
#define GULOSO    3

double getTime();

int main(int argc, char** argv)
{ //Começa a função "main"
    Hash hash; //estrutura do hash, que calculara as popularidades
    char *entrada; //arquivo de entrada
    char *saida; //arquivo de saida
    char *fileTeste; //arquivo de saida
    int algoritmo; //qual o algoritmo que sera escolhido
    int numPalavras; //numero de palavras que contem o arquivo
    int numLinhas; //numero de linhas do arquivo, para estatisticas
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
        fileTeste = malloc(sizeof(char) * 9);
        strcpy(fileTeste,"saida.ods");
    }
    char **Buffer;
    numPalavras = 0;
    Buffer = leArquivo(entrada, &numPalavras, &numLinhas);

    //o hash tera o tamanho exato do numero de palavras
    inicializaHash(&hash, numPalavras, numLinhas);

    int i;
    //insere todas as palavras no hash
    for(i = 0; i < numPalavras; i++)
    {
        InsereHash(&hash, Buffer[i]);
    }
    calculaPopularidade(&hash);

    Arvore ar;
    InicializaArvore(&ar);
    
    //pega o tempo inicial
    double timeIni = getTime();
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
    double timeFinal = getTime() - timeIni;

    int size = getInseridos(&hash);
    char **vString = (char**)malloc(sizeof(char*) * size);
    int *vProfundidade = (int*)malloc(size * sizeof(int));
    int alturaArvore = -1;
    int numeroNos = 0;
    criaVetorProfundidadeArvore(&ar, &vString, &vProfundidade, &numeroNos);
    double custo = 0;
    for(i = 0; i < numeroNos; i++)
    {
        //pesquisa no hash a popularidade da palavra
        int id = PesquisaHash(&hash, vString[i]);
        double pop = getPopularidade(&hash, id);

        //salva no arquivo a palavra
        printf("%s %f %d\n", vString[i], pop, vProfundidade[i]);
        saveFile(saida, vString[i]);

        //salva no arquivo a popularidade da palavra
        char string[32];
        sprintf(string, " %f", pop); //converte de double pra char
        saveFile(saida, string);

        //salva no arquivo a popularidade da palavra
        sprintf(string, " %d\n", vProfundidade[i]); //converte de double pra char
        saveFile(saida, string);

        //encontra a altura da arvore
        int profundidade = vProfundidade[i];
        if(alturaArvore < profundidade)
        {
            alturaArvore = profundidade;
        }

        //calcula o custo da arvore
        custo += pop * profundidade;
    }
    printf("\nNumero de Nos = %d", numeroNos);
    printf("\nCusto da Arvore = %f", custo);
    printf("\nAltura da Arvore = %d", alturaArvore);
    printf("\n\n");
    
    char string[32]; //tamanho de um double em bytes
    sprintf(string, "%f", timeFinal); //converte de double pra char
    if(fileTeste != NULL)
    {
        saveFile(fileTeste, string);
        saveFile(fileTeste, "\n");
    }
    
    return (EXIT_SUCCESS);
} //Fim-função

//retorna o tempo de relogio
double getTime()
{
    struct timeval tv;
    double curtime;
    gettimeofday(&tv, NULL);
    curtime = (double) tv.tv_sec + 1.e-6 * (double) tv.tv_usec;
    return(curtime);
}
