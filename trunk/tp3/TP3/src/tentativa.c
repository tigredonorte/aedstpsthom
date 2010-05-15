#include "tentativa.h"

int coloreTentativa(Grafo *grafo, long long *tentativas)
{
    int size = getNumVertices(grafo);
    long long fat = fatorial(size);
    long long k = 0;
    long long tent = 0;
    int cores = size;
    int cor;
    int *ordem = malloc(sizeof(int) * size);

    for(k = 0; k < fat; k++)
    {
        cor = 0;
        tent = 0;

        descoloreGrafo(grafo);
        ordem = Factoradic(size, k);
        cor = coloreGulosoTentativa(grafo, size, ordem, &tent);
        (*tentativas) += tent;
        if(cores > cor)
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

int* Factoradic(int size, long long k)
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
        temp[i] = perm[i];
    }

    free(factoradic);
    free(temp);
    return(perm);
}


int coloreGulosoTentativa(Grafo *grafo, int maxCores, int *ordem, long long *tentativas)
{
    int nCores = 0;
    int grau = calculaGrauGrafo(grafo);
    int size = getNumVertices(grafo);
    int *vAux = (int*)malloc(sizeof(int) * size + 1);
    int nVertices = getNumVertices(grafo);
    int i, j, vVer, corVertice, cor, encontrou;

    PLista aux;
    grau++; //o maior numero de cores eh o grau do grafo + 1

    //varrera todos os vertices
    for(i = 0; i < nVertices; i++)
    {
        //zera o vetor auxiliar, que ira conter as cores ja preenchidas
        for(j = 0; j < grau; j++)
        {
            vAux[j] = 0;
        }

        //varrera as arestas do vertice i
        aux = getPrimeiroLista(grafo, ordem[i]);
        while(aux != NULL)
        {
            //insere no vetor todas as cores dos vizinhos ja preenchidas
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
            //a cada iteracao ele tenta uma nova cor
            (*tentativas)++;

            //procura pela menor cor nao usada
            if(vAux[j] == 0)
            {
                cor = j;
                encontrou = 1;
            }
        }

        //se ultrapassou o limite de cores a serem usadas
        if(cor > maxCores)
        {
            return nCores;
        }

        //guarda o maior numero de cores
        if(nCores < cor)
        {
            nCores = cor;
        }
        //encontrou uma cor satisfatoria, entao colore
        setCorVertice(grafo, ordem[i], cor);
    }
    free(aux);
    free(vAux);
    return(nCores);
}
