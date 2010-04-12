#include "data.h"

void novoIndiceInvertido(DicionarioH *dic, int tamDic)
{
    InicializaDicionario(dic, tamDic);
}

void insereIndiceInvertido(char *documento, DicionarioH *dic)
{
    Map map;
    inicializaMap(&map);

    int idDoc = insereMap(&map, documento);

    char *buffer;
    char *aux;

    aux = leArquivo(documento, &buffer);
    if( aux == NULL ) // verifica se existem palavras no arquivo
    {
        printf("insereIndiceInvertido: nenhuma palavra adicionada no arquivo %s \n", documento);
    }
    else // se existirem palavras
    {
        // verifica se ainda existem palavras
        while(aux != NULL )
        {
            InserePalavraDicionario(dic, idDoc, aux);
            aux = proxPalavra(NULL); // próxima palavra do arquivo
        }
    }
}

void RecuperaIndiceInvertido(char *palavra, DicionarioH *dic)
{

}