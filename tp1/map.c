#include "map.h"

//Esvazia fila
void inicializaMap(Map *map)
{
    map->frente = (PMap)malloc(sizeof(CMap));
    map->tras = map->frente;
    map->frente->prox = NULL;
}

//insere novo elemento na fila
int insereMap(Map *map, char *documento)
//insereMap(FItemDoc it, FilaDoc *fila)
{
    MapItem it;
    it.documento = (char*) malloc(sizeof(documento));
    strcpy(it.documento, documento);
    static int idPalavra = 0;
    idPalavra++;
    it.idPalavra = idPalavra;
    
    map->tras->prox = (PMap)malloc(sizeof(CMap));
    map->tras = map->tras->prox;
    map->tras->item = it;
    map->tras->prox = NULL;

    return idPalavra;
}
