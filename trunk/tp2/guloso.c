#include "guloso.h"

void insereArvoreGulosa(Arvore *ar, Hash *hash)
{
    int i;
    int size = 0;
    itemH *vetor;
    criaVetor(hash, &vetor, &size);

    quickSort(vetor, size);

    for(i = size-1 ; i >= 0; i--)
    {
        Registro x;
        InicializaRegistro(&x, vetor[i].chave);
        InsereArvore(ar, x);
    }

    #ifndef _DEBUG_
    #define _DEBUG_
        int lol;
        char **vS = malloc(sizeof(char*) * size);
        int *vN = malloc(size * sizeof(int));
        criaVetorProfundidadeArvore(ar, &vS, &vN);
        for(lol = 0; lol < size; lol++)
        {
            printf("%d ",vN[lol]);
        }
        PrintArvore(ar);
        printf("\n\n ");
    #endif
}

void quickSort( itemH* vetor, int N)
{
    quickSortOrdena(vetor, 0, (N-1));
}

void quickSortOrdena(itemH* vetor, int esq, int dir)
{
    int i, j;

    itemH x;
    i = esq;
    j = dir;
    int m = (i + j)/2;
    x = vetor[m];
    do
    {
        while(comparaPopularidadeChave(&vetor[i], &x) < 0){i++;}

        while(comparaPopularidadeChave(&vetor[j], &x) > 0){j--;}

        if(i <= j)
        {
            itemH aux = vetor[i];
            vetor[i] = vetor[j];
            vetor[j] = aux;
            i++;
            j--;
        }
        
    }while(i <= j);

    if(esq < j)
    {
        quickSortOrdena(vetor, esq, j);
    }

    if(i < dir)
    {
        quickSortOrdena(vetor, i, dir);
    }
}
