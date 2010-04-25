#include "guloso.h"

void insereArvoreGulosa(arvoreG *ar, itemG it)
{
  //  PFilaG cel = ar->fila.frente;


    
}

nodoG insereElementoG(nodoG n, itemG it)
{
    if(n == NULL)
    {
        n = malloc(sizeof(nodoGuloso));
        n->it = it;
        n->dir = NULL;
        n->esq = NULL;
        return n;
    }
    return NULL;
}
