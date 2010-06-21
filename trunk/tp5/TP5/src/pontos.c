#include "pontos.h"

double calculaDistancia(Ponto P, Ponto Q, int numDim)
{
    double temp1, temp2;
    int i;
    double value = 0;
    for(i=0 ; i < numDim; i++)
    {
        temp1 = P[i];
        temp2 = Q[i];

        temp2 = temp2 - temp1;
        temp1 = temp2*temp2;
        value += temp1;
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

    int i,j;
    for(i = 0; i < numPontos; i++)
    {

        pts->id[i] = 0;
        pts->pontos[i] = malloc(sizeof(double) * numDimensoes);
        for(j = 0; j < numDimensoes; j++)
        {
            pts->pontos[i][j] = 0;
        }
    }
}

void destroiPagina(Pagina *pts)
{
    int i;
    for(i = 0; i < pts->numPontos; i++)
    {
        free(pts->pontos[i]);
    }
    free(pts->id);
    free(pts->pontos);
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

void calculaDistanciaPontos(Pagina *pts, double r, int firstLine, int k, int *numK, Fila **fila)
{
    int i,j, nk;
    nk = (*numK);
    double distancia = 0;

    for(i = 0; i < pts->numPontos; i++)
    {
        for(j = i+1; j < pts->numPontos; j++)
        {
            distancia = calculaDistancia(pts->pontos[i], pts->pontos[j], pts->numDimensoes);
            if(distancia <= r)
            {
                nk++;
                (*numK)++;
                insereFila(&(*fila)[firstLine + j], (i+ firstLine));
                if(i != j)
                {
                    insereFila(&(*fila)[firstLine + i], (j+ firstLine));
                }
            }
            if(k == (*numK))
            {
                return;
            }
        }
    }
}

void calculaDistanciaDuasPagina(Pagina *pagSrc, Pagina *pagDst, double r, int firstLineI, int firstLineJ, int k, int *numK, Fila **fila)
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
                //se nao estou comparando o mesmo ponto
                if((firstLineJ + j) != (i+ firstLineI))
                {
                    (*numK)++;
                    insereFila(&(*fila)[firstLineJ + j], (i+ firstLineI));
                    if(firstLineI != firstLineJ)
                    {
                        insereFila(&(*fila)[firstLineI + i], (j+ firstLineJ));
                    }
                }
            }
            if(k == (*numK))
            {
                return;
            }
        }
    }
}
