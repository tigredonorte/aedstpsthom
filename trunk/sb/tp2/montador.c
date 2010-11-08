#include "montador.h"

void Montador(char* entrada, int verbose, char *saida)
{
    //inicializa as arvores
    Arvore ArvoreInstrucoes, ArvoreLabels;
    InicializaArvore(&ArvoreInstrucoes);
    InicializaArvore(&ArvoreLabels);
    MontaArvoreInstrucoes(&ArvoreInstrucoes);

    //execussao dos passos
    PrimeiraPassada(entrada, &ArvoreLabels, ArvoreInstrucoes);
    SegundaPassada(entrada, saida, ArvoreLabels, ArvoreInstrucoes);

    if(verbose)
    {
        PrintArvore(&ArvoreLabels);
    }
}

void PrimeiraPassada(char* entrada, Arvore *ArvoreLabels, Arvore ArvoreInstrucoes)
{
    FILE *arquivo;
    arquivo = fopen(entrada, "r");
    if(arquivo == NULL)
    {
        printf("\nErro ao ler arquivo de entrada, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }

    //cria o arquivo temporario com o mesmo nome da entrada, com a extensao .ex
    FILE *arqTemp;
    char *saida = malloc(sizeof(char) * (strlen(entrada) + 3));
    strcpy(saida, entrada);
    strcat(saida, ".ex");
    arqTemp = fopen(saida, "w+");
    if(arqTemp == NULL)
    {
        printf("\nErro ao criar arquivo temporario, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }

    int ant;
    int NumLinha = 0;
    char palavra2[20];
    char palavra[20];
    int shutdown = 0;
    char c;

    Registro x;
    //primeiro passo
    while(fscanf(arquivo, "%s", palavra) && !shutdown)
    {
       //verifica se existe : na string label
       //Se é um label
       if(strstr(palavra, ":") != NULL)
       {
           //verifica se proxima instrucao é do tipo WORD
           ant = fscanf(arquivo, "%s", palavra2);
           if(strcmp(palavra2, "WORD") == 0)
           {
               fprintf (arqTemp, "%s\n", palavra);
               //salva valor do operando definido pelo label
               ant = fscanf(arquivo, "%s", palavra2);

               //cria um label chamado 'label:' que conterá o valor inicial da memoria
               InicializaRegistro(&x, palavra, atoi(palavra2));
               InsereArvore(ArvoreLabels, x);
           }
           //se proxima palavra nao é WORD, então é instrução ou pseudo instrução
           else
           {
               if(strcmp(palavra2, "END") == 0)
               {
                   shutdown = 1;
               }
               fprintf (arqTemp, "%s\n", palavra2);
           }
           palavra[strlen(palavra) - 1] = '\0';
           InicializaRegistro(&x, palavra, NumLinha);
           InsereArvore(ArvoreLabels, x);
       }

       //se palavra é comentário
       else if(strstr(palavra, ";") != NULL)
       {

           //enaquanto nao for instrucao ou label ignora o que vier no arquivo
           c = fgetc(arquivo);
           while ( c != '\n' )
           {
               c = fgetc(arquivo);
           }
           NumLinha--;
           
       }
       //se é instrucao, pseudo instrucao ou operando
       else
       {
           if(strcmp(palavra, "END") == 0)
           {
               shutdown = 1;
           }
           fprintf (arqTemp, "%s\n", palavra);
       }
       NumLinha++;
    }
    //fecha os dois arquivos
    fclose(arqTemp);
    fclose(arquivo);
}

void SegundaPassada(char* entrada, char *saida, Arvore ArvoreLabels, Arvore ArvoreInstrucoes)
{
    //cria o arquivo de saida com o mesmo nome da entrada, com a extensao .sa
    FILE *arqSaida;
    arqSaida = fopen(saida, "w");
    if(arqSaida == NULL)
    {
        printf("\nErro ao criar arquivo, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }

    //cria o arquivo temporario com o mesmo nome da entrada, com a extensao .ex
    FILE *arqTemp;
    char *out = malloc(sizeof(char) * (strlen(entrada) + 3));
    strcpy(out, entrada);
    strcat(out, ".ex");
    arqTemp = fopen(out, "r");
    if(arqTemp == NULL)
    {
        printf("\nErro ao criar arquivo, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }

    /*
     * Segunda passada propriamente dita
     */

    //definicao de variaveis
    int Shutdown = 0;
    char palavra[20];
    int linha = 0;
    Registro x;

    //segunda passada
    while(fscanf(arqTemp, "%s", palavra) && !Shutdown)
    {
        InicializaRegistro(&x, palavra, 0);

        //se é instrucao
        if(PesquisaArvore(&ArvoreInstrucoes, &x))
        {
            fprintf(arqSaida, "%d\n", x.valor);
        }
        //se é pseudo instrucao do tipo end
        else if(strcmp(palavra, "END") == 0)
        {
            Shutdown = 1;
        }

        //se é label
        else
        {
            InicializaRegistro(&x, palavra, 0);
            if(PesquisaArvore(&ArvoreLabels, &x))
            {
                //se o label a ser salvo é o valor inicial de uma instrucao WORD
                if(strstr(palavra, ":") != NULL)
                {
                    fprintf(arqSaida, "%d\n", x.valor);
                }
                //se é um label normal
                else
                {
                    fprintf(arqSaida, "%d\n", (x.valor - linha-1));
                }
            }
            else
            {
                printf("Erro linha: (%d): label(%s) referenciado mas nao definido \n", (linha/2)+2, palavra);
            }
        }
        linha++;
    }
    fclose(arqTemp);
    fclose(arqSaida);

    //exclui o arquivo temporario
    if( remove( out ) != 0 ) perror( "Erro ao excluir arquivo temporario" );
}

void MontaArvoreInstrucoes(Arvore *ArvoreInstrucoes)
{
    Registro reg;
    InicializaRegistro(&reg, "LOAD", 1);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "STORE", 2);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "ADD", 3);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "SUB", 4);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "JMP", 5);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "JPG", 6);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "JPL", 7);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "JPE", 8);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "JPNE", 9);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "PUSH", 10);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "POP", 11);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "READ", 12);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "WRITE", 13);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "CALL", 14);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "RET", 15);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "DEC", 16);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "INC", 17);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "AND", 18);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "OR", 19);
    InsereArvore(ArvoreInstrucoes, reg);

    InicializaRegistro(&reg, "HALT", 20);
    InsereArvore(ArvoreInstrucoes, reg);
}