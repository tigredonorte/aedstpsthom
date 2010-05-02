#include "hashaberto.h"
int H(int m, char *palavra)
{
       //escolhida uma base menor do que 11
    int base = (m  % 11);
    int resultado = 0;
    //numero de letras da palavra (tamanho da palavra)
    if(palavra != NULL)
    {
        int tam = strlen(palavra);

        double total = 0; // acumula resultados de cada iteração

        int i;
        for(i = 0; i < tam; i++)
        {
            /* multiplica caracter pelo indice como peso
             * onde palavra + 0, representa o primeiro caracter da palavra, palvra + 1, o segundo, ...
             *tam - i = tamanho da palavra - posicao da letra, desta forma palavras que possuam as mesmas
             *      letras em posicoes diferentes nao ocuparao o mesmo lugar no hash
            */
            double n = pow(base , (tam - i));
            total += ((*(palavra + i)) * n) ;
        }
        resultado = (int)total % (m);

        //se der buffer overflow nesta divisao
        if(resultado < 0) resultado = resultado * (-1);
    }

    return resultado;
    // retorna resultado acumulado (mod m)

}
void inicializaHash(Hash *hash, int tamanho, int numLinhas)
{
    hash->tamanho = tamanho;
    hash->numLinhas = numLinhas;
    hash->hash = malloc(tamanho * sizeof(itemH));
    hash->inseridos = 0;
    int i;
    for(i = 0; i < tamanho; i++)
    {
        hash->hash[i].status = VAZIO;
        hash->hash[i].pop = 0;
        hash->hash[i].nOcorrencias = 0;
    }
}

int PesquisaHash(Hash *hash, char *chave)
{
    int i, ini, m;
    ini = H(hash->tamanho, chave);

    m = hash->tamanho;
    i = 0;

    //enquanto nao der uma volta inteira no hash, nao encontrar a chave ou a celula estiver cheia
    while((hash->hash[(ini + i) % m].status != VAZIO) && (strcmp(hash->hash[(ini + i) % m].chave, chave) != 0) && (i < m))
    {
        i++;
    }

    //se a posicao e vazia, entao nao pode comparar strings
    if(hash->hash[(ini + i) % m].status != VAZIO)
    {
        //se as palavras forem iguais, encontrou
        if(strcmp(hash->hash[(ini + i) % m].chave, chave) == 0)
        {
            return (ini + i) % m;
        }
    }

    return m;
}

void InsereHash(Hash *hash, char *chave)
{
    int i, ini, m, inserido;
    inserido = PesquisaHash(hash, chave);
    m = hash->tamanho;
    ini = H(hash->tamanho, chave);
    //se nao encontrou o elemento
    if(inserido == m)
    {
        hash->inseridos++;
        i = 0;
        //enquanto nao encontrar uma posicao vazia ou retirada, nao ha lugar para colocar o elemento
        while((hash->hash[(ini + i) % m].status == CHEIO) && (i < m))
        {
            i++;
        }

        //se nao percorreu a tabela inteira
        if(i < m)
        {
            hash->hash[(ini + i)%m].chave = malloc(sizeof(char) * strlen(chave));
            strcpy(hash->hash[(ini + i)%m].chave, chave);
            hash->hash[(ini + i)%m].status = CHEIO;
            hash->hash[(ini + i)%m].nOcorrencias++;
        }
        else
        {
            printf("Falha catastrofica, o hash esta cheio!! Palavra nao pode ser adicionada.");
        }
    }

    //se encontrou o elemento
    else
    {
        hash->hash[ini % m].nOcorrencias++;
        //hash->hash[ini % m].popularidade = hash->hash[ini % m].numOcorrencias/hash->tamanho;
        //hash->hash[ini % m].popularidadeDiferente = hash->hash[ini % m].numOcorrencias/hash->termosDiferentes;
    }
}

int getInseridos(Hash *hash)
{
    return(hash->inseridos);
}
void calculaPopularidade(Hash *hash)
{
    int i, tam;
    tam = hash->tamanho;
    for(i = 0; i < tam; i++)
    {
        if(hash->hash[i].status == CHEIO)
        {
            int nO = hash->hash[i].nOcorrencias;
            int nLinhas = hash->numLinhas;
            hash->hash[i].pop = (double)nO/nLinhas;
        }
    }
}

//retorna popularidade de um item
double getPop(itemH *k1)
{
    return(k1->pop);
}

/*Retorna a popularidade do i-ezimo termo do hash*/
double getPopularidade(Hash *hash, int i)
{
    //return(hash->hash[i].popularidade);
    return(hash->hash[i].pop);
}

int comparaChave(itemH *k1, itemH *k2)
{
    return(strcmp(k1->chave, k2->chave));
}

int comparaPopularidadeChave(itemH *k1, itemH *k2)
{
    /*popularidades iguais*/
    if(k1->pop == k2->pop)
    {
        return 0;
    }
    /*popularidade do primeiro maior do que do segundo*/
    if(k1->pop > k2->pop)
    {
        return 1;
    }
    /*popularidade do primeiro menor do que do segundo*/
    return -1;
}

char *getChave(itemH *k1)
{
    return(k1->chave);
}

void criaVetor(Hash *hash, itemH **vetor, int *size)
{
    *size = 0;
    int i;
    int j = 0;

    //descobre o tamanho a ser alocado do vetor
    int tHash = hash->tamanho;
    for(i = 0; i < tHash; i++)
    {
        if(hash->hash[i].status == CHEIO)
        {
            j++;
        }
    }

    (*vetor) = malloc(sizeof(itemH) * j);

    j = 0;
    //copia as posicoes oculpadas do hash
    for(i = 0; i < tHash; i++)
    {
        if(hash->hash[i].status == CHEIO)
        {
            (*vetor)[j] = hash->hash[i];
            j++;
        }
    }

    *size = j;
}
