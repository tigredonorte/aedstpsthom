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
