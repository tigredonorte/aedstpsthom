#include "file.h"

void saveFile(char *nome_arquivo, char *string)
{
    FILE *arquivo; // arquivo lido

    //abre o arquivo de entrada se ele ja existir
    arquivo = fopen (nome_arquivo , "a");
    
    if (arquivo == NULL)
    {
        printf("saveFile: arquivo %s nao encontrado. \n", nome_arquivo);
        return;
    }
    fprintf (arquivo, "%s", string);

    fclose(arquivo);
}

void createFileIfNotExists(char *nome_arquivo)
{
    FILE *arquivo; // arquivo lido

    arquivo = fopen (nome_arquivo, "a");

    if (arquivo == NULL)
    {
        return;
    }
    
    fclose(arquivo);
}

void readPage(char **buffer, char *nomeArquivo, long *pageBegin, long *pageEnd)
{
    FILE *arquivo; // arquivo lido
    long   tamArquivo; // tamanho do arquivo de entrada
    size_t tamCopiado; // tamanho da memória lida do arquivo de entrada
    char chr; 

    // abre o arquivo de entrada
    arquivo = fopen (nomeArquivo , "r");
    if (arquivo == NULL)
    {
        printf("leArquivo: arquivo %s nao encontrado. \n", nomeArquivo);
        exit(EXIT_FAILURE);
    }

    // descobre o inicio do arquivo
    fseek( arquivo , (*pageBegin) , SEEK_SET);
    while( (chr = fgetc(arquivo)) != '\n' )
    {
        ungetc(chr, arquivo);
        (*pageBegin)--;
        fseek( arquivo , (*pageBegin) , SEEK_SET);
    }
    (*pageBegin)++;
    
    
     // descobre o final da linha
    fseek( arquivo , (*pageEnd) , SEEK_SET);
    while( (chr = fgetc(arquivo)) != '\n' )
    {
        ungetc(chr, arquivo);
        (*pageEnd)++;
        fseek( arquivo , (*pageEnd)  , SEEK_SET);
    }

    tamArquivo = ((*pageEnd) - (*pageBegin)) * sizeof(char);
    (*buffer) = (char*)malloc( tamArquivo);

    if ((*buffer) == NULL)
    {
        printf("leArquivo: nao ha memoria para alocar arquivo \n");
        fclose (arquivo);
        exit(EXIT_FAILURE);
    }
    // copia o conteudo do arquivo para o buffer
    fseek( arquivo , (*pageBegin), SEEK_SET);
    tamCopiado = fread( (*buffer), 1, tamArquivo, arquivo );
    if(tamCopiado != tamArquivo)
    {
        printf("leArquivo: erro ao ler arquivo \n");
        fclose (arquivo);
        exit(EXIT_FAILURE);
    }
    fclose (arquivo);
}

void readFirstLine(char *nomeArquivo, char **buffer, long *pageBegin)
{
    FILE *arquivo; // arquivo lido
    char chr;
    long   tamArquivo; // tamanho do arquivo de entrada
    size_t tamCopiado; // tamanho da memória lida do arquivo de entrada

    // abre o arquivo de entrada
    arquivo = fopen (nomeArquivo , "r");
    if (arquivo == NULL)
    {
        printf("leArquivo: arquivo %s nao encontrado. \n", nomeArquivo);
        exit(EXIT_FAILURE);
    }

    (*pageBegin) = 1;
    fseek( arquivo , (*pageBegin) , SEEK_SET);

    while( (chr = fgetc(arquivo)) != '\n' )
    {
        ungetc(chr, arquivo);
        (*pageBegin)++;
        fseek( arquivo , (*pageBegin)  , SEEK_SET);
    }

    fseek( arquivo , 1, SEEK_SET);
    tamArquivo = (*pageBegin) * sizeof(char);
    (*buffer) = (char*)malloc(tamArquivo);
    if ((*buffer) == NULL)
    {
        printf("leArquivo: nao ha memoria para alocar arquivo \n");
        fclose (arquivo);
        exit(EXIT_FAILURE);
    }
    tamCopiado = fread( (*buffer), 1, tamArquivo, arquivo );
    if(tamCopiado != tamArquivo)
    {
        printf("leArquivo: erro ao ler arquivo \n");
        fclose (arquivo);
        exit(EXIT_FAILURE);
    }
    fclose (arquivo);
}

long sizePage(char *nomeArquivo,  int numPaginas)
{
    FILE *arquivo; // arquivo lido
    long tamArquivo; // tamanho do arquivo de entrada
    long tamPagina = 0;
    
    // abre o arquivo de entrada
    arquivo = fopen (nomeArquivo , "r");
    if (arquivo == NULL)
    {
        printf("leArquivo: arquivo %s nao encontrado. \n", nomeArquivo);
        exit(EXIT_FAILURE);
    }

    // descobre o tamanho do arquivo
    fseek( arquivo , 0 , SEEK_END );
    tamArquivo = ftell( arquivo );//retorna o valor de bits em relacao ao inicio do arquivo
    fclose (arquivo);
    
    tamPagina = (long)tamArquivo/numPaginas;
    return tamPagina;
}
