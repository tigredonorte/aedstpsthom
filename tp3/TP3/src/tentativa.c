
#include "grafo.h"

#include "tentativa.h"

int coloreTentativa(Grafo *grafo)
{
    int size = getNumVertices(grafo);
    int grau = calculaGrauGrafo(grafo);
    long long fat = fatorial(size);
    int cores = grau + 1;
    int cor;

    Grafo *grafoDst = malloc(sizeof(Grafo));
    inicializaGrafo(grafoDst, getNumArestas(grafo), size);
    long long k = 0;
    
    for(k = 0; k < fat; k++)
    {
        copiaGrafo(grafo, grafoDst);
        Factoradic(grafo, &grafoDst, size, k);
        
        cor = coloreGuloso(grafo, cores);
        if(cor < cores)
        {
            cores = cor;
        }
    }
    return cores;
}

long long fatorial(int n)
{
    int i;
    long long fat;
    fat = 1;
    for(i = 1; i < n+1; i++)
    {
        fat = i*fat;
    }
    return fat;
}

void Factoradic(Grafo *grafoSrc, Grafo **grafoDst, int size, long long k)
{
    int i, j;

    //procura a k-esima permutaçao de um vetor qualquer
    int *factoradic = malloc(sizeof(int) *size);
    for (j = 1; j <= size; j++)
    {
        factoradic[size - j] = k % j;
        k /= j;
    }

    //converte o fatoradic em uma chave numerica para calcular o elemento a ser realmente permutado
    int *temp = malloc(sizeof(int) *size);
    int *perm = malloc(sizeof(int) *size);
    for(i = 0; i < size; i++)
    {
        temp[i] = ++factoradic[i];
    }


    perm[size - 1] = 1;  //condicao de contorno, para que o ultimo elemento seja o menor
    for (i = size - 2; i >= 0; i--)
    {
        perm[i] = temp[i];

        //permutacao dos elementos a frente de i
        for (j = i + 1; j < size; j++)
        {
            if (perm[j] >= perm[i])
            {
                perm[j]++;
            }
        }
    }

    //retira uma unidade dos fatores para que o menor elemento seja 0 e o maior size - 1
    //obviamente todos os elementos terao uma unidade diminuida
    for (i = 0; i < size; ++i)
    {
        perm[i]--;
    }

    //permuta o vetor fonte para o vetor destino
    for (i = 0; i < size; ++i)
    {
        (*grafoDst)->Adj[i] = grafoSrc->Adj[perm[i]];
    }
    free(perm);
    free(temp);
    free(factoradic);
}