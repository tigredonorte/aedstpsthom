#include "file.h"

/* retorna a primeira palavra do buffer ou a próxima se buffer = NULL */
char* proxPalavra(char *buffer)
{

    char* palavra; // próxima palavra a ser lida

    palavra = strtok(buffer, IGNORA_CHAR); // retorna a próxima palavra do buffer

    return palavra; // retorna próxima palavra
}

/* lê arquivo da lista e retorna primeira palavra, as próximas palavras são
 * capturadas chamando "proxPalavra( NULL )" */
char** leArquivo(char *nomeArquivo, int *numPalavras)
{
    FILE *arquivo; // arquivo lido
    long   tamArquivo; // tamanho do arquivo de entrada
    size_t tamCopiado; // tamanho da memória lida do arquivo de entrada

    // abre o arquivo de entrada
    arquivo = fopen (nomeArquivo , "r");
    if (arquivo == NULL)
    {
        printf("leArquivo: arquivo %s nao encontrado. \n", nomeArquivo);
        return NULL;
    }

    // descobre o tamanho do arquivo
    fseek( arquivo , 0 , SEEK_END );
    tamArquivo = ftell( arquivo );//retorna o valor de bits em relacao ao inicio do arquivo


    /*
     *  Descobre tamanho do buffer
     */
    rewind( arquivo );//coloca o ponteiro no inicio do arquivo
    char *buff;
    // aloca memória para conteúdo do arquivo
    buff = (char*) calloc( tamArquivo, sizeof(char) );
    if (buff == NULL)
    {
        printf("leArquivo: nao ha memoria para alocar arquivo \n");
        return NULL;
    }
    // copia o conteudo do arquivo para o buffer
    // ( destino, tam de cada elemento, n elemento, fonte )
    tamCopiado = fread( buff, 1, tamArquivo, arquivo );
    if(tamCopiado != tamArquivo)
    {
        printf("leArquivo: erro ao ler arquivo \n");
        return NULL;
    }

    //descobre o tamanho numero de palavras relevantes do buffer
    char *auxCpy = strtok(buff, IGNORA_CHAR);
    int nPalavras = 0;
    while(auxCpy)
    {
        nPalavras++;
        auxCpy = strtok(NULL, IGNORA_CHAR);
    }
    *numPalavras = nPalavras;
    free(buff);
    /*
     * Fim descobre tamanho
     */


    rewind( arquivo );//coloca o ponteiro no inicio do arquivo
    // aloca memória para conteúdo do arquivo
    char *buffer;
    buffer = (char*) calloc( tamArquivo, sizeof(char) );
    if (buffer == NULL)
    {
        printf("leArquivo: nao ha memoria para alocar arquivo \n");
        return NULL;
    }

    // copia o conteudo do arquivo para o buffer
    // ( destino, tam de cada elemento, n elemento, fonte )
    tamCopiado = fread( buffer, 1, tamArquivo, arquivo );
    if(tamCopiado != tamArquivo)
    {
        printf("leArquivo: erro ao ler arquivo \n");
        return NULL;
    }
    fclose (arquivo); // fecha arquivo
    
    //aloca um novo buffer
    char **Buffer;
    Buffer = calloc( nPalavras, sizeof(char*) );

    //copia o conteudo do primeiro buffer para o segundo
    char *aux = strtok(buffer, IGNORA_CHAR);
    int i = 0;
    while(aux)
    {
        Buffer[i] = calloc( strlen(aux), sizeof(char*) );
        strcpy(Buffer[i], aux);
        i++;
        aux = strtok(NULL, IGNORA_CHAR);
    }
    free(buffer);
    return (Buffer);
}
