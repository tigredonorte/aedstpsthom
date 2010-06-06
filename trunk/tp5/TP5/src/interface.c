#include "interface.h"

/*
void setEntradaGrafo(Grafo *grafo, char *entrada)
{
    Grafo grafoEmp;

    FILE *arquivo;
    arquivo = fopen(entrada, "r");
    if(arquivo == NULL)
    {
        printf("\nErro ao ler arquivo, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }


    double tempoT;
    int NEmp, NExp;

    // (tempo total, num empresas, num experimentos)
    if( fscanf(arquivo, "%lf %d %d", &tempoT, &NEmp, &NExp) != 3 )
    {
        printf("\nEntrada com formato invalido! A primeira linha deve conter 3 numeros, como na documentacao\n");
        exit(EXIT_FAILURE);
    }

    //operacoes com o grafo de experimentos
    inicializaGrafo(grafo, tempoT, NExp);
    FGVazio(grafo);


    //monta grafo de experimentos
    int empresa, experimento;
    double tempo, lucro;
    int i;

    for(i = 0; i < NExp; i++)
    {
        if( fscanf(arquivo, "%d %d %lf %lf", &experimento, &empresa, &lucro, &tempo) != 4 )
        {
            printf("Erro ao na leitura de arquivo, ele nao esta nos padroes especificados");
            exit(EXIT_FAILURE);
        }
        //insercao dos dados na estrutura
        InsereAresta(grafo, experimento, experimento);
        insereExperimento(grafo, experimento, empresa, lucro, tempo);
    }


    //operacoes com o grafo de empresas
    inicializaGrafo(&grafoEmp, tempoT, NEmp);
    FGVazio(&grafoEmp);

    //monta o grafo de empresas
    int V1, V2;
    char chr;
    for(i = 0; i < NEmp; i++)
    {
        if(fscanf( arquivo, "%d", &V1 ) != 1)
        {
            printf("Erro ao na leitura de arquivo, ele nao esta nos padroes especificados");
            exit(EXIT_FAILURE);
        }

        //ler uma linha
        while( (chr = fgetc(arquivo)) != '\n' )
        {
            if( feof(arquivo) )
            {
                break;
            }
            if( isdigit(chr) )
            {
                ungetc(chr, arquivo);
                if(fscanf(arquivo, "%d", &V2) != 1)
                {
                    printf("Erro ao na leitura de arquivo, ele nao esta nos padroes especificados");
                    exit(EXIT_FAILURE);
                }
                InsereAresta(&grafoEmp, V1, V2);
            }
        }
    }
    GrafoComplementar(&grafoEmp);

    //adiciona os experimentos que podem ser feitos simultaneamente
    GrafoMergeRelacoes(grafo, &grafoEmp);
    LiberaGrafo(&grafoEmp);
}
 */

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

    if(argc < 7)
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

    while((c = getopt (argc, argv, ":s:i:o:t:")) != -1)
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
                     printf("Parametros de entrada incorretos, por favor cheque o arquivo leiame.txt para mais informacoes\n"
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
