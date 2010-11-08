#include "algoritmos.h"

short BMHS(char** T, char** P)
{
    long i, j, k, m, n, d[MAXCHAR + 1];
    m = strlen((*P));
    n = strlen((*T));
    
    for (j = 0; j <= MAXCHAR; j++)
    {
        d[j] = m + 1;
    }
    for (j = 1; j <= m; j++)
    {
        d[(*P)[j-1]] = m - j + 1;
    }
    i = m;
    while (i <= n) /*-- Pesquisa --*/
    {
        k = i;
        j = m;
        while ((*T)[k-1] == (*P)[j-1] && j > 0)
        {
            k--;
            j--;
        }
        if (j == 0)
        {
            printf(" Casamento na posicao: %3ld\n", k + 1);
            return 1;
        }
        i += d[(*T)[i]];
    }
    return 0;
}

short ShiftAndAproximado(char** T, char** P, long Errors)
{
    // declaracao de variaveis
    long Masc[MAXCHAR], i, j, Ri, Rant, Rnovo, m, n;
    long R[NUMMAXERROS + 1];

    //inicializando valores
    m = strlen((*P));
    n = strlen((*T));
    for (i = 0; i < MAXCHAR; i++) Masc[i] = 0;
    for (i = 1; i <= m; i++)
    {
        Masc[(*P)[i-1] + 127] |= 1 << (m - i);
    }
    R[0] = 0;
    Ri = 1 << (m - 1);
    for (j = 1; j <= Errors; j++)
    {
        R[j] = (1 << (m - j)) | R[j-1];
    }

    //shift and propriamente dito
    for (i = 0; i < n; i++)
    {
        Rant = R[0];
        Rnovo = ((((unsigned long)Rant) >> 1) | Ri) & Masc[(*T)[i] + 127];
        R[0] = Rnovo;
        for (j = 1; j <= Errors; j++)
        {
            Rnovo = ((((unsigned long)R[j]) >> 1) & Masc[(*T)[i] + 127]) | Rant | (((unsigned long)(Rant | Rnovo)) >> 1);
            Rant = R[j];
            R[j] = Rnovo | Ri;
        }
        if ((Rnovo & 1) != 0)
        {
            printf(" Casamento na posicao %12ld\n", i + 1);
            return 1;
        }
    }
    return 0;
}

short ForcaBruta(char **T, char **P, int K)
{
    long i, j, k, m, n, a;
    m = strlen((*P));
    n = strlen((*T));
    char *aux = malloc(sizeof(char) * m);

    a = n - m + 1;
    for (i = 1; i <= a; i++)
    {
        k = i;
        j = 1;
        for(j = 0; j < m; j++)
        {
            aux[j] = (*T)[j + i];
        }

        if (DistanciaMenorK(&aux, P, K))
        {
            printf("Casamento na posicao: %3ld\n", i);
            return 1;
        }
    }
    return 0;
}

int LevenshteinDistance(char **char1, char **char2)
{
    int size1 = strlen((*char1));
    int size2 = strlen((*char2));
    size1++; size2++;

    //inicializa o vetor de verificacao de proximidade
    int **tab = malloc(sizeof(int*) * (size1));
    int custo, i, j, aux, aux2;
    for(i = 0; i < size1; i++)
    {
        tab[i] = malloc(sizeof(int) * (size2));
        tab[i][0] = i;
    }

    for(i = 0; i < size2; i++)
    {
        tab[0][i] = i;
    }

    //procura a distancia dentre as duas strings
    for( i = 1; i < size1; i++)
    {
        for(j = 1; j < size2; j++)
        {
            if((*char1)[i-1] == (*char2)[j-1])
            {
                custo = 0;
            }
            else
            {
                custo = SUBSTITUICAO;
            }

            //verifica o que é mais facil fazer: deletar, inserir ou substituir
            aux = tab[i-1][j] + REMOCAO;
            aux2 = tab[i][j-1] + INSERCAO;
            if(aux > aux2)
            {
                aux = aux2;
            }
            aux2 = tab[i-1][j-1] + custo;
            if(aux > aux2)
            {
                aux = aux2;
            }
            tab[i][j] = aux;
        }
    }

    aux = tab[size1-1][size2-1];
    for(i = 0; i < size1; i++)
    {
        free(tab[i]);
    }
    free(tab);

    return(aux);
}

//retorna 1 caso a distancia entre duas palavras seja menor ou igual a k, 0 caso contrario
short DistanciaMenorK(char **str1, char **str2, int k)
{
    int dist = LevenshteinDistance(str1, str2);
    return(dist <= k);
}
