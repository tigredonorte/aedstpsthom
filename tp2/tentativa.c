#include "tentativa.h"

/*inicializa arvore de tentativa e erro*/

void inicializaArvoreTentativa(arvoreT *ar, int tamanho)
{
    ar->vetorMelhor = malloc(sizeof(itemH) * tamanho);
    ar->nodo = NULL;
    ar->tamanho = tamanho;
}

/*Insere um novo elemento na arvore*/
void insereArvoreTentativa(arvoreT *ar, Hash *hash)
{
    int i;
    int j = 0;
    for(i = 0; i < getTamanhoHash(hash); i++)
    {
        if(positionIsFull(hash, i))
        {
            ar->vetorMelhor[j] = getPositionHash(hash->hash, i);
        }

    }
    nodoT n = ar->nodo;
    itemT it;
    insereElementoT(n, it);

    
    
}

/*Encaixara o item no nodo correspondente*/
nodoT insereElementoT(nodoT n, itemT it)
{

}
