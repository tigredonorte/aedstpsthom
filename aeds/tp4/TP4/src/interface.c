#include "interface.h"

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

void SalvaSaida(char *saida, long long int configuracoes, double lucro, double tempoGasto, int size, int *experimento)
{
    //imprime saida na tela
    printf("\n\n%lld", configuracoes);
    printf("\n%f %f\n", lucro, tempoGasto);
    int i;
    for(i = 0; i < size; i++)
    {
        printf("Exp%d ", experimento[i]);
    }
    printf("\n\n");

    //salva saida no arquivo
    char *string = malloc(sizeof(char) * 50);
    sprintf(string, "%lld \n%f %f\n", configuracoes, lucro, tempoGasto);
    saveFile(saida, string);
    if(string){free(string);}
    string = malloc(sizeof(char) * 5);
    for(i = 0; i < size; i++)
    {
        sprintf(string, "Exp%d ", experimento[i]);
        saveFile(saida, string);
    }

    if(string){free(string);}
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
