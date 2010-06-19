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
void inicializaPagina(Pagina *pts, int numPontos, int numDimensoes)
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

void destroiPagina(Pagina *pts)
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

void copiaPagina(Pagina *src, Pagina *dst)
{
    dst->id = src->id;
    dst->PProximos = src->PProximos;
    dst->numDimensoes = src->numDimensoes;
    dst->numPontos = src->numPontos;
    dst->pontos = src->pontos;
}

void lePontos(Pagina *pts, char *buffer, int firstLine)
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

void calculaDistanciaPontos(Pagina *pts, double r, int firstLine, int k, int *numK)
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
                (*numK)++;
                insereFila(&pts->PProximos[i], (j+ firstLine));
                insereFila(&pts->PProximos[j], (i+ firstLine));
            }
            if(k == (*numK))
            {
                return;
            }
        }
    }
}

void calculaDistanciaDuasPagina(Pagina *pagSrc, Pagina *pagDst, double r, int firstLineI, int firstLineJ, int k, int *numK)
{
    int i,j;
    double distancia = 0;
    for(i = 0; i < pagSrc->numPontos; i++)
    {
        for(j = 0; j < pagDst->numPontos; j++)
        {
            distancia = calculaDistancia(pagSrc->pontos[i], pagDst->pontos[j], pagSrc->numDimensoes);
            if(distancia <= r)
            {
                (*numK)++;
                insereFila(&pagSrc->PProximos[i], (j+ firstLineJ));
                insereFila(&pagDst->PProximos[j], (i+ firstLineI));
            }
            if(k == (*numK))
            {
                return;
            }
        }
    }
}
