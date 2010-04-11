/* 
 * File:   data.h
 * Author: thompson
 *
 * Created on 11 de Abril de 2010, 06:44
 */

#ifndef _MAP_H
#define	_MAP_H

#include "dicionario.h"

//apontador para uma celula do mapa <int, palavra>
typedef struct CMap_str *PMap;

//Item do mapa <int, palavra>
typedef struct MapItem_str
{
    char *documento;
    int idPalavra;
}MapItem;

//Celula do mapa <int, palavra>
typedef struct CMap_str
{
    MapItem item;
    PMap prox;
}CMap;

//Map propriamente dita
typedef struct Map_str
{
    PMap frente, tras;
}Map;

//inicializa um novo map
void inicializaMap(Map *map);

//insere uma nova palavra no map e associa a esta um id dentro da estrutura
int insereMap(Map *map, char *documento);

#endif	/* _MAP_H */

