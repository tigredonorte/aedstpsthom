#include "filap.h"

//Esvazia fila
void esvaziaFila(Fila *fila)
{
    pthread_mutex_lock (&fila->mutex);

    fila->tamanho = 0;
    fila->frente = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->frente;
    fila->frente->prox = NULL;

    pthread_mutex_unlock (&fila->mutex);
}

//insere novo elemento na fila
void insereFila(FItem it, Fila *fila)
{
    pthread_mutex_lock (&fila->mutex);

    fila->tras->prox = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->tras->prox;
    fila->tras->item = it;
    fila->tras->prox = NULL;
    fila->tamanho++;

    pthread_mutex_unlock (&fila->mutex);
}

void inicializaItem(FItem *it, char* palavra, int idDoc)
{
    //it = (FItem*)malloc(sizeof(FItem ) + sizeof(CFilaDoc));
    //inicializa a fila de documentos
    esvaziaFilaDoc(&it->FilaIdDoc);

    //aloca a memoria necessaria para a palavra
    it->palavra = (char*) malloc((strlen(palavra)+1)*sizeof(char));

    //copia a palavra passada como parametro
    strcpy(it->palavra, palavra); 
    if(pesquisaId(&it->FilaIdDoc, idDoc) == 0)
    {
        //inicializa e insere um novo item da fila de documentos
        FItemDoc itemDoc;
        inicializaItemDoc(&itemDoc, idDoc);
        insereFilaDoc(itemDoc, &it->FilaIdDoc);
    }
}

void insereDocumentoCelula(PFila celula, int idDoc)
{
    //se a palavra nao foi registrada ainda para o documento corrente
    if(pesquisaId(&celula->item.FilaIdDoc, idDoc) == 0)
    {
        //inicializa e insere um novo item da fila de documentos da celula
        FItemDoc itemDoc;
        inicializaItemDoc(&itemDoc, idDoc);
        insereFilaDoc(itemDoc, &celula->item.FilaIdDoc);
    }
}

int pesquisaPalavraFila(Fila *fila, PFila *celula, char* palavra)
{
    (*celula) = fila->frente;
    
    while((*celula) != fila->tras)
    {
        (*celula) = (*celula)->prox;
        if(strcmp((*celula)->item.palavra, palavra) == 0)
        {     		
            return 1;
        }
    }
    (*celula) = NULL;
    return 0;
}

void inserePalavraFila(Fila *fila, char* palavra, int idDoc)
{
    FItem it;
    inicializaItem(&it, palavra, idDoc);
    insereFila(it, fila);
}

void recuperaFilaDoc(PFila celula, FilaDoc *fila)
{
    *fila = celula->item.FilaIdDoc;
}
