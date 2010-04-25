#include "hashaberto.h"
int H(int m, char *palavra)
{
       //escolhida uma base menor do que 11
    int base = (m  % 11);

    //numero de letras da palavra (tamanho da palavra)
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
    int resultado = (int)total % (m);

    //se der buffer overflow nesta divisao
    if(resultado < 0) resultado = resultado * (-1);
    return resultado;
    // retorna resultado acumulado (mod m)

}
void inicializaHash(Hash *hash, int tamanho)
{
    hash->tamanho = tamanho;
    hash->hash = malloc(tamanho * sizeof(itemH));
    hash->termosDiferentes = 0;

    int i;
    for(i = 0; i < tamanho; i++)
    {
        hash->hash[i].status = 1;
        hash->hash[i].popularidade = 0;
        hash->hash[i].popularidadeDiferente = 0;
        hash->hash[i].numOcorrencias = 1;
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

    //se as palavras forem iguais, encontrou
    if(strcmp(hash->hash[(ini + i) % m].chave, chave) == 0)
    {
        return (ini + i) % m;
    }
    return m;
}

void InsereHash(Hash *hash, char *chave)
{
    int i, ini, m;
    ini = H(hash->tamanho, chave);
    m = hash->tamanho;

    //se nao encontrou o elemento
    if(ini == m)
    {
        i = 0;
        hash->termosDiferentes++;
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
        }
        else
        {
            printf("Falha catastrofica, o hash esta cheio!! Palavra nao pode ser adicionada.");
        }
    }

    //se encontrou o elemento
    else
    {
        hash->hash[ini % m].numOcorrencias++;
        hash->hash[ini % m].popularidade = hash->hash[ini % m].numOcorrencias/hash->tamanho;
        hash->hash[ini % m].popularidadeDiferente = hash->hash[ini % m].numOcorrencias/hash->termosDiferentes;
    }
}

int getTamanhoHash(Hash *hash)
{

}

/*retorna o elemento da posicao i do hash*/
itemH getPositionHash(Hash *hash, int i)
{

}

/*verifica se uma posicao do hash eh nula*/
int positionIsFull(Hash *hash, int i)
{

}