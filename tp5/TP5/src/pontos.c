#include "pontos.h"

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

//inicializa a estrutura de pontos
void inicializaPontos(Pontos *pts, int numPontos, int numDimensoes)
{
    pts->numDimensoes = numDimensoes;
    pts->numPontos = numPontos;

    //aloca vetores
    pts->id = malloc(sizeof(int) * numPontos);
    pts->pontos = malloc(sizeof(double*) * numPontos);
    pts->PProximos = malloc(sizeof(Fila) * numPontos);

    int i,j;
    for(i = 0; i < numPontos; i++)
    {

        pts->id[i] = 0;
        pts->pontos[i] = malloc(sizeof(double) * numDimensoes);
        for(j = 0; j < numDimensoes; j++)
        {
            pts->pontos[i][j] = 0;
        }
        esvaziaFila(&pts->PProximos[i]);
    }
}

void destroiPontos(Pontos *pts)
{
    int i;
    for(i = 0; i < pts->numPontos; i++)
    {
        free(pts->pontos[i]);
        destroiFila(&pts->PProximos[i]);
    }
    free(pts->id);
    free(pts->pontos);
}

void lePontos(Pontos *pts, char *buffer, int firstLine)
{
    double pt = 0;
    int i, j;
    char *pch;

    pch = strtok(buffer, "\n ");
    for(i = 0; i < pts->numPontos && pch != NULL; i++)
    {
        pts->id[i] = (firstLine + i);
        for(j = 0; j < pts->numDimensoes && pch != NULL; j++)
        {
            sscanf(pch,"%lf",&pt);
            pts->pontos[i][j] = pt;
            pch = strtok (NULL, "\n ");
        }
    }
}

void calculaDistanciaPontos(Pontos *pts, double r, int firstLine)
{
    int i,j;
    double distancia = 0;
    for(i = 0; i < pts->numPontos; i++)
    {
        for(j = i+1; j < pts->numPontos; j++)
        {
            distancia = calculaDistancia(pts->pontos[i], pts->pontos[j], pts->numDimensoes);
            if(distancia <= r)
            {
                insereFila(&pts->PProximos[i], (j+ firstLine));
                insereFila(&pts->PProximos[j], (i+ firstLine));
            }
        }
    }
}
