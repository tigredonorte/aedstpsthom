#include "interface.h"

void inicializaDataOut(DataOut *datao, int numPontos)
{
    datao->fila = malloc(sizeof(Fila) * numPontos);
    datao->substituicoes = 0;
    datao->tempo = 0;
    datao->numPontos = numPontos;

    int i;
    for(i = 0; i < numPontos; i++)
    {
        esvaziaFila(&datao->fila[i], i);
    }
}

void destroiDataOut(DataOut *datao)
{
    int i;
    for(i = 0; i < datao->numPontos; i++)
    {
        destroiFila(&datao->fila[i]);
    }
    free(datao->fila);
}

void leEntrada(DataIn *data, Mapa *map, Buffer *buffer)
{
    //le a primeira linha do arquivo
    int numPontos, numDim, PPPagina, PagsBuffer;
    readFirstLine(data->IEntrada, &numPontos, &numDim);

    if(data->CTamanho == 0)
    {
        PagsBuffer = 1;
        PPPagina = numPontos;
    }
    else
    {
        if(data->NPaginas == 0) data->NPaginas = 1;

        //descobre o numero de pontos que cabera em uma pagina
        double arredonda = (double)numPontos/data->NPaginas;
        PPPagina = (int)arredonda;
        if(arredonda > PPPagina) PPPagina++;

        int temp = sizeof(double);
        //inicializa o buffer
        arredonda = (double)(data->CTamanho*1024*1024)/(temp *PPPagina * numDim);
        PagsBuffer = (int)arredonda;
        if(arredonda > PagsBuffer) PagsBuffer++;
        if(PagsBuffer > data->NPaginas) PagsBuffer = data->NPaginas;
    }
    
    inicializaBuffer(buffer, PagsBuffer, PPPagina, numDim);

    //mapeia o arquivo de entrada na estrutura map
    mapeiaArquivo(map, numPontos, PPPagina, data->IEntrada, &data->NPaginas);
}
 

void SalvaSaida(DataIn *data, DataOut *datao)
{
    char *string = malloc(sizeof(char) * 50);
    int i, id, size;
    PFila aux;


    // size = data->KPontos;,
    size = datao->numPontos;
    //imprime saida na tela e salva no arquivo
    printf("Trocas de Pagina: %d\n", datao->substituicoes);
    sprintf(string, "Trocas de Pagina: %d\n", datao->substituicoes);
    saveFile(data->OSaida, string);

    printf("Tempo gasto na execussao: %lf\n", datao->tempo);
    sprintf(string, "Tempo gasto na execussao: %lf\n", datao->tempo);
    saveFile(data->OSaida, string);

    int fsize;
    for(i = 0; i < size; i++)
    {
        
        id = getId(&datao->fila[i]);
        printf("%d ", id);
        sprintf(string, "%d ", datao->substituicoes);
        saveFile(data->OSaida, string);

        fsize = getSizeFila(&datao->fila[i]);
        if(fsize > 0)
        {
            aux = NULL;
            getProxFila(&datao->fila[i], &aux);
            while(aux != NULL)
            {
                id = getIdItem(aux);
                printf("%d ", id);
                sprintf(string, "%d ", id);
                saveFile(data->OSaida, string);
                getProxFila(&datao->fila[i], &aux);
            }
        }
        printf("\n");
        sprintf(string, "\n");
        saveFile(data->OSaida, string);
    }
    printf("\n\n");
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
                    data->RRaio = atof(optarg);
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

void desalocaVariaveis(DataOut *datao, Mapa *map, Buffer *buffer)
{
    destroiDataOut(datao);
    desalocaMapa(map);
    destroiBuffer(buffer);
}
