#include "tentativa.h"

void calculaConfiguracaoTentativa(Grafo *grafo)
{
    int size = getNumVertices(grafo);
    Fila fila;
    esvaziaFila(&fila);

    double valor = 0;
    bronKerbosch(grafo->Mat, size, &fila);
    calculaMochilaTentativa(grafo, &fila, &valor, size);
}

void calculaMochilaTentativa(Grafo *grafo, Fila *fila, double *valor, int size)
{
    FItem it;
    int *clique = malloc(sizeof(int) * size);
    int *Melhor = malloc(sizeof(int) * size);
    Experimento *exp = malloc(sizeof(Experimento) * size);
    int i;
    
    //printf("\n--numero de cliques-- %d\n", fila.tamanho);
    //getc(stdin);
    
    double lucro = 0;
    double lucroMelhor = 0;
    double tempo = getTempo(grafo);

    while(!ehVaziaFila(fila))
    {
        retiraFila(fila, &it);
        size = it.size;

        //printf("\n--clique-- %d\n", size);
        for(i = 0; i < size; i++)
        {
            exp[i] = grafo->Exp[clique[i]];
        }
        lucro = calculaMochilaGuloso(&exp, tempo, size);
        if(lucro > lucroMelhor)
        {
            lucroMelhor = lucro;
            for(i = 0; i < size; i++)
            {
                Melhor[i] = exp[i].experimento;
            }
        }
    }
    *valor = lucroMelhor;
}

void bronKerbosch(int** adjMatrix, int size, Fila *fila)
{
    int* ALL = malloc(sizeof(int) * size);
    int* actualMD = malloc(sizeof(int) * size);
    int* best = malloc(sizeof(int) * size);
    
    int i;
    for (i = 0; i < size; i++)
    {
        ALL[i] = i;
        actualMD[i] = -1;
        best[i] = -1;
    }
    encontraCliquesTentativa(adjMatrix, ALL, 0, size, actualMD, best, &size, &size, fila);

    free(ALL);
    free(actualMD);
    free(best);
}



void encontraCliquesTentativa(int **adjMatrix, int* oldMD, int oldTestedSize, int oldCandidateSize, int *actualMD, int *best, int *actualMDSize, int *bestSize, Fila *fila)
{
    int* actualCandidates = (int*)malloc(sizeof(int) * oldCandidateSize);
    int nod = 0;
    int fixp = 0;
    int actualCandidateSize = 0;
    int actualTestedSize = 0;
    int i = 0;
    int j = 0;
    int count = 0;
    int pos = 0;
    int p = 0;
    int s = 0;
    int sel = 0;
    int index2Tested = 0;
    int fini = 0;
    int aux = 0;
    index2Tested = oldCandidateSize;

    //avalia os candidatos a clique ex: se uma coluna tem varios zeros e uns, aquelas que possuem '0' nao sao candidatas a clique
    for (i = 0; (i < oldCandidateSize) && (index2Tested != 0); i++)
    {
        p = oldMD[i];
        count = 0;

        //branch: procura pelos candidatos
        for (j = oldTestedSize; (j < oldCandidateSize) && (count < index2Tested); j++)
        {
            aux = adjMatrix[p][oldMD[j]];
            if (aux == 0)
            {
                ///posicao de um possivel candidato
                pos = j;
                count++; 
            }
        }

        // Test new minimum
        if (count < index2Tested)
        {
            fixp = p;
            index2Tested = count;

            if (i < oldTestedSize)
            {
                s = pos;
            }
            else
            {
                s = i;
                nod = 1;
            }
        }
    }

    // If fixed point initially chosen from candidates then
    // number of diconnections will be preincreased by one
    // Backtracking step for all nodes in the candidate list CD
    for (nod = index2Tested + nod; nod >= 1; nod--)
    {
        // Interchange
        p = oldMD[s];
        oldMD[s] = oldMD[oldTestedSize];
        sel = oldMD[oldTestedSize] = p;

        // Fill new set "not"
        actualCandidateSize = 0;

        for (i = 0; i < oldTestedSize; i++)
        {
            if (adjMatrix[sel][oldMD[i]] != 0)
            {
                actualCandidates[actualCandidateSize++] = oldMD[i];
            }
        }

        // Fill new set "candidates"
        actualTestedSize = actualCandidateSize;

        for (i = oldTestedSize + 1; i < oldCandidateSize; i++)
        {
            if (adjMatrix[sel][oldMD[i]] != 0)
            {
                actualCandidates[actualTestedSize++] = oldMD[i];
            }
        }

        // Add to "actual relevant nodes"
        actualMD[(*actualMDSize)++] = sel;

        // so CD+1 and ND+1 are empty
        if (actualTestedSize == 0)
        {
            if ((*bestSize) < (*actualMDSize))
            {
                // found a max clique
                for(i = 0; i < (*bestSize); i++)
                {
                    actualMD[i] = best[i];
                }
            }

            int sz = 0;
            //procura no vetor somente os numeros que interessao (para alocar menor espaco)
            for(i = 0; i < (*actualMDSize); i++)
            {
                if(actualMD[i] > -1)
                {
                    sz++;
                }
            }
            //copia o vetor
            int* tmpResult = malloc(sizeof(int) * sz);
            int k = 0;
            for(i = 0; i < (*actualMDSize); i++)
            {
                if(actualMD[i] > -1)
                {
                    tmpResult[k] = actualMD[i];
                    k++;
                }
            }

            addClique(&tmpResult, sz, fila);
            free(tmpResult);
        }
        else
        {
            if (actualCandidateSize < actualTestedSize)
            {
                encontraCliquesTentativa(adjMatrix, actualCandidates, actualCandidateSize, actualTestedSize, actualMD, best, actualMDSize, bestSize, fila);
            }
        }

        if (fini)
        {
            break;
        }

        // move node from MD to ND
        // Remove from compsub
        (*actualMDSize)--;

        // Add to "nod"
        oldTestedSize++;

        if (nod > 1)
        {
            // Select a candidate disconnected to the fixed point
            for (s = oldTestedSize; adjMatrix[fixp][oldMD[s]] != 0; s++){}
        }

        // end selection
    }

    // Backtrackcycle
    free(actualCandidates);
}

void addClique(int **clique, int size, Fila *fila)
{
    FItem it;
    inicializaItem(&it, clique, size);
    insereFila(it, fila);
}
