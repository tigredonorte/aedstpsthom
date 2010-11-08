#include "expansor.h"

void Expansor(char *entrada, char *saida)
{
    IdentificaMacros(entrada);
    ExpandeMacros(saida);
}

void IdentificaMacros(char *entrada)
{
    FILE *file = fopen(entrada, "r");
    //abre o arquivo de entrada
    if (!(file))
    {
       perror("\nErro ao ler arquivo de entrada!\n");
       exit(EXIT_FAILURE);
    }

    FILE *expansor = fopen("temp//expansor.temp", "w");
    //abre o temporario de saida
    if (!(expansor))
    {
       perror("\nErro ao criar o arquivo expansor!\n");
       exit(EXIT_FAILURE);
    }
    //definicao de variaveis
    size_t tamlinha= 0;
    char *linha= NULL;
    char *linhaTemp = NULL;
    char * pch = NULL;
    char *comentario = NULL;

    //le o arquivo de entrada linha por linha
    while (GetLine(file, &linha, &tamlinha))
    {
        //copia a linha para a linha temporaria
        linhaTemp = (char*)malloc(sizeof(char) * strlen(linha));
        strcpy(linhaTemp, linha);

        //se string contem comentario
        if(strstr(linha, ";"))
        {
            int k = strlen(linha);
            int m;
            char c;
            for(m = 0; m < k; m++)
            {
                c = linha[m];
                if(c == ';')
                {
                    linha[m] = '\0';
                    break;
                }
            }
        }

        //se string contem tabulacao troca tabulacao por espaco vazio
        if(strstr(linha, "\t"))
        {
            int k = strlen(linha);
            int m;
            char c;
            for(m = 0; m < k; m++)
            {
                c = linha[m];
                if(c == '\t')
                {
                    linha[m] = ' ';
                }
            }
        }
        strcpy(linhaTemp, linha);

        //se a linha contem um macro
        if(strstr(linhaTemp, "MACRO"))
        {
            strcpy(linhaTemp, linha);

            //lê a primeira palavra da linha, pois este é o nome da funcao
            pch = strtok (linhaTemp," ");
            pch[strlen(pch) - 1] = '\0';

            //cria novo arquivo
            char *arq = malloc(sizeof(char) * (strlen(pch) + 12));
            strcpy(arq, "temp//");
            strcat(arq, pch);
            strcat(arq, ".temp");

            FILE *fileTemp;
            if (!(fileTemp = fopen(arq, "w")))
            {
               perror("\nErro ao criar arquivo temporário!\n");
               exit(EXIT_FAILURE);
            }

            //salva a linha de definicao da macro
            fprintf (fileTemp, "%s \n",linha);

            //enquanto nao encontrar o final do macro
            while (GetLine(file, &linha, &tamlinha))
            {
                if(strcmp(linha, "\n")!= 0 && strcmp(linha, "\t") != 0)
                {
                    fprintf(fileTemp, "%s \n",linha);
                }
                
                //se linha contém palavra ENDMACRO
                if(strstr(linha, "ENDMACRO"))
                {
                    break;
                }
            }
            fclose(fileTemp);
        }
        else
        {
            fprintf (expansor, "%s \n",linha);
        }

        //se linha não contém palavra ENDMACRO mas contém a palavra END sai do loop
        if(!strstr(linha, "ENDMACRO") && strstr(linha, "END"))
        {
            if(!strstr(linha, ";"))
            break;
        }
	//free(comentario);
        comentario = NULL;
	linhaTemp = NULL;
    }
    //free(comentario);
    fclose(expansor);
    fclose(file);
}

void ExpandeMacros(char *saida)
{
    FILE *expansor = fopen("temp//expansor.temp", "r");
    //abre o temporario de saida
    if (!(expansor))
    {
       perror("\nErro ao criar o arquivo expansor!\n");
       exit(EXIT_FAILURE);
    }

    size_t tamlinha= 0;
    char *linha = NULL;
    char *copiaLinha = NULL;
    char * pch;
    char *temp;

    //abre arquivo de entrada
    FILE *arqsaida;
    if (!(arqsaida = fopen(saida, "w")))
    {
       perror("\nErro ao criar o arquivo de saida!\n");
       exit(EXIT_FAILURE);
    }

    
    char *var = NULL;

    //expande a macro
    while (GetLine(expansor, &linha, &tamlinha))
    {
        copiaLinha = malloc(sizeof(char) * tamlinha);
        strcpy(copiaLinha, linha);

        //lê cada palavra da linha lida
        pch = strtok (linha," ");

        char *label = NULL;

        int temlabel = 0;
        //se alinha possue label pega a proxima palavra
        if(strstr(linha, ":"))
        {
            label = malloc(sizeof(char) * strlen(pch));
            strcpy(label, pch);
            pch = strtok(NULL, " ");
            temlabel =1;
        }

        //enquanto linha nao tiver instrucao ou o arquivo nao terminar
        if(pch != NULL)
        {
            //cria novo arquivo
            char *arq = malloc(sizeof(char) * (strlen(pch) + 12));
            strcpy(arq, "temp//");
            strcat(arq, pch);
            strcat(arq, ".temp");

            int saiu = 0;

            FILE *fileTemp = fopen(arq, "r");
            if (fileTemp)
            {
                int i = 0;
                int j = 0;

                //variavel, caso exista
                pch = strtok(NULL, " ");
                if(pch != NULL)
                {
                    var = malloc(sizeof(char) * (strlen(pch)+1));
                    strcpy(var, " ");
                    strcat(var, pch);
                    i = 1;
                }

                //le a primeira linha do arquivo
                GetLine(fileTemp, &linha, &tamlinha);

                //nome da macro
                pch = strtok (linha," ");

                //retira palavra "MACRO"
                pch = strtok(NULL, " ");

                //variavel a ser substituida, caso exista
                pch = strtok(NULL, " ");
                if(pch != NULL)
                {
                    j = 1;
                }

                //se o macro não possui variaveis
                if(i == 0 && j == 0)
                {
                    //enquanto nao ler o arquivo inteiro
                    while (GetLine(fileTemp, &linha, &tamlinha))
                    {
                        if(strstr(linha, "ENDMACRO"))
                        {
                            break;
                        }

                        if(temlabel)
                        {
                            strcat(label, " ");
                            strcat(label, linha);
                            fprintf (arqsaida, "%s \n",label);
                            temlabel = 0;
                        }
                        else
                        {
                            fprintf (arqsaida, "%s \n",linha);
                        }
                    }
                }

                //se o numero de variaveis de chamada da macro é diferente do número definido na macro
                else if(i != j)
                {
                    printf("Numero de parametros diferentes para a definicao da macro e o seu chamamento, erro");
                    exit(EXIT_FAILURE);
                }

                //a macro possui variaveis
                else
                {
                    //salva o nome da variavel a ser substituida
                    char *temp2 = malloc(sizeof(char) *(strlen(pch) + 1));
                    strcpy(temp2, " ");
                    strcat(temp2, pch);
                    temp = malloc(sizeof(char) *(strlen(temp2)));

                    //enquanto nao ler o arquivo inteiro
                    while (GetLine(fileTemp, &linha, &tamlinha))
                    {

                        //recupera o nome da variavel
                        strcpy(temp, temp2);

                        //procura a variavel temp na linha
                        pch = strstr (linha, temp);
                        if(pch)
                        {
                            strncpy (pch, var, strlen(var));
                        }

                        if(strstr(linha, "ENDMACRO"))
                        {
                            break;
                        }

                        if(temlabel)
                        {
                            strcat(label, " ");
                            strcat(label, linha);
                            fprintf (arqsaida, "%s \n",label);
                            temlabel = 0;
                        }
                        else
                        {
                            fprintf (arqsaida, "%s \n",linha);
                        }
                    }
                   // free(temp2);
                }
                saiu = 1;
                fclose(fileTemp);
            }

            //se nao é macro, salva a linha
            else if(!strstr(linha, "ENDMACRO"))
            {
                fprintf (arqsaida, "%s \n",copiaLinha);
            }
        }
    }

    fclose(expansor);
    fclose(arqsaida);
}

//le uma linha do arquivo, retorna o seu tamanho e a linha lida
int GetLine(FILE *f, char **buffer, size_t *buflen)
{
    char *ptr;
    char *tmp = NULL;
    int c;

    //(*buffer) = NULL;
    
    //aloca as variaveis caso não tenham sido alocadas
    if (!*buffer || !*buflen)
    {
        *buflen= 32;
        *buffer= (char*)malloc(*buflen);
        if (!*buffer)
          return 0;
    }

    ptr= *buffer;
    while ((c= fgetc(f)) != EOF)
    {
        *ptr++= c;
        if (c == '\n') 
        {
            break;
        }

        if(ptr - *buffer >= *buflen-1)
        {
            // aumenta o buffer um pouco mais
            tmp= (char*)realloc(*buffer, *buflen+32);
            if (!tmp)
              return 0;
            // atualiza ptr para o caso do novo buffer estar em outro lugar
            ptr= tmp + (ptr - *buffer);
            *buflen+= 32;
            *buffer= tmp;
        }
    }

    //retira o \n
    
    ptr = strstr(*buffer, "\n");
    if(ptr)
    {
        strncpy (ptr, "", 1);
    }
    
    return c == EOF ? 0 : 1;
}