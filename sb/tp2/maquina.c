#include "Maquina.h"

void InicializaSimulador(Registradores *reg, Memoria **mem, int PC, int SP, int posInicial, int verbose, char* entrada)
{
     //inicializacao de variaveis
    (*mem) = (Memoria*)malloc(sizeof(Memoria) * MEM_SIZE);
    reg->PC = 0;
    reg->SP = 0;
    reg->AC = 0;

    //tenta abrir o arquivo. Caso ele nao exista termina a execussao do programa
    FILE *arquivo;
    arquivo = fopen(entrada, "r");
    if(arquivo == NULL)
    {
        printf("\nErro ao ler arquivo, o programa sera fechado!!\n");
        exit(EXIT_FAILURE);
    }

    //carregando as instruções para a memoria
    reg->AC = posInicial + PC; //inicia na posicao inicial definida por parametro relativa ao pc
    while( fscanf(arquivo, "%d", &reg->PC) == 1 )
    {
        //utiliza o reg pc como auxiliar para carregar as instrucoes do arquivo
        (*mem)[reg->AC] = reg->PC;
        reg->AC++;
    }

    //inicializa os registradores
    reg->PC = PC;
    reg->SP = SP;
    reg->AC = 0;

    //se o modo verbose está ativado, escreve na tela
    if(verbose)
    {
        printf("#---------------------------------------------------#\n"
       "\t\tImprimindo Execussao"
       "\n#---------------------------------------------------#\n\n");
        printf("Inst \t PC \t SP \t AC\t Mem[PC + M] \t PC + M \n");
    }
}


void Simulador(int PC, int SP, int posInicial, int verbose, char* entrada)
{
    //guardará o nome da instrucao para o modo verbose
    char instructionName[6];

    int M = 0;
    int inst = 0;
    int pos = 0;
    Registradores reg;
    Memoria *mem;
    InicializaSimulador(&reg, &mem, PC, SP, posInicial, verbose, entrada);
    inst = mem[posInicial+reg.PC];
    reg.PC++;

    //execulta enquanto for uma instrucao valida ou ate a ocorrencia de halt
    while(inst >= LOAD && inst <= HALT)
    {
        //incrementa o Pc para pegar o operando M
        M = mem[reg.PC];
        reg.PC++;
        pos = reg.PC + M;
        

        //verifica se um acesso atravez de AC a memoria pode causar overflow
        if(pos > MEM_SIZE)
        {
            printf("Erro! OVERFLOW de memoria! funcao Simulador"
                   "\n M:%d PC:%d AC:%d SP:%d"
                   "\n O programa não sera encerrado, porem podem ocorrer falhas inesperadas",
                    M, reg.PC, reg.AC, reg.SP);
        }

        //busca a instrucao a ser execultada
        switch(inst)
        {
             case LOAD:
                //execulta a instrucao
                reg.AC = mem[pos];
                strcpy(instructionName, "LOAD");
             break;

             case STORE:
                 //execulta a instrucao
                 mem[pos] = reg.AC;
                 strcpy(instructionName, "STORE");
             break;

             case ADD:
                 //execulta a instrucao
                 reg.AC += mem[pos];
                 strcpy(instructionName, "ADD");
             break;

             case SUB:
                 //execulta a instrucao
                 reg.AC -= mem[pos];
                 strcpy(instructionName, "SUB");
             break;

             case JMP:
                 //execulta a instrucao
                 reg.PC = pos;
                 strcpy(instructionName, "JMP");
             break;

             case JPG:
                 //execulta a instrucao
                 if(reg.AC > 0)
                 {
                     reg.PC = pos;
                 }
                 strcpy(instructionName, "JPG");
             break;

             case JPL:
                 //execulta a instrucao
                 if(reg.AC < 0)
                 {
                    reg.PC = pos;
                 }
                 strcpy(instructionName, "JPL");
             break;

             case JPE:
                 //execulta a instrucao
                 if(reg.AC == 0)
                 {
                     reg.PC = pos;
                 }
                 strcpy(instructionName, "JPE");
             break;

             case JPNE:
                 //execulta a instrucao
                 if(reg.AC != 0)
                 {
                     reg.PC = pos;
                 }
                 strcpy(instructionName, "JPNE");
             break;

             case PUSH:
                 //execulta a instrucao
                 reg.SP--;
                 if(reg.SP > MEM_SIZE || reg.SP < 0)
                 {
                    printf("Erro! OVERFLOW de memoria! -- funcao PUSH");
                 }
                 mem[reg.SP] = mem[pos];
                 strcpy(instructionName, "PUSH");
             break;

             case POP:
                 //execulta a instrucao
                 if(reg.SP > MEM_SIZE || reg.SP < 0)
                 {
                     printf("Erro! OVERFLOW de memoria!-- funcao POP");
                 }
                 mem[pos] = mem[reg.SP];
                 reg.SP++;
                 strcpy(instructionName, "POP");
             break;

             case READ:
                 printf("Digite um valor: ");
                 scanf("%d", &mem[pos]);
                 strcpy(instructionName, "READ");
             break;

             case WRITE:
                 //execulta a instrucao
                 printf("Valor da memoria: %d\n", mem[pos]);
                 strcpy(instructionName, "WRITE");
             break;

             case CALL:
                 //execulta a instrucao
                 reg.SP--;
                 if(reg.SP > MEM_SIZE || reg.SP < 0)
                 {
                     printf("Erro! OVERFLOW de memoria!-- funcao CALL\n");
                 }
                 mem[reg.SP] = reg.PC;
                 reg.PC = pos;
                 strcpy(instructionName, "CALL");
             break;

             case RET:
                 //decrementa o pc pois ele foi incrementado acima
                 reg.PC--;

                 //executa a instrucao
                 if(reg.SP > MEM_SIZE || reg.SP < 0)
                 {
                     printf("Erro! OVERFLOW de memoria! -- funcao RET\n");
                 }
                 reg.PC = mem[reg.SP];
                 reg.SP++;
                 strcpy(instructionName, "RET");
             break;

             case DEC:
                 //execulta a instrucao
                 mem[pos]--;
                 strcpy(instructionName, "DEC");
             break;

             case INC:
                 //execulta a instrucao
                 mem[pos]++;
                 strcpy(instructionName, "INC");
             break;

             case AND:
                 //execulta a instrucao
                 reg.AC = (reg.AC & mem[pos]);
                 strcpy(instructionName, "AND");
             break;

             case OR:
                 //execulta a instrucao
                 reg.AC = (reg.AC | mem[pos]);
                 strcpy(instructionName, "OR");
             break;

             case HALT:
                 strcpy(instructionName, "HALT");
             break;
        }
        if(inst != HALT)
        {
            //incrementa o Pc para pegar a proxima instrucao da memoria
            inst = mem[reg.PC];
            reg.PC++;
        }
        else
        {
            inst++;
        }
        //se o modo verbose estiver ativado, mostra os valores dos registradores apos a operacao
        if(verbose)
        {
            printf("%s \t %d \t %d \t %d \t %d \t\t %d\n", instructionName, (reg.PC-1), reg.SP, reg.AC, mem[pos], pos);
        }
    }
    //ImprimeMemoria(&mem, 0, 50);
}

void ImprimeMemoria(Memoria **mem, int inicio, int final)
{
    printf("\n\n#---------------------------------------------------#\n"
           "\t\tImprimindo Memoria"
           "\n#---------------------------------------------------#\n\n");
    int i = 0;
    printf("Posicao \t Conteudo\n");
    for(i = inicio; i < final; i++)
    {
        printf("%d \t\t %d\n", i, (*mem)[i]);
    }
}