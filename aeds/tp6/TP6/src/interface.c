#include "interface.h"

void inicializaSaida(DataOut *datao)
{
    esvaziaFila(&datao->fila);
}

void leEntrada(DataIn *data)
{
    long lSize = 5;
    char * buffer;

    fread(buffer, 1, lSize, stdin);
}

void SalvaSaida(DataOut *datao)
{
    imprimeFila(&datao->fila);
}

void readArgs(int argc, char** argv, DataIn *data)
{
    int c; //variavel provisoria para a funcao get opt
    c = 0;

    if(argc < 7)
    {
        printf("Entrada invalida, erro! A entrada deve conter os seguintes parametros: \n"
               "-p string a ser comparada \n"
               "-k tolerancia da distancia entre caracteres \n"
               "-s Política a ser utilizada.\n");
       exit(EXIT_FAILURE);
    }
    char *S;
    S = malloc(sizeof(char) * 3);
    data->S = SA;
    while((c = getopt (argc, argv, ":p:k:s:")) != -1)
    {
        switch (c)
        {
           case 'p':
                    data->P = optarg;
                    break;
           case 'k':
                    data->K = atoi(optarg);
                    break;
           case 's':
                    S = optarg;
                    if(strcmp(S, "fb") == 0) data->S = FB;
                    break;
           case '?':
                    printf("Parametros de entrada incorretos, por favor cheque a documentacao para mais informacoes\n"
                            "o programa sera fechado\n");
                    exit(EXIT_FAILURE);
           default:
           abort ();
        }
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
