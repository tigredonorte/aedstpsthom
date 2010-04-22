/* 
 * File:   main.c
 * Author: thompson
 */

#include <string.h>
#include <sys/resource.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include "file.h"
#include "fila.h"
#include <getopt.h>


#define NUM_ARGS 2 // número mínimo de argumentos

//funcoes de medicao de tempo
void getSystemTime(double *total_time);
long timeOfDay();

//programa principal
int main(int argc, char** argv)
{
    /*
     * Leitura da entrada com Getopt
     */
    char *baseDados;
    char *outFile;
    int numTestes, tamAmostras;
    int c;
    
    while((c = getopt (argc, argv, ":i:s:n:o:")) != -1)
    {
        switch (c)
        {
            case 'i':
                    baseDados = optarg;
                    break;
            case 's':
                    numTestes = atoi(optarg);
                    break;
            case 'n':
                    tamAmostras = atoi(optarg);
                    break;
            case 'o':
                    outFile = optarg;
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

    //estatisticas de tempo de execussao do programa
    long IniTimeOfDay = timeOfDay();
    double IniMachineTime;
    getSystemTime(&IniMachineTime);

    char *buffer, *palavra;//string que guardara o conteudo inteiro do arquivo
    int numDim, numPontos; //guardara o numero de dimensoes e o numero de pontos no arquivo
    Fila fila;
    double *NValues;//guardara todos os valores de estatistica para o calculo de desvio padrao

    //faz a leitura do arquivo
    palavra = leArquivo(baseDados, &buffer );

    //guarda o primeiro numero na variavel numPontos
    numPontos = atoi( palavra );

    //se tiverem mais amostras do que pontos
    if(tamAmostras > numPontos)
    {
        tamAmostras = numPontos;
    }

    /*a partir de agora, cada numero lido sera a proxima palavra do buffer nao imporanto a linha*/
    //guarda o segundo numero do arquivo, numero de dimensoes
    numDim = atoi( proxPalavra(NULL) );

    //inicializa os pontos do arquivo e os coloca em uma estrutura
    leEntrada(&fila, numPontos, numDim);
    
    NValues = malloc(numTestes * sizeof(double));

    //fara numTestes de vezes os testes
    int i;
    for(i = numTestes; i > 0; i--)
    {
        //cria uma amostra da fila original e insere na estrutura
        Fila filaAmostra;
        criaAmostra(&fila, &filaAmostra, numPontos, tamAmostras);

        //gera os pontos e insere na estrutura
        Fila fila2;
        geraPontos(&fila2, tamAmostras, numDim);

        //seta os valores de U e W nas filas
        calculaUW(&fila, &filaAmostra, &fila2, numDim);
        
        double statistic = makeHopkinsStatistic(getU(&filaAmostra), getW(&fila2));

        //valores para serem plotados em um grafico
        writeFile("HStatistc.txt", statistic);
        NValues[i-1] = statistic;
    }
    geraEstatisticas(NValues, numTestes, outFile);

    double FinalMachineTime;
    getSystemTime(&FinalMachineTime);
    long FinalTimeOfDay = timeOfDay();
    FinalTimeOfDay = FinalTimeOfDay - IniTimeOfDay;
    FinalMachineTime = FinalMachineTime - IniMachineTime;
    writeFile("TimeAnalisis.txt", (double)FinalMachineTime);
    writeFile("TimeAnalisis.txt", (double)FinalTimeOfDay);
    return (EXIT_SUCCESS);
}

/* pega o tempo do sistema com a funcao getRusages */
void getSystemTime(double *total_time)
{
    struct rusage resources;
    int    rc;

    if((rc = getrusage(RUSAGE_SELF, &resources)) != 0) perror("getrusage failed");
    double utime, stime;
    utime = (double) resources.ru_utime.tv_sec + 1.e-6 * (double) resources.ru_utime.tv_usec;
    stime = (double) resources.ru_stime.tv_sec + 1.e-6 * (double) resources.ru_stime.tv_usec;
    *total_time = utime+stime;
 }

long timeOfDay()
{
  //char buffer[30];
  struct timeval tv;

  time_t curtime;
  gettimeofday(&tv, NULL);
  curtime=tv.tv_sec;

  return(tv.tv_sec);
  printf("%ld %ld\n",tv.tv_usec, tv.tv_sec);
}