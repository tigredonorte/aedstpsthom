#include "guloso.h"

int coloreGuloso(Grafo *grafo, int maxCores)
{
    int nCores = 0;
    int grau = calculaGrauGrafo(grafo);
    int size = getNumVertices(grafo);
    int *vAux = (int*)malloc(sizeof(int) * size + 1);
    int nVertices = getNumVertices(grafo);
    int i, j, vVer, corVertice, cor, encontrou;

    PLista aux;
    for(i = 0; i < nVertices; i++)
    {
        for(j = 0; j < grau; j++)
        {
            vAux[j] = 0;
        }
        
        aux = getPrimeiroLista(grafo, i);
        while(aux != NULL)
        {
            //insere na fila todas as cores dos vizinhos
            vVer = getValorVertice(aux);
            corVertice = getCorVertice(grafo, vVer);
            if(corVertice != 0)
            {
                vAux[corVertice] = 1;
            }
            aux = aux->Prox;
        }
        cor = 1;
        encontrou = 0;
        for(j = 1; j <= grau && !encontrou; j++)
        {
            if(vAux[j] == 0)
            {
                cor = j;
                encontrou = 1;
            }
        }
        if(cor > maxCores)
        {
            return cor;
        }

        if(nCores < cor)
        {
            nCores = cor;
        }
        //encontrou uma cor satisfatoria, entao colore
        setCorVertice(grafo, i, cor);
    }
    free(aux);
    free(vAux);
    return(nCores);
}
