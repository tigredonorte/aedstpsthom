/* 
 * File:   fifo.h
 * Author: thompson
 *
 * Created on 18 de Junho de 2010, 16:21
 */

#ifndef _FIFO_H
#define	_FIFO_H

#include "buffer.h"
#include "grafo.h"
#include "file.h"

//utiliza a estrategia fifo caso o tamanho do buffer seja maior do que 1
void gerenciaPaginasFifo(Buffer *buffer, Mapa *map, char *nomeArquivo, double r, int k);

//estrategia usada caso o tamanho do buffer seja = 1
void gerenciaPaginas(Buffer *buffer, Mapa *map, char *nomeArquivo, double r, int k);

#endif	/* _FIFO_H */

