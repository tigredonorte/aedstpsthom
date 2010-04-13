#include "data.h"

void novoIndiceInvertido(DicionarioH *dic, int tamDic)
{
    InicializaDicionario(dic, tamDic);
}

void insereIndiceInvertido(char *documento, DicionarioH *dic)
{
    static int idDoc = 0;
    idDoc++;

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
            int idDocs = idDoc;
            InserePalavraDicionario(dic, idDocs, aux);
            aux = proxPalavra(NULL); // próxima palavra do arquivo
        }
    }
}

void PesquisaIndiceInvertido(char *palavra, DicionarioH *dic, char *ArqName)
{
    writeFile(ArqName, palavra);
    
    long tempoLatencia;
    int sucessoPesquisa = 1;

    char *temp;
    temp = proxPalavra(palavra);
    while(temp != NULL && sucessoPesquisa)
    {
        PFila celula;
        celula = PesquisaPalavraDicionario(dic, temp, &tempoLatencia);
        if(celula == NULL)
        {
            sucessoPesquisa = 0;
        }
        else
        {
            sucessoPesquisa = 1;
            recuperaFilaDocumentos(celula);
        }
        temp = proxPalavra(NULL);
    }
    if(sucessoPesquisa)
    {
        printf("as palavras (%s) foram encontradas com sucesso\n", palavra);
    }
    free(temp);
}