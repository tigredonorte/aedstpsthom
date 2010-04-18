/*
 * file.c
 * trata da leitura dos arquivos de entrada e cada
 * arquivo lido durante a execução.
 */

#include "file.h"

//Escreve no arquivo uma string, retorna 1 se escreveu com sucesso, 0 se nao escreveu
void writeFile(char *ArqName, char* string)
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
    fprintf (arqOut, "%s ", string);
    fclose(arqOut);
}

//Escreve no arquivo um inteiro, retorna 1 se escreveu com sucesso, 0 se nao escreveu
void writeFileInt(char *ArqName, int number)
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
    fprintf (arqOut, "%d ", number);
    fclose(arqOut);
}

void writeFileThread(char *ArqName, int cid, double lTP, double lMP, double lTI, double lMI, double FTime)
{
    FILE *arqOut;
    arqOut = fopen(ArqName, "a");

    //salva dados no arquivo de saida
    fprintf (arqOut, "%d \t %f \t %f \t %f \t %f \t %f \n", cid, lTP, lMP, lTI, lMI, FTime);
    fclose(arqOut);
}

void deleteFileContent(char *ArqName)
{
    FILE *arqOut;
    arqOut = fopen(ArqName, "w");
    fclose(arqOut);
}
