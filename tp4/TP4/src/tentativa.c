#include "tentativa.h"

int findCliques(int** connected, int size)
{
    //int numCliques = 0;

    //return(bronKerbosch(connected, size, &numCliques));
    return 1;
}

/**
 *  Bron Kerbosch algorithm. The input graph is excpected in the form of a
 *  symmetrical boolean matrix connected (here as byte matrix with 0,1). The
 *  values of the diagonal elements must be 1.
 *
 * @param  adjMatrix  Graph adjacency matrix, the diagonal elements must be 1.
 * @return            The number of cliques found
 *
int bronKerbosch(int** adjMatrix, int size,  int *numCliques)
{
    int* ALL = malloc(sizeof(int) * size);

    Set actualMD = new Set(adjMatrix.length);
    Set best = new Set(adjMatrix.length);
    int c;

    //    cliques.clear();
    for (c = 0; c < size; c++)
    {
        ALL[c] = c;
    }

    version2(adjMatrix, ALL, 0, size, actualMD, best);

    actualMD = null;
    ALL = null;

    if ((breakNumCliques > 0) && ((*numCliques) >= breakNumCliques))
    {
        return 0;
    }
    else
    {
        return numberOfCliques();
    }
}



void version2(int **adjMatrix, int* oldMD, int oldTestedSize, int oldCandidateSize, Set actualMD, Set best)
{
    if ((breakNumCliques > 0) && (numCliques >= breakNumCliques))
    {
        return;
    }

    int[] actualCandidates = new int[oldCandidateSize];
    int nod;
    int fixp = 0;
    int actualCandidateSize;
    int actualTestedSize;
    int i;
    int j;
    int count;
    int pos = 0;
    int p;
    int s = 0;
    int sel;
    int index2Tested;
    boolean fini = false;

    index2Tested = oldCandidateSize;
    nod = 0;

    // Determine each counter value and look for minimum
    // Branch and bound step
    // Is there a node in ND (represented by MD and index2Tested)
    // which is connected to all nodes in the candidate list CD
    // we are finished and backtracking will not be enabled
    for (i = 0; (i < oldCandidateSize) && (index2Tested != 0); i++)
    {
        p = oldMD[i];
        count = 0;

        // Count disconnections
        for (j = oldTestedSize;
                (j < oldCandidateSize) && (count < index2Tested); j++)
        {
            if (adjMatrix[p][oldMD[j]] == 0)
            {
                count++;

                // Save position of potential candidate
                pos = j;
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

                // preincr
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
        actualMD.vertex[actualMD.size++] = sel;

        // so CD+1 and ND+1 are empty
        if (actualTestedSize == 0)
        {
            if (best.size < actualMD.size)
            {
                // found a max clique
                Set.clone(actualMD, best);
            }

            int[] tmpResult = new int[actualMD.size];
            System.arraycopy(actualMD.vertex, 0, tmpResult, 0, actualMD.size);
            addClique(tmpResult);
            numCliques++;
        }
        else
        {
            if (actualCandidateSize < actualTestedSize)
            {
                version2(adjMatrix, actualCandidates, actualCandidateSize,
                    actualTestedSize, actualMD, best);
            }
        }

        if (fini)
        {
            break;
        }

        // move node from MD to ND
        // Remove from compsub
        actualMD.size--;

        // Add to "nod"
        oldTestedSize++;

        if (nod > 1)
        {
            // Select a candidate disconnected to the fixed point
            for (s = oldTestedSize; adjMatrix[fixp][oldMD[s]] != 0; s++)
            {
            }
        }

        // end selection
    }

    // Backtrackcycle
    actualCandidates = null;
}*//**/
