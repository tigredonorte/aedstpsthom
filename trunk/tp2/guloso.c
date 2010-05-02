#include "guloso.h"

void insereArvoreGulosa(Arvore *ar, Hash *hash, int *Size)
{
    int i;
    int size = 0;
    itemH *vetor;
    criaVetor(hash, &vetor, &size);
    *Size = size;

    quickSort(vetor, size);

    for(i = size-1 ; i >= 0; i--)
    {
        Registro x;
        InicializaRegistro(&x, vetor[i].chave);
        InsereArvore(ar, x);
    }
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
