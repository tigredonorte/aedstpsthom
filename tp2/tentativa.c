
#include "arvore.h"

#include "tentativa.h"

/*Insere o indice invertido na arvore*/
void insereArvoreTentativa(Arvore *ar, Hash *hash)
{
    int i, j;
    int size = 0;
    itemH *vetor;
    criaVetor(hash, &vetor, &size);
    if(size > MAX_SIZE)
    {
        printf("\nNumero muito elevado, nao eh possivel calcular uma arvore tentativa e erro"
               "\nPara esta quantidade de palavras. O programa sera encerrado"
               "\nPara aumentar o limite desta arvore altere a constante maxSize");
    }

    //aloca um vetor de inteiros que guarda a profundidade temporaria
    int *vProfundidade;
    vProfundidade = malloc(size * sizeof(int));

    double melhorArvore = -1;

    int nFat = fatorial(size);
    //fara n! permutacoes, cada permutacao eh realizada pela permutacaoN
    for (i = 0; i < nFat; i++)
    {
        itemH *vPermutado;
        permutacaoN(vetor,&vPermutado, size, i);
        
        //cria uma arvore
        Arvore aTemp;
        InicializaArvore(&aTemp);

        //insere os elementos na arvore
        for(j = 0; j < size; j++)
        {
            Registro x;
            InicializaRegistro(&x, vPermutado[j].chave);
            InsereArvore(&aTemp, x);
        }
        char **vString = malloc(sizeof(char*) * size);
        criaVetorProfundidadeArvore(&aTemp, &vString, &vProfundidade);
        //PrintArvore(&aTemp);
        double pesoArvore = 0;
        for(j = 0; j < size; j++)
        {
            int id = PesquisaHash(hash, vString[j]);
            double pop = getPopularidade(hash, id);
            pesoArvore += pop * vProfundidade[j];
        }
        if(melhorArvore > pesoArvore || melhorArvore == -1)
        {
            melhorArvore = pesoArvore;
            (*ar) = aTemp;
            //CopiaArvore(aTemp, ar);
        }
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

int fatorial(int n)
{
    int i, fat;
    fat = 1;
    for(i = 1; i < n+1; i++)
    {
        fat = i*fat;
    }
    return fat;
}

void permutacaoN(itemH *vSrc, itemH **vDst, int size, int k)
{
    (*vDst) = malloc(size * sizeof(itemH));
    int i, j;

    //procura a k-esima permutaçao de um vetor qualquer
    int factoradic[size];
    for (j = 1; j <= size; j++)
    {
        factoradic[size - j] = k % j;
        k /= j;
    }

    //converte o fatoradic em uma chave numerica para calcular o elemento a ser realmente permutado
    int temp[size];
    int perm[size];
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
        (*vDst)[i] = vSrc[perm[i]];
    }
}

