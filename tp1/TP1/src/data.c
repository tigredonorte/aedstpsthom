#include "data.h"

void novoIndiceInvertido(DicionarioH *dic, int tamDic)
{
    InicializaDicionario(dic, tamDic);
}

void insereIndiceInvertido(char **Buffer, DicionarioH *dic, int size)
{
    static int idDoc = 0;
    idDoc++;

    int i = 0;
    // verifica se ainda existem palavras

    for(i = 0; i < size; i++)
    {
        int idDocs = idDoc;
        InserePalavraDicionario(dic, idDocs, Buffer[i]);
        i++;
    }
}

/*realiza uma pesquisa no indice invertido
 *
 *Recebe um vetor de strings (char **) de palavras a serem pesquisadas
 *Recebe um dicionario onde serao inseridos os termos
 *Recebe um nome de arquivo onde serao salvas as pesquisas
 *Recebe um inteiro com o numero de palavras do vetor de strings
 *Salvara no arquivo as palavras a serem pesquisadas e em quais documentos elas ocorrem
 */
void PesquisaIndiceInvertido(char **palavra, DicionarioH *dic, char *ArqName, int size)
{
    int i = 0;

    //se a pesquisa falhar para alguma das palavras este flag sera 0
    int sucessoPesquisa = 1;

    //guarda o numero de palavras a ser pesquisado
    int numPalavras = 0;

    //fila de documentos que guardara os documentos pesquisados
    FilaDoc filaD;
    esvaziaFilaDoc(&filaD);

    //fara o loop enquanto ouver sucesso de pesquisa e enquanto nao pesquisar a ultima palavra enviada
    for(i = 0; i < size && sucessoPesquisa; i++)
    {
        PFila celula = NULL;
        //se a palavra nao estiver presente no dicionario nao ha sucesso na pesquisa
        if(!PesquisaPalavraDicionario(dic, palavra[i], &celula))
        {
            sucessoPesquisa = 0;
        }
        //se recuperou a palavra
        else
        {
            FilaDoc filaDoc;
            recuperaFilaDoc(celula, &filaDoc);

            PFilaDoc celulaDoc = NULL;
            primeiroElementoFilaDoc(&filaDoc, &celulaDoc);
            proximaCelulaDoc(&celulaDoc);

            //salva a fila de documentos da palavra na filaD
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
        numPalavras++;
    }

    //trava o acesso a impressao do arquivo
    pthread_mutex_lock(&dic->hash->mutex);

    //imprime no arquivo as palavras encontradas
    for(i = 0; i < size; i++)
    {
        char *aux = strtok(palavra[i], "\n \r");
        writeFile(ArqName, aux);
    }

    //se houve sucesso na pesquisa
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

    writeFile(ArqName, "\n");
    pthread_mutex_unlock(&dic->hash->mutex);
}
