#include "interface.h"

void setEntradaGrafo(Grafo *grafo, char *entrada)
{
    Grafo grafoEmp;
    char **Buffer;
    int i = 0;
    int size;
    Buffer = leArquivo(entrada, &size);
    if(Buffer == NULL)
    {
        printf("\nErro ao ler arquivo, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }

    double tempoT = atoi(Buffer[0]);
    int NEmp = atoi(Buffer[1]);
    int NExp = atoi(Buffer[2]);
    i = 3;

    //operacoes com o grafo de experimentos
    inicializaGrafo(grafo, tempoT, NExp);
    FGVazio(grafo);
    MontaGrafoExperimentos(grafo, Buffer, NExp, &i);

    //operacoes com o grafo de empresas
    inicializaGrafo(&grafoEmp, tempoT, NEmp);
    FGVazio(&grafoEmp);
    MontaGrafoEmpresas(&grafoEmp, Buffer, NEmp, &i, size);
    GrafoComplementar(&grafoEmp);

    //adiciona os experimentos que podem ser feitos simultaneamente
    GrafoMergeRelacoes(grafo, &grafoEmp);

    LiberaBuffer(Buffer, size);
    LiberaGrafo(&grafoEmp);
}

void MontaGrafoEmpresas(Grafo *grafo, char **Buffer, int NEmp, int *id, int size)
{
    int V1, V2, i;
    int n = 0;
    i = (*id);

    //enquanto existir alguma empresa
    while(n < NEmp)
    {
        while(strcmp(Buffer[i], "e") == 0)
        {
            i++;
        }

        V1 = atoi(Buffer[i]);
        i++;
        //adiciona arestas a V1 enquanto nao mudar de linha
        while(strcmp(Buffer[i], "e") != 0 && i < (size - 1))
        {
            V2 = atoi(Buffer[i]);
            InsereAresta(grafo, V1, V2);
            i++;
        }
        n++;
    }
    (*id) = i;
}

void MontaGrafoExperimentos(Grafo *grafo, char **Buffer, int NExp, int *id)
{
    int empresa, experimento, i;
    double tempo, lucro;

    i = (*id);
    int q = 0; //quantidade de experimentos ja adicionados
    //enquanto existir algum experimento
    while(q < NExp)
    {
        while(strcmp(Buffer[i], "e") == 0)
        {
            i++;
        }

        //leitura dos dados do arquivo
        experimento = atoi(Buffer[i]);
        empresa = atoi(Buffer[i+1]);
        lucro = atof(Buffer[i+2]);
        tempo = atof(Buffer[i+3]);

        //insercao dos dados na estrutura
        InsereAresta(grafo, experimento, experimento);
        insereExperimento(grafo, experimento, empresa, lucro, tempo);

        //incrementa id do buffer e quantidade de experimentos
        i += 4;
        q++;
    }

    (*id) = i;
}

void SalvaSaida(char *saida, long long int configuracoes, double lucro, double tempoGasto, int size, int *experimento, char *fileTeste, double tempoFinal)
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
    
    //salva estatisticas no arquivo
    string = malloc(sizeof(char) * 50);
    sprintf(string, " %f\n", tempoGasto);
    saveFile(fileTeste, string);

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
