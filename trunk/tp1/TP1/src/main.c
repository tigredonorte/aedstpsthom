/* 
 * File:   main.c
 * Author: thompson
 *
 * Created on 10 de Abril de 2010, 20:20
 */

#include <stdio.h>
#include <stdlib.h>
#include "file.h"
#include "gen_data.h"
#include <getopt.h>
#include "threads.h"

//numero primo bem grande (acima do numero esperado de palavras geradas)
#define tDic 888257
/*
 * 
 */
int main(int argc, char** argv)
{
    char *vocabularioFile;
    char *outFile;
    char *eFile;
    int E = 0;
    int numTrabGerado, numThreads, tamBuffer;
    int c;

    if(argc < 5)
    {
        printf("\nNumero de arqumentos invalido, o programa necessita dos 5 argumentos: "
               "\n-n numero de trabalhos gerados (consulta, ou documento)"
               "\n-t numero de threads usadas para consumir o trabalho"
               "\n-k tamanho do buffer usado pelo gerador (em MB)"
               "\n-i nome arquivo de vocabulario"
               "\n-o nome arquivo de saida com as respostas para as consultas feitas"
               "\n\n Consulte as especificacoes do programa no leiame.txt"
               "\nO Programa sera fechado.");
        exit(EXIT_FAILURE);
    }
    while((c = getopt (argc, argv, ":n:t:k:i:o:e:")) != -1)
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
            case 'e':
                    eFile = optarg;
                    E = 1;
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
    if(!E)
    {
        eFile = malloc(sizeof(char) * 10);
        strcpy(eFile, "efile.ods");
    }
    //apaga o conteudo escrito em outfile
    deleteFileContent(outFile);

    //inicializa as funcoes do gerador de palavras
    init_random_functions();

    //inicializa um novo dicionario com o tamanho fixo tDic definido no cabeçalho deste arquivo
    DicionarioH dic;
    novoIndiceInvertido(&dic, tDic);

    //cria as caracteristicas da nova thread
    pthread_attr_t attr;
    pthread_attr_init(&attr);

    //cada thread criada se comportara como um processo a parte no sistema
    //nao competirao entre si dentro de um processo so(isto aumenta a performance do programa)
    pthread_attr_setscope(&attr, PTHREAD_SCOPE_PROCESS);

    //cria uma nova t_struct
    t_struct estrutura_thread;
    inicializaTStruct(&estrutura_thread, outFile, eFile, vocabularioFile, numTrabGerado, tamBuffer, &dic);

    //cria um produtor
    pthread_t *produtors;
    produtors = (pthread_t*) malloc(sizeof(pthread_t));
    pthread_create(produtors , &attr, produtor, &estrutura_thread);

    //cria o numero de threads passada por parametro
    pthread_t *consumidores;
    consumidores = (pthread_t*) malloc(sizeof(pthread_t) * numThreads);
    int i;
    for(i = 0; i < numThreads; i++)
    {
        pthread_create(&consumidores[i] , &attr, consumidor, &estrutura_thread);
    }

    //depois de inicializado o atributo, libera a memoria
    pthread_attr_destroy (&attr);

    //aguarda ate que todas as threads acabem de execultar
    for(i = 0; i < numThreads; i++)
    {
        pthread_join(consumidores[i] , NULL);
    }

    printf("\nFim da execussao\n");
    return (EXIT_SUCCESS);
}

