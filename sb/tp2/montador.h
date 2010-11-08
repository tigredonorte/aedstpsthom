/* 
 * File:   montador.h
 * Author: thom
 *
 * Created on 8 de Outubro de 2010, 21:51
 */

#ifndef _MONTADOR_H
#define	_MONTADOR_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "arvore.h"

#define LABEL 1
#define OPERADOR 2
#define OPERANDO 3
#define COMENTARIO 4

/* Montador da linguagem
 * Recebe o nome do arquivo de entrada
 */
void Montador(char* entrada, int verbose, char *saida);
void PrimeiraPassada(char* entrada, Arvore *ArvoreLabels, Arvore ArvoreInstrucoes);
void SegundaPassada(char* entrada, char *saida, Arvore ArvoreLabels, Arvore ArvoreInstrucoes);
void MontaArvoreInstrucoes(Arvore *ArvoreInstrucoes);


#endif	/* _MONTADOR_H */

