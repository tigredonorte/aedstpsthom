#include "file.h"


/* retorna a primeira palavra do buffer ou a próxima se buffer = NULL *
char* proxPalavra(char *buffer)
{
    char* palavra; // próxima palavra a ser lida

    palavra = strtok(buffer, IGNORA_CHAR); // retorna a próxima palavra do buffer
    if( palavra == NULL ) return palavra;  // se não existirem mais palavras, retorna
    // ignora a palavra se começar com números
    while( (*palavra >= '0') && (*palavra <= '9') )
    {
        palavra = strtok(NULL, IGNORA_CHAR);  // retorna a próxima palavra do buffer
        if( palavra == NULL ) return palavra;  // se não existirem mais palavras, retorna
    }

    return palavra; // retorna próxima palavra
}

*//* retorna a primeira palavra do buffer ou a próxima se buffer = NULL */
char* proxPalavra(char *buffer)
{
   
    char* palavra; // próxima palavra a ser lida

    palavra = strtok(buffer, IGNORA_CHAR); // retorna a próxima palavra do buffer

    return palavra; // retorna próxima palavra
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
    tamArquivo = ftell( arquivo );//retorna o valor de bits em relacao ao inicio do arquivo
    rewind( arquivo );//coloca o ponteiro no inicio do arquivo

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

    return (proxPalavra(*buffer));
}

//Escreve no arquivo uma string, retorna 1 se escreveu com sucesso, 0 se nao escreveu
void writeFile(char *ArqName, double value)
{
    FILE *arqOut;

    //verifica se o arquivo ja exite, se existir abre ele novamente para adicionar ao fim do aquivo
    if((arqOut = fopen(ArqName, "r")))
    {
        fclose(arqOut);
        //cria o arquivo de saida caso ele nao exista e abre caso ele exista
        arqOut = fopen(ArqName, "a");
    }
    //se arquivo nao existia cria um novo arquivo com o nome enviado
    else
    {
        arqOut = fopen(ArqName, "a");
    }

    //salva dados no arquivo de saida
    fprintf (arqOut, "%f\n", value);
    fclose(arqOut);

}