#include "interface.h"


void leEntrada(DataIn *data)
{
    long tamPagina = 0;
    long pageBegin = 0;
    char *buffer;
    
    readFirstLine(data->IEntrada, &buffer, &pageBegin);
    free(buffer);
    buffer = malloc(sizeof(char*));

    tamPagina = sizePage(data->IEntrada, data->NPaginas);
}
 

void SalvaSaida(DataIn *data, DataOut *datao)
{
    char *string = malloc(sizeof(char) * 50);
    int i, id, size;
    PFila aux;

    size = data->KPontos;
    //imprime saida na tela e salva no arquivo
    printf("%d\n", datao->substituicoes);
    sprintf(string, "%d\n", datao->substituicoes);
    saveFile(data->OSaida, string);

    for(i = 0; i < size; i++)
    {
        id = getId(&datao->fila[i]);
        printf("%d ", id);
        sprintf(string, "%d ", datao->substituicoes);
        saveFile(data->OSaida, string);

        aux = NULL;
        getProxFila(&datao->fila[i], aux);
        while(aux != NULL)
        {
            id = getIdItem(aux);
            printf("%d ", id);
            sprintf(string, "%d ", id);
            saveFile(data->OSaida, string);
        }
        printf("\n");
        sprintf(string, "\n");
        saveFile(data->OSaida, string);
    }
    printf("\n\n");
    
    if(string){free(string);}
}

void readArgs(int argc, char** argv, DataIn *data)
{
    int c; //variavel provisoria para a funcao get opt
    c = 0;

    if(argc < 15)
    {
        printf("Entrada invalida, erro! A entrada deve conter os seguintes parametros: \n"
               "-i Arquivo de entrada. \n"
               "-c Tamanho da cache, em MegaBytes. \n"
               "-s Política de substituição a ser utilizada (-s).\n"
               "-n Número de páginas usadas (-n).\n"
               "-r Valor do parametro R (-r)\n"
               "-k Valor do parametro K (-k)\n"
               "-o Arquivo de saída (-o)");
       exit(EXIT_FAILURE);
    }
    int t = 0;

    while((c = getopt (argc, argv, ":i:c:s:n:r:k:o:t:")) != -1)
    {
        switch (c)
        {
           case 'i':
                    data->IEntrada = optarg;
                    break;
           case 'c':
                    data->CTamanho = atoi(optarg);
                    break;
           case 's':
                    data->SPolitica = atoi(optarg);
                    break;
           case 'n':
                    data->NPaginas = atoi(optarg);
                    break;
           case 'r':
                    data->RRaio = atoi(optarg);
                    break;
           case 'k':
                    data->KPontos = atoi(optarg);
                    break;
           case 'o':
                    data->OSaida = optarg;
                    break;
           case 't':
                    t = 1;
                    data->TTeste = optarg;
                    break;
            case '?':
                     printf("Parametros de entrada incorretos, por favor cheque a documentacao para mais informacoes\n"
                            "o programa sera fechado\n");
                    exit(EXIT_FAILURE);
            default:
            abort ();
        }
    }
    if(t == 0)
    {
        data->TTeste = malloc(sizeof(char) * 10);
        strcpy(data->TTeste,"saida.ods");
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
