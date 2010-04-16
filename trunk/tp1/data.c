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

void insereIndiceInvertido2(char *Buffer, DicionarioH *dic)
{
    static int idDoc = 0;
    idDoc++;

    //char *aux;
    //aux = proxPalavra(Buffer);
    // verifica se ainda existem palavras
    while(Buffer != NULL )
    {
        int idDocs = idDoc;
        InserePalavraDicionario(dic, idDocs, Buffer);
        Buffer = proxPalavra(NULL); // próxima palavra do arquivo
    }
}

void PesquisaIndiceInvertido(char *palavra, DicionarioH *dic, char *ArqName)
{
    writeFile(ArqName, palavra);
    
    long tempoLatencia = 0;
    int sucessoPesquisa = 1;
    int numPalavras = 0;

    char *temp;
    temp = proxPalavra(palavra);

    FilaDoc filaD;
    esvaziaFilaDoc(&filaD);
    while(temp != NULL && sucessoPesquisa)
    {
        PFila celula = NULL;
        if(!PesquisaPalavraDicionario(dic, temp, &tempoLatencia, &celula))
        {
            sucessoPesquisa = 0;
        }
        else
        {
            FilaDoc filaDoc;
            recuperaFilaDoc(celula, &filaDoc);

            PFilaDoc celulaDoc = NULL;
            primeiroElementoFilaDoc(&filaDoc, &celulaDoc);
            proximaCelulaDoc(&celulaDoc);
            while(celulaDoc != NULL)
            {
                int idDoc = 0;
                recuperaIdCelulaDoc(celulaDoc, &idDoc);

                FItemDoc it;
                inicializaItemDoc(&it, idDoc);
                insereFilaDoc(it, &filaD);
                proximaCelulaDoc(&celulaDoc);
            }
            sucessoPesquisa = 1;
        }
        temp = proxPalavra(NULL);
        numPalavras++;
    }
    if(sucessoPesquisa)
    {
        PFilaDoc celulaDoc;
        primeiroElementoFilaDoc(&filaD, &celulaDoc);
        proximaCelulaDoc(&celulaDoc);
        while(celulaDoc != NULL)
        {
            //varrera a fila de documentos, ocorrera interseçao entre ids de dois documentos
            //se o numero de insercoes de um id for maior ou igual ao numero de palavras em pesquisa
            //entao este documento podera ser salvo no documento
            if(getNumInsercoes(celulaDoc) >= numPalavras)
            {
                int idDoc;
                recuperaIdCelulaDoc(celulaDoc, &idDoc);
                writeFileInt(ArqName, idDoc);
            }
            proximaCelulaDoc(&celulaDoc);
        }
    }
    free(temp);
    writeFile(ArqName, "\n");
}