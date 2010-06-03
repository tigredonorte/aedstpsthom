#include "grafo.h"

void inicializaGrafo(Grafo *grafo, double tempoT, int NVertices)
{
    grafo->NumVertices = NVertices;
    grafo->tempo = tempoT;
    grafo->Mat = malloc(sizeof(int*) * NVertices);
    grafo->Exp = (Experimento*)malloc(sizeof(Experimento) * NVertices);

    int i = 0;
    for(i = 0; i < NVertices; i++)
    {
        grafo->Mat[i] = (int*)malloc(sizeof(int) * NVertices);
        grafo->Exp[i].empresa = -1;
        grafo->Exp[i].experimento = -1;
        grafo->Exp[i].lucro = 0;
        grafo->Exp[i].tempo = 0;
        grafo->Exp[i].lucroTempo = 0;
    }
}

void FGVazio(Grafo *Grafo)
{
    short i, j;

    for (i = 0; i < Grafo->NumVertices; i++)
    {
        for (j = 0; j < Grafo->NumVertices; j++)
        {
            Grafo->Mat[i][j] = 0;
        }
    }
}


void InsereAresta(Grafo *grafo, int V1, int V2)
{
    grafo->Mat[V1][V2] = 1;
}


short ExisteAresta(Grafo *Grafo, int Vertice1, int Vertice2)
{
    return (Grafo->Mat[Vertice1][Vertice2] > 0);
}

void ImprimeGrafo(Grafo *Grafo)
{
    short i, j;

    printf("   ");
    for (i = 0; i < Grafo->NumVertices; i++)
    {
        printf("%3d", i);
    }

    printf("\n");

    for (i = 0; i < Grafo->NumVertices; i++)
    {
        printf("%3d", i);

        for (j = 0; j < Grafo->NumVertices; j++)
        {
            printf("%3d", Grafo->Mat[i][j]);
        }
        printf("\n");
    }
}  /* ImprimeGrafo */

void LiberaGrafo(Grafo *grafo)
{
    int i;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        if(grafo->Mat[i]){free(grafo->Mat[i]);}
    }
    if(grafo->Mat){free(grafo->Mat);}
    if(grafo->Exp){free(grafo->Exp);}
}

void insereExperimento(Grafo *grafo, int experimento, int empresa, double lucro, double tempo)
{
    int i = experimento;
    grafo->Exp[i].experimento = experimento;
    grafo->Exp[i].empresa = empresa;
    grafo->Exp[i].lucro = lucro;
    grafo->Exp[i].tempo = tempo;
    grafo->Exp[i].lucroTempo = (lucro/tempo);
}

void GrafoComplementar(Grafo *grafo)
{
    int i, j;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        for(j = 0; j < grafo->NumVertices; j++)
        {
            if(grafo->Mat[i][j] == 0)
            {
                grafo->Mat[i][j] = 1;
            }
            else
            {
                grafo->Mat[i][j] = 0;
            }
        }
    }
}

void GrafoMergeRelacoes(Grafo *grafo, Grafo *grafoEmp)
{
    int i, j, k, l;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        k = grafo->Exp[i].empresa;
        for(j = 0; j < grafo->NumVertices; j++)
        {
            l = grafo->Exp[j].empresa;
            if(grafoEmp->Mat[k][l] == 1 || k == l)
            {
                InsereAresta(grafo, i, j);
                InsereAresta(grafo, j, i);
            }
        }
    }
}

int getNumVertices(Grafo *grafo)
{
    return(grafo->NumVertices);
}

double getTempo(Grafo *grafo)
{
    return(grafo->tempo);
}

//retorna o id do experimento
int ExperimentoGetId(Experimento *exp)
{
    return(exp->experimento);
}

//retorna o tempo gasto por um experimento
double ExperimentoGetTime(Experimento *exp)
{
    return(exp->tempo);
}

//retorna o lucro esperado de um experimento
double ExperimentoGetLucro(Experimento *exp)
{
    return(exp->lucro);
}

//retorna o custo beneficio de um experimento
double ExperimentoGetLucroTime(Experimento *exp)
{
    return(exp->lucroTempo);
}

//copia para o vetor exp os experimentos do grafo
void ExperimentosCopia(Grafo *grafo, Experimento **exp)
{
    int i;
    for(i = 0; i < grafo->NumVertices; i++)
    {
        (*exp)[i].empresa = grafo->Exp[i].empresa;
        (*exp)[i].experimento = grafo->Exp[i].experimento;
        (*exp)[i].lucro = grafo->Exp[i].lucro;
        (*exp)[i].lucroTempo = grafo->Exp[i].lucroTempo;
        (*exp)[i].tempo = grafo->Exp[i].tempo;
    }
}
