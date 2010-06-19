/* 
 * File:   buffer.h
 * Author: thompson
 *
 * Created on 12 de Junho de 2010, 11:07
 */

#ifndef _BUFFER_H
#define	_BUFFER_H

#include <stdio.h>
#include <stdlib.h>
#include "pontos.h"

typedef struct buffer_str
{
    int numDim;
    int numPaginas;
    int pagInseridas;
    int PPPagina; //pontos por pagina
    Pagina *VPaginas;//vetor de paginas
    int *idPagina;//vetor com o numero da pagina carregada
    Ponto ponto;
}Buffer;

//inicializa o buffer
void inicializaBuffer(Buffer *buffer, int numPaginas, int PontosPorPagina, int numDim);

//destroi as informacoes do buffer
void destroiBuffer(Buffer *buffer);

//destroi uma pagina
short destroiPaginaBuffer(Buffer *buffer, int pagina);

//carrega uma pagina do buffer
void recuperaPaginaBuffer(Buffer *buffer, Pagina *pg, int pagina);

/*
 *  firstline eh a linha do primeiro ponto da pagina
 */

//insere no buffer retorna 0 caso a pagina nao exista
short insereBuffer(Buffer *buffer, char *buff, int pagina, int firstLine, int idPagina);

//substitui uma pagina do buffer, retorna 0 caso esta pagina nao exista
short substituiPaginaBuffer(Buffer *buffer, char *buff, int pagina, int firstLine, int idPagina);

//calcula a distancia entre duas paginas do buffer
void calculaDistanciaPaginas(Buffer *buffer, int id1, int id2, double r, int firstLine1, int firstLine2, int k, int *numK);

//calcula a distancia dos pontos da pagina id
int calculaDistanciaPagina(Buffer *buffer, int pagina, double r, int firstLine, int k, int *numK);

#endif	/* _BUFFER_H */

