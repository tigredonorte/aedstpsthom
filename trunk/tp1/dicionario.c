#include "dicionario.h"

long getTime()
{
    //char buffer[30];
    struct timeval tv;

    time_t curtime;
    gettimeofday(&tv, NULL);
    curtime=tv.tv_sec;

    return(tv.tv_sec);
}


/* calcula o indice do hash da palavra */
int Char2Indice(char* palavra, int m)
{
    //numero de letras da palavra (tamanho da palavra)
    int tam = strlen(palavra);

    int total = 0; // acumula resultados de cada iteração

    int i;
    for(i = 0; i < tam; i++)
    {
        /* multiplica caracter pelo indice como peso
         * onde palavra + 0, representa o primeiro caracter da palavra, palvra + 1, o segundo, ...
         *tam - i = tamanho da palavra - posicao da letra, desta forma palavras que possuam as mesmas
         *      letras em posicoes diferentes nao ocuparao o mesmo lugar no hash
        */
        total += (*(palavra + i)) * (tam-i); 
    }
    return (total % m);
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
PFila PesquisaPalavraDicionario(Dicionario *dic, char *palavra, long *tempoLatencia)
{
    long iniTime, finalTime;

    int idPalavra = Char2Indice(palavra, dic->tam);
    PFila celula;

    iniTime = getTime();
    pesquisaPalavraFila(&dic->hash[idPalavra], &celula, palavra);
    finalTime = getTime();
    *tempoLatencia = finalTime - iniTime;
    return celula;
}

void recuperaFilaDocumentos(PFila celula)
{
    recuperaDocumentos(celula);
}
