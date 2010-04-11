#include "filap.h"

//Esvazia fila
void esvaziaFila(Fila *fila)
{
    fila->tamanho = 0;
    fila->frente = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->frente;
    fila->frente->prox = NULL;
}

//insere novo elemento na fila
void insereFila(FItem it, Fila *fila)
{
    fila->tras->prox = (PFila)malloc(sizeof(CFila));
    fila->tras = fila->tras->prox;
    fila->tras->item = it;
    fila->tras->prox = NULL;
    fila->tamanho++;
}

void inicializaItem(FItem *it, char* palavra, int idDoc)
{
    //inicializa a fila de documentos
    esvaziaFilaDoc(&it->FilaIdDoc);

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

void pesquisaPalavraFila(Fila *fila, PFila celula, char* palavra)
{
    celula = fila->frente;
    while(celula != fila->tras)
    {
        celula = celula->prox;
        if(strcmp(celula->item.palavra, palavra) == 0)
        {
            return;
        }
    }
    celula = NULL;
}

void inserePalavraFila(Fila *fila, char* palavra, int idDoc)
{
    FItem it;
    inicializaItem(&it, palavra, idDoc);
    insereFila(it, fila);
}