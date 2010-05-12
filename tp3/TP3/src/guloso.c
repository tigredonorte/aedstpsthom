#include "guloso.h"

void coloreGuloso(Grafo *grafo)
{
    int max = calculaGrauGrafo(grafo);
    int size = getNumVertices(grafo);
    int *vAux = (int*)malloc(sizeof(int) * size + 1);
    int nVertices = getNumVertices(grafo);
    int i;
    
    for(i = 0; i < nVertices; i++)
    {
        int j;
        for(j = 0; j < max; j++)
        {
            vAux[j] = 0;
        }
        
        PLista aux = getPrimeiroLista(grafo, i);
        while(aux != NULL)
        {
            //insere na fila todas as cores dos vizinhos
            int vVer = getValorVertice(aux);
            int corVertice = getCorVertice(grafo, vVer);
            if(corVertice != 0)
            {
                vAux[corVertice] = 1;
            }
            aux = aux->Prox;
        }
        int cor = 1;
        int encontrou = 0;
        for(j = 1; j <= max && !encontrou; j++)
        {
            if(vAux[j] == 0)
            {
                cor = j;
                encontrou = 1;
            }
        }
        //encontrou uma cor satisfatoria, entao colore
        setCorVertice(grafo, i, cor);
    }
}
