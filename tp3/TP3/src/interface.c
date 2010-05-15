#include "interface.h"

void setEntradaGrafo(Grafo *grafo, char *entrada)
{
    char **Buffer;
    int size;
    Buffer = leArquivo(entrada, &size);
    if(Buffer == NULL)
    {
        printf("\nErro ao ler arquivo, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }

    int i, V1, V2, NVertices, NArestas;
    for(i = 0; i < size; i = i+3)
    {
        if(strcmp(Buffer[i], "p") == 0)
        {
            if(strcmp(Buffer[i+1], "p") != 0 && strcmp(Buffer[i+1], "e"))
            {
                if(strcmp(Buffer[i+2], "p") != 0 && strcmp(Buffer[i+2], "e"))
                {
                    NVertices = atoi(Buffer[i+1]);
                    NArestas = atoi(Buffer[i+2]);
                    inicializaGrafo(grafo, NArestas, NVertices);
                }
                
            }
        }
        else
        {
            if(strcmp(Buffer[i], "e") == 0)
            {
                if(strcmp(Buffer[i+1], "p") != 0 && strcmp(Buffer[i+1], "e"))
                {
                    if(strcmp(Buffer[i+2], "p") != 0 && strcmp(Buffer[i+2], "e"))
                    {
                        V1 = atoi(Buffer[i+1]);
                        V2 = atoi(Buffer[i+2]);
                        //todas as arestas terao uma unidade a menos (facilita busca em vetor)
                        V1--;
                        V2--;
                        InsereAresta(grafo, V1, V2);
                    }
                }
            }
        }
    }
}

void SalvaSaida(int cor, long long int tentativas, double finalTime, char* saida, char *fileTeste)
{
    printf("\n\nNumero de cores: %d", cor);
    printf("\nNumero de tentativas: %lld", tentativas);

    char *string = malloc(sizeof(char) * 50);
    sprintf(string, " %d %lld\n", cor, tentativas);
    saveFile(saida, string);
    free(string);

    string = malloc(sizeof(char) * 50);
    sprintf(string, " %f\n", finalTime);
    saveFile(saida, string);
    free(string);
}
void readArgs(int argc, char** argv, char **entrada, char **saida, char **fileTeste, int *algoritmo)
{
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
       exit(EXIT_FAILURE);
    }
    int t = 0;

    while((c = getopt (argc, argv, ":s:i:o:t:")) != -1)
    {
        switch (c)
        {
            case 's':
                    (*algoritmo) = atoi(optarg);
                    break;
            case 'i':
                    (*entrada) = optarg;
                    break;
            case 'o':
                    (*saida) = optarg;
                    break;
            case 't':
                    t = 1;
                    (*fileTeste) = optarg;
                    break;
            case '?':
                     printf("Parametros de entrada incorretos, por favor cheque o arquivo leiame.txt para mais informacoes\n"
                            "o programa sera fechado\n");
                    exit(EXIT_FAILURE);
            default:
            abort ();
        }
    }
    if(t == 0)
    {
        (*fileTeste) = malloc(sizeof(char) * 10);
        strcpy((*fileTeste),"saida.ods");
    }
}

double getTime()
{
    struct timeval tv;
    double curtime;
    gettimeofday(&tv, NULL);
    curtime = (double) tv.tv_sec + 1.e-6 * (double) tv.tv_usec;
    return(curtime);
}
