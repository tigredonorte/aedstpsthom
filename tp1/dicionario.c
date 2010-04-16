#include "dicionario.h"

//retorna o tempo de relogio
double getTime()
{
    struct timeval tv;
    double curtime;
    gettimeofday(&tv, NULL);
    curtime = (double) tv.tv_sec + 1.e-6 * (double) tv.tv_usec;
    return(curtime);
}

/* calcula o indice do hash da palavra */
int Char2Indice(char* palavra, int m)
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


void InicializaDicionario(Dicionario *dic, int tamDic)
{
    //tamanho do hash
    dic->tam = tamDic;

    // a cada 10 bits temos uma palavra
    dic->hash = malloc(tamDic * sizeof(Fila));

    // se nao alocou o hash sai do programa com erro
    if(dic->hash == NULL)
    {
        printf("Impossivel alocar o hash, Erro!");
        exit(EXIT_FAILURE);
    }

    int i;
    for(i = 0; i < tamDic; i++)
    {
        esvaziaFila(&dic->hash[i]);
    }
}

//insere uma palavra no dicionario caso ela nao exista,
//adiciona nova ocorrencia caso exista
void InserePalavraDicionario(Dicionario *dic, int idDoc, char *palavra)
{
    int idPalavra = Char2Indice(palavra, dic->tam);
    PFila celula;
 	 
    //se a palavra ainda nao foi inserida
    if(!pesquisaPalavraFila(&dic->hash[idPalavra], &celula, palavra))
    {
        inserePalavraFila(&dic->hash[idPalavra], palavra, idDoc);
    }
    //a palavra foi inserida, agora ira adicionar a ocorrencia da palavra neste arquivo
    else
    {
        insereDocumentoCelula(celula, idDoc);
    }
}

//pesquisa uma palavra dentro do dicionario
int PesquisaPalavraDicionario(Dicionario *dic, char *palavra, long *tempoLatencia, PFila *celula)
{
    long iniTime = 0;
    long finalTime = 0;

    int idPalavra = Char2Indice(palavra, dic->tam);

    iniTime = getTime();
    int flag = pesquisaPalavraFila(&dic->hash[idPalavra], celula, palavra);
    finalTime = getTime();
    *tempoLatencia = finalTime - iniTime;
    return flag;
}
