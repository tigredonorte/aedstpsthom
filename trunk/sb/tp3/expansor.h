/*
 * File:   expansor.h
 * Author: thom
 *
 * Created on 1 de Novembro de 2010, 10:35
 */

#ifndef _EXPANSOR_H
#define	_EXPANSOR_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXTAM 100

void Expansor(char *entrada, char *saida);

void IdentificaMacros(char *entrada);

void ExpandeMacros(char *saida);

int GetLine(FILE *f, char **buffer, size_t *buflen);

#endif	/* _EXPANSOR_H */
