#include "interface.h"

void setEntradaGrafo(Grafo *grafo, char *entrada)
{
    char **Buffer;
    int i = 0;
    int size;
    Buffer = leArquivo(entrada, &size);
    if(Buffer == NULL)
    {
        printf("\nErro ao ler arquivo, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }

    int tempoT = atoi(Buffer[0]);
    int NEmp = atoi(Buffer[1]);
    int NExp = atoi(Buffer[2]);
    i = 3;
    inicializaGrafo(grafo, tempoT, NEmp);

    
    int empresa, tempo, lucro, n;
    n = 0;

    //enquanto existir algum experimento
    while(i < NExp)
    {
        //se for o caractere de fim de linha ele nao interessa
        while(strcmp(Buffer[i], "\n") == 0)
        {
            i++;
        }

        empresa = atoi(Buffer[i+1]);
        lucro = atoi(Buffer[i+2]);
        tempo = atoi(Buffer[i+3]);
        adicionaExperimento(grafo, empresa, lucro, tempo, Buffer[i]);
        free(Buffer[i]); free(Buffer[i+1]); free(Buffer[i+2]); free(Buffer[i+3]);
        i += 4;
        n++;
    }

    int V1, V2;
    n = 0;
    //enquanto existir alguma empresa
    while(n < NEmp)
    {
        V1 = atoi(Buffer[i]); V1--;
        free(Buffer[i]);

        //adiciona arestas a V1 enquanto nao mudar de linha
        do
        {
            V2 = atoi(Buffer[i]); V2--;
            free(Buffer[i]);
            InsereAresta(grafo, &V1, &V2);
            i++;
        }while(strcmp(Buffer[i], "\n") != 0);
        n++;
    }
    free(Buffer);
}

void SalvaSaida(long long int configuracoes, double lucro, double tempoGasto, int nExperimentos, char **experimento, char* saida, char *fileTeste)
{
    printf("\n\n%lld", configuracoes);
    printf("\n%f %f\n", lucro, tempoGasto);

    int i;
    for(i = 0; i < nExperimentos; i++)
    {
        printf("%s ", experimento[i]);
    }

    char *string = malloc(sizeof(char) * 50);
    sprintf(string, "%lld \n%f %f\n", configuracoes, lucro, tempoGasto);
    saveFile(saida, string);

    for(i = 0; i < nExperimentos; i++)
    {
        saveFile(saida, experimento[i]);
    }
    free(string);

    string = malloc(sizeof(char) * 50);
    sprintf(string, " %f\n", tempoGasto);
    saveFile(fileTeste, string);
    free(string);
}

void readArgs(int argc, char** argv, char **entrada, char **saida, char **fileTeste, int *algoritmo)
{
    int c; //variavel provisoria para a funcao get opt
    c = 0;

    if(argc < 7)
    {
        printf("Entrada invalida, erro! A entrada deve conter os seguintes parametros: \n"
               "-s <1|2> - indicando qual dos algoritmos deve ser utilizado\n"
               "-i <nome do arquivo de entrada>\n"
               "-o <nome do arquivo de saída>\n"
               "Para mais informaçoes cheque a documentacao\n"
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
