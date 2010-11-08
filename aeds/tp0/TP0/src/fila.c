
#include <stdlib.h>

#include "fila.h"

//Esvazia fila
void esvaziaFila(Fila *fila)
{
    fila->frente = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->frente;
    fila->frente->prox = NULL;
}

//insere novo elemento na fila
void insereFila(FItem it, Fila *fila)
{
    fila->tras->prox = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->tras->prox;
    fila->tras->item = it;
    fila->tras->prox = NULL;
}

void insertElement(Fila *fila, PFila cel1)
{
    FItem it= cel1->item;
    insereFila(it, fila);
}

//inicializa um novo item
void inicializaItem(double *P, FItem *item)
{
    item->ponto = malloc(sizeof(&P));
    item->ponto = P;

    //distancia inicializada com um valor impossivel de ocorrer
    item->distU = -1;
    item->distW = -1;
}

//Calcula distancia euclidiana entre dois pontos P e Q
double calculaDistancia(Ponto P, Ponto Q, int numDim)
{
    int i;
    double value = 0;
    for(i=0 ; i < numDim; i++)
    {
        value += (P[i] - Q[i])*(P[i] - Q[i]);
    }
    value = sqrt(value);
    return(value);
}

//recebe duas celula e envia o valor dos seus pontos para o calculo da distancia euclidiana
double calculaDistanciaCel(PFila cel1, PFila cel2, int numDim)
{
    return(calculaDistancia(cel1->item.ponto,cel2->item.ponto,numDim));
}

//seta o valor W de uma celula
void setW(PFila cel1, double dist)
{
    //se a celula nao foi iniciada,ou se o o valor guardado e maior do que o valor de parametro
    if(cel1->item.distW > dist || cel1->item.distW == -1)
    {
        cel1->item.distW = dist;
    }
}

//seta o valor U de uma celula
void setU(PFila cel1, double dist)
{
    //se a celula nao foi iniciada,ou se o o valor guardado e maior do que o valor de parametro
    if(cel1->item.distU > dist || cel1->item.distU == -1)
    {
        cel1->item.distU = dist;
    }
}

//retorna 1 se a celula for igual ao ultimo elemento da fila
int isLastElement(Fila *fila, PFila cel1)
{
    return(fila->tras == cel1);
}

//copia o valor do primeiro elemento da fila para a celula
void getFirstElement(Fila *fila, PFila *cel1)
{
    *cel1 = fila->frente->prox;
}

//copia o proximo elemento da celula
void getNextElement(PFila *cel1)
{
    if((*cel1)->prox != NULL)
    {
       (*cel1) = (*cel1)->prox;
    }
    else
    {
        (*cel1) = NULL;
    }
}

//gera uma fila com tamanhoAmostras pontos
void geraPontos(Fila *fila, int tamanhoAmostras, int numDim)
{
   //inicializa a fila
    esvaziaFila(fila);

    int i, j;
    

    //sorteia um numero entre 0 e 1 e insere na fila passada por parametro
    for(i = 0; i < tamanhoAmostras; i++)
    {
        //aloca um vetor de double
        double *P;
        P = malloc(numDim * sizeof(double));
        
        for(j = 0; j < numDim; j++)
        {
            P[j] = 0;
            P[j] = drand48();
        }
        FItem item;
        inicializaItem(P, &item);
        insereFila(item, fila);
    }
}

void leEntrada(Fila *fila, int numPontos, int numDim)
{
    int i, j;

    esvaziaFila(fila);
    for(i = 0; i < numPontos; i++)
    {
        //cria um vetor auxiliar de double, responsavel por guardar as coordenadas dos pontos do arquivo
        double *P;
        P = malloc(numDim * sizeof(double));
        
        for(j = 0; j < numDim; j++)
        {
            P[j] = 0;
            P[j] = atof(proxPalavra(NULL));
        }

        FItem item;
        inicializaItem(P, &item);
        insereFila(item, fila);
    }
}

double getU(Fila *fila)
{
    PFila cel = fila->frente;
    double total;
    while(cel != fila->tras)
    {
        total += cel->item.distU;
        cel = cel->prox;
    }
    return total;
}

double getW(Fila *fila)
{
    PFila cel = fila->frente;
    double total = 0;
    while(cel != fila->tras)
    {
        total += cel->item.distW;
        cel = cel->prox;
    }
    return total;
}

double makeHopkinsStatistic(double U, double W)
{
    return(U/(U + W) );
}

//cria uma amostra a partir da fila src e devolve em filaDst
void criaAmostra(Fila *fsrc, Fila *fdst, int numPontos, int tamAmostras)
{
    //ponteiro que contem uma posicao da fila original
    PFila cel1;
    getFirstElement(fsrc, &cel1);

    //guardara uma amostra do arquivo de entrada
    esvaziaFila(fdst);

    //o lote sera utilizado para escolher um valor randomico dentro de uma
    //faixa de pontos no arquivo (a escolha sera uma por lote)
    int lote = (int)numPontos/tamAmostras;

    /*Varre a fila gerada pelo arquivo sorteanto um valor a cada N elementos N = lote*/
    int j;
    for(j = tamAmostras; j > 0; j--)
    {
        int k, l;
        //gera um numero entre 1 e lote
        k = rand() % lote;

        //complemento de k em relacao a l
        l = lote - k;
        while(k-- > 0)
        {
            getNextElement(&cel1);
        }

        insertElement(fdst, cel1);

        //termina de percorrer o lote
        while(l-- > 0)
        {
            getNextElement(&cel1);
        }
    }
}

void calculaUW(Fila *filaAmostra, Fila *filaGerada, int numDim)
{
    //elementos que percorrerao a fila
    PFila cel1, cel2;
    getFirstElement(filaAmostra, &cel1);
    getFirstElement(filaGerada, &cel2);

    //descobrindo a menor distancia entre gerados e entrada(U)
    int flag = 0;
    while(!flag)
    {
        double dist = 0;
        dist = calculaDistanciaCel(cel1, cel2, numDim);
        setW(cel2, dist);
        if(isLastElement(filaGerada, cel2))
        {
            getFirstElement(filaGerada, &cel2);
            if(!isLastElement(filaAmostra, cel1))
            {
                getNextElement(&cel1);
            }
            else{flag = 1;}
        }
        else{getNextElement(&cel2);}
    }



    getFirstElement(filaAmostra, &cel1);
    cel2 = cel1;
    getNextElement(&cel2);


    //descobrindo a menor distancia entre a entrada(W)
    flag = 0;
    while(!flag)
    {
        double dist;
        dist = calculaDistanciaCel(cel1, cel2, numDim);
        setU(cel1, dist);
        if(isLastElement(filaAmostra, cel2))
        {
            getFirstElement(filaAmostra, &cel2);
            if(!isLastElement(filaAmostra, cel1))
            {
                getNextElement(&cel1);
            }
            else{flag = 1;}
        }
        else{getNextElement(&cel2);}
    }
}

//gera as estatisticas finais do programa
void geraEstatisticas(double *NValues, int numTestes, char *file)
{
    double minValue = 2;
    double maxValue = -1;
    double mediumValue = 0;
    double desvio = 0;

    int i;
    for(i = 0; i < numTestes; i++)
    {
        mediumValue += NValues[i];
    }

    mediumValue = mediumValue/numTestes;
    for(i = 0; i < numTestes; i++)
    {
        if(minValue > NValues[i]) minValue = NValues[i];
        if(maxValue < NValues[i]) maxValue = NValues[i];
        desvio += (NValues[i] - mediumValue)*(NValues[i] - mediumValue);
    }
    desvio = sqrt(desvio);
    writeFile(file, minValue);
    writeFile(file, maxValue);
    writeFile(file, mediumValue);
    writeFile(file, desvio);
}