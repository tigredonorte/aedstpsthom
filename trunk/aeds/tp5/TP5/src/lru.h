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
#include "interface.h"

void gerenciaPaginasLru(Buffer *buffer, Mapa *map, char *nomeArquivo, double r, int k, DataOut *datao);

//retorna a proxima pagina a ser substituida
int getProxPage(int *VPaginas, int size);

//retorna a pagina que ira sair por ultimo do buffer
int getBestPage(int *VPaginas, int size);

#endif	/* _LRU_H */

