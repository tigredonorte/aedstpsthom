
#include "hashaberto.h"

#include "dinamica.h"

void insereArvoreDinamica(Arvore *ar, Hash *hash, int *Size)
{
    int i;
    int size = 0;

    itemH *vetor;
    criaVetor(hash, &vetor, &size);

    *Size = size;
    //aloca Espaço para A
    Dinamica **A;
    A = (Dinamica**)calloc( size, (sizeof(Dinamica*)));
    for(i = 0; i < size; i++)
    {
        A[i] = (Dinamica*)calloc( size, (sizeof(Dinamica)));
        double pop = getPop(&vetor[i]);
        A[0][i].pop = pop;

        //o pai dos nodos de nivel 0 sao os proprios nodos
        char *chave = getChave(&vetor[i]);
        A[0][i].pai = (char*)calloc( strlen(chave), (sizeof(char)));
        strcpy(A[0][i].pai, chave);

        A[0][i].dirX = -1;
        A[0][i].dirY = -1;
        A[0][i].esqX = -1;
        A[0][i].esqY = -1;
    }

   //calcula A
   CalculaA(&A, size);
   char **vArvore;
   vArvore = (char**)calloc( size, (sizeof(char*)));
   getMelhorArvore(&vArvore, A, size);
   for(i = 0; i < size; i++)
   {
       Registro x;
       InicializaRegistro(&x, vetor[i].chave);
       InsereArvore(ar, x);
   }
}

void CalculaA(Dinamica ***A, int size)
{
   int i, j;

   //Aloca o espaço para W
   double **W;
   W = (double**)calloc( size, (sizeof(double*)));
   for(i = 0; i < size; i++)
   {
        W[i] = (double*)calloc( size, (sizeof(double)));
        for(j = 0; j < size; j++)
        {
            W[i][j] = 0;
        }
   }
   //inicializa W
   for(i = 0; i < size; i++)
   {
       W[0][i] = (*A)[0][i].pop;
   }
   CalculaW(&W, size);

   //calcula A
   for(i = 1; i < size; i++)
   {
        for(j = i; j < size; j++)
        {
            //calcula cada elemento da matriz A
            double menor = calculaMenor(A, i, j, size);
            (*A)[i][j].pop = W[i][j] + menor;
        }
   }
   
   //libera o espaço alocado de W
   for(i = 0; i < size; i++)
   {
        free(W[i]);
   }
   free(W);
}

void CalculaW(double ***W, int size)
{
    int i, j, k;
    //Calcula W
    for(i = 1; i < size; i++)
    {
        for(j = i; j < size; j++)
        {
            for(k = j - i; k < j+1; k++)
            {
                (*W)[i][j] += (*W)[0][k];
            }
        }
    }
}

//calcula a menor soma de uma sub-arvore, o elemento da raiz desta arvore, e as sub-arvores a direita e esquerda
double calculaMenor(Dinamica ***A, int i, int j, int size)
{
    int k, z, n;
    Dinamica *esq;
    Dinamica *dir;
    esq = (Dinamica*)calloc( size, (sizeof(Dinamica)));
    dir = (Dinamica*)calloc( size, (sizeof(Dinamica)));

    if(i == j)
    {
        //calcula esq
        esq[0].pop = 0;
        esq[0].esqX = -1;
        esq[0].esqY = -1;
        for(k = 0; k < j; k++)//repete i vezes o laco
        {
            CopiaElemento(&(*A)[k][k], &esq[k+1]);
            esq[k+1].esqX = k;
            esq[k+1].esqY = k;
        }

        //calcula dir
        dir[j].pop = 0;
        dir[j].dirX = -1;
        dir[j].dirY = -1;
        z = j- 1;
        for(k = 0; k < j; k++)
        {
            CopiaElemento(&(*A)[z][j], &dir[k]);
            dir[k].dirX = z;
            dir[k].dirY = j;
            z--;
        }
    }
    //se i != j
    else
    {
        //calcula esq
        n = i - 1;
        z = j - 1;
        esq[i].pop = 0;
        esq[i].esqX = -1;
        esq[i].esqY = -1;
        for(k = 0; k < i; k++)
        {
            CopiaElemento(&(*A)[n][z], &esq[k]);
            esq[k].esqX = n;
            esq[k].esqY = z;
            z--;
            n--;
        }

        //calcula dir
        dir[0].pop = 0;
        dir[0].dirX = -1;
        dir[0].dirY = -1;
        for(k = 1; k <= i; k++)
        {
            CopiaElemento(&(*A)[k-1][j], &dir[k]);
            dir[k].dirX = k-1;
            dir[k].dirY = j;
        }
    }
    //calcula a menor soma
    double m = 0;
    double menor = -1;
    int id = 0; //salva a posicao que gerou a melhor sub-arvore
    m = esq[0].pop + dir[0].pop;
    menor = m;
    for(k = 1; k <= i; k++)
    {
        m = esq[k].pop + dir[k].pop;
        if(menor > m)
        {
            menor = m;
            id = k;
        }
    }

    if(i == j)
    {
        int n = id;
        (*A)[i][j].pai = (char*)calloc( strlen((*A)[0][n].pai), (sizeof(char)));
        strcpy((*A)[i][j].pai, (*A)[0][n].pai);
    }
    else
    {
        int n = j-id;
        (*A)[i][j].pai = (char*)calloc( strlen((*A)[0][n].pai), (sizeof(char)));
        strcpy((*A)[i][j].pai, (*A)[0][n].pai);
    }
    (*A)[i][j].esqX = esq[id].esqX;
    (*A)[i][j].esqY = esq[id].esqY;
    (*A)[i][j].dirX = dir[id].dirX;
    (*A)[i][j].dirY = dir[id].dirY;
    
   free(esq);
   free(dir);

   return menor;
}

void CopiaElemento(Dinamica *src, Dinamica *dst)
{
    (*dst).pop = (*src).pop;

    //copia o pai correspondente em A
    (*dst).pai = (char*)calloc( strlen((*src).pai), (sizeof(char)));
    strcpy((*dst).pai, (*src).pai);

    (*dst).esqX = (*src).esqX;
    (*dst).esqY = (*src).esqY;
    (*dst).dirX = (*src).dirX;
    (*dst).dirY = (*src).dirY;
}

void getMelhorArvore(char ***VMelhor, Dinamica **A, int size)
{
    int i;
    i = 0;

    Pilha pilha;
    EsvaziaPilha(&pilha);

    ItemP item;
    criaItem(&item, (size -1), (size -1));
    Empilha(item, &pilha);

    while(!ehVaziaPilha(&pilha))
    {
        ItemP it, it2, aux;
        Desempilha(&aux, &pilha);

        if(aux.x > -1 && aux.y > -1)
        {
            int x, y;
            x = 0; y = 0;

            //empilha os itens da direita primeiro(pois eles serao tratados por ultimo)
            x = A[aux.x][aux.y].dirX;
            y = A[aux.x][aux.y].dirY;
            criaItem(&it, x, y);
            Empilha(it, &pilha);
            
            //empilha os itens da esquerda por ultimo(pois eles serao tratados primeiro)
            x = A[aux.x][aux.y].esqX;
            y = A[aux.x][aux.y].esqY;
            criaItem(&it2, x, y);
            Empilha(it2, &pilha);

            //trata o termo atual(todo elemento que foi pra fila pertence a melhor arvore)
            (*VMelhor)[i] = (char*)malloc(sizeof(char) * strlen(A[aux.x][aux.y].pai));
            strcpy((*VMelhor)[i], A[aux.x][aux.y].pai);
            i++;
        }
    }
}

/*
 *  FUNCOES DA PILHA
 */

//esvazia uma pilha
void EsvaziaPilha(Pilha *p)
{
    p->topo = (PPilha)malloc(sizeof(CPilha));
    p->fundo = p->topo;
    p->topo->prox = NULL;
    p->tamanho = 0;
}

int ehVaziaPilha(Pilha *p)
{
    return(p->fundo == p->topo);
}

//insere novo elemento
void Empilha(ItemP item, Pilha *p)
{
    PPilha aux;
    aux = (PPilha)malloc(sizeof(CPilha));
    p->topo->item = item;
    aux->prox = p->topo;
    p->topo = aux;
    p->tamanho++;
}

//retira um elemento da pilha
void Desempilha(ItemP *item, Pilha *pilha)
{
    PPilha aux;
    if(pilha->topo == pilha->fundo)
    {
        item = NULL;
        return;
    }
    aux = pilha->topo;
    pilha->topo = aux->prox;
    *item = aux->prox->item;
    free(aux);
    pilha->tamanho--;
}

void criaItem(ItemP *item, int X, int Y)
{
    item->x = X;
    item->y = Y;
}
