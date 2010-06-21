#include "file.h"

void inicializaMapa(Mapa *map, int size)
{
    map->size = size;
    map->inicio = malloc(sizeof(long) * size);
    map->final = malloc(sizeof(long) * size);
    map->firstLine = malloc(sizeof(int) * size);
    map->PontosArquivo = 0;
}

void insereMapa(Mapa *map, long *inicio, long* final, int *firstLine, int size, int PPArquivo)
{
    map->size = size;
    map->PontosArquivo = PPArquivo;

    int i;
    for(i = 0; i < size; i++)
    {
        map->inicio[i] = inicio[i];
        map->final[i] = final[i];
        map->firstLine[i] = firstLine[i];
    }
}

void desalocaMapa(Mapa *map)
{
    free(map->inicio);
    free(map->final);
}

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

    //descobre o inicio da primeira linha da pagina
    fseek( arquivo , (*pageBegin) , SEEK_SET);
    while( (chr = fgetc(arquivo)) != '\n' )
    {
        ungetc(chr, arquivo);
        (*pageBegin)--;
        fseek( arquivo , (*pageBegin) , SEEK_SET);
    }
    (*pageBegin)++;


    //descobre o final da ultima linha da pagina
    fseek( arquivo , (*pageEnd) , SEEK_SET);
    while( (chr = fgetc(arquivo)) != '\n' )
    {
        ungetc(chr, arquivo);
        (*pageEnd)++;
        fseek( arquivo , (*pageEnd)  , SEEK_SET);
    }

    //aloca o tamanho necessaio do buffer
    tamArquivo = ((*pageEnd) - (*pageBegin)) * sizeof(char);
    (*buffer) = (char*)malloc( tamArquivo);
    if((*buffer) == NULL)
    {
        printf("File.c - readPage: nao ha memoria para alocar arquivo \n");
        fclose (arquivo);
        exit(EXIT_FAILURE);
    }

    // copia o conteudo do arquivo para o buffer
    fseek( arquivo , (*pageBegin), SEEK_SET);
    tamCopiado = fread( (*buffer), 1, tamArquivo, arquivo );
    if(tamCopiado != tamArquivo)
    {
        printf("File.c - readPage: erro ao ler arquivo \n");
        fclose (arquivo);
        exit(EXIT_FAILURE);
    }
    fclose (arquivo);
}

void readFirstLine(char *nomeArquivo, int *numPontos, int *numDim)
{
    FILE *arquivo; // arquivo lido

    // abre o arquivo de entrada
    arquivo = fopen (nomeArquivo , "r");
    if (arquivo == NULL)
    {
        printf("File.c - readFirstLine: arquivo %s nao encontrado. \n", nomeArquivo);
        exit(EXIT_FAILURE);
    }

    //copia os parametros da primeira linha
    if( fscanf(arquivo, "%d %d", numPontos, numDim) != 2 )
    {
        printf("File.c - readFirstLine: Entrada com formato invalido! A primeira linha deve conter 2 numeros: numero de pontos e numero de dimensoes\n");
        exit(EXIT_FAILURE);
    }

    fclose (arquivo);
}

void mapeiaArquivo(Mapa *map, int PPArquivo, int PPPagina, char *nomeArquivo, int *numPags)
{
    FILE *arquivo; // arquivo lido
    int k = 0;
    long *inicio = malloc(sizeof(long) * (*numPags)); //inicio das paginas
    long *final = malloc(sizeof(long) * (*numPags));  //fim das paginas
    int *firstLine = malloc(sizeof(int) * (*numPags));  //fim das paginas

    long pos = 0;//contador de posicoes
    char chr;

    // abre o arquivo de entrada
    arquivo = fopen (nomeArquivo , "r");
    if (arquivo == NULL)
    {
        printf("File.c - mapeiaArquivo: arquivo %s nao encontrado. \n", nomeArquivo);
        exit(EXIT_FAILURE);
    }

    //procura o final da primeira linha
    while( (chr = fgetc(arquivo)) != '\n' )
    {
        pos++;
        ungetc(chr, arquivo);
        fseek(arquivo, pos, SEEK_SET);
    }

    pos++;
    inicio[k] = pos;
    firstLine[k] = 1;

    int numPontos = 0;
    int totalPontos = 0;
    (*numPags) = 0;

    //enquanto nao encontrar todos os pontos do arquivo
    while(totalPontos < PPArquivo)
    {
        //procura por um novo ponto na linha
        chr = fgetc(arquivo);
        while( chr != '\n' && chr != EOF)
        {
            pos++;
            ungetc(chr, arquivo);
            fseek(arquivo, pos, SEEK_SET);
            chr = fgetc(arquivo);
        }
        numPontos++;

        //se o numero de pontos encontrados for igual ao numero dep ontos por pagina
        if(numPontos == PPPagina)
        {
            (*numPags)++;
            //zera o numero de pontos, marca o final de uma pagina
            final[k] = pos;
            totalPontos += numPontos;
            numPontos = 0;

            //marca o inicio de outra pagina se ainda nao varreu todo o arquivo
            if(totalPontos < PPArquivo)
            {
                k++;
                pos++;
                firstLine[k] = totalPontos;
                inicio[k] = pos;
            }
        }
    }

    //final da ultima pagina
    final[k] = pos;

    //cria o mapa
    inicializaMapa(map, (*numPags));
    insereMapa(map, inicio, final, firstLine, (*numPags), PPArquivo);

    //desaloca variaveis
    free(inicio);
    free(final);
    free(firstLine);
    fclose (arquivo);
}
