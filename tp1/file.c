/*
 * file.c
 * trata da leitura dos arquivos de entrada e cada
 * arquivo lido durante a execução.
 */

#include "file.h"


/* retorna a primeira palavra do buffer ou a próxima se buffer = NULL */
char* proxPalavra(char *buffer)
{
    char* palavra; // próxima palavra a ser lida

    palavra = strtok(buffer, IGNORA_CHAR); // retorna a próxima palavra do buffer
    if( palavra == NULL ) return palavra;  // se não existirem mais palavras, retorna
    setMinuscula(palavra);      // passa palavra para minúsculo

    return palavra; // retorna próxima palavra
}

/* transforma todas as letras da string passada como parametro para minusculo */
void setMinuscula(char* str)
{
    int i=0;
    //enquanto existir string a transforma em minuscula
    while (str[i])
    {
        str[i] = tolower(str[i]);
        i++;
    }
}

/* lê arquivo da lista e retorna primeira palavra, as próximas palavras são
 * capturadas chamando "proxPalavra( NULL )" */
char* leArquivo(char *nomeArquivo, char **buffer)
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
    tamArquivo = ftell( arquivo );
    rewind( arquivo );

    // aloca memória para conteúdo do arquivo
    (*buffer) = (char*) calloc( tamArquivo, sizeof(char) );
    if ((*buffer) == NULL)
    {
        printf("leArquivo: nao ha memoria para alocar arquivo \n");
        return NULL;
    }

    // copia o conteudo do arquivo para o buffer
    // ( destino, tam de cada elemento, n elemento, fonte )
    tamCopiado = fread( (*buffer), 1, tamArquivo, arquivo );
    if(tamCopiado != tamArquivo)
    {
        printf("leArquivo: erro ao ler arquivo \n");
        return NULL;
    }
    fclose (arquivo); // fecha arquivo

    return proxPalavra((*buffer)); // retorna a primeira palavra do arquivo
}

void formataPalavra(char* dst, char* src)
{
    int c = C;
    int i; // usado no for para percorrer palavra fonte

    memset(dst, ' ', c);   // preenche memória alocada com espaços em branco
    for( i = 0; src[i]; i++ )  // seta valor da palavra
    {
        dst[i] = src[i];
    }
    dst[c] = '\0';       // insere marca de fim da string
}

