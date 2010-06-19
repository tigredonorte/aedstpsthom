/* 
 * File:   lru.h
 * Author: thompson
 *
 * Created on 18 de Junho de 2010, 18:24
 */

#ifndef _LRU_H
#define	_LRU_H

#include "buffer.h"
#include "grafo.h"
#include "file.h"

void gerenciaPaginasLru(Buffer *buffer, Mapa *map, char *nomeArquivo, double r, int k);

#endif	/* _LRU_H */

