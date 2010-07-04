/* 
 * File:   shiftAnd.h
 * Author: thompson
 *
 * Created on 3 de Julho de 2010, 13:51
 */

#ifndef _ALGORITMOS_H
#define	_ALGORITMOS_H

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

//shiftAnd
#define MAXTAMTEXTO     1000
#define MAXTAMPADRAO    10
#define MAXCHAR         32
#define NUMMAXERROS     33

//Leveinstein
#define INSERCAO        1
#define REMOCAO         1
#define SUBSTITUICAO    1

typedef char TipoTexto[MAXTAMTEXTO];
typedef char TipoPadrao[MAXTAMPADRAO];


//Algoritmo shift and aproximado
short ShiftAndAproximado(char** T, char** P, long Errors);

//algoritmo tentativa e erro, recebe um inteiro K, que eh a distancia maxima de leveinstein
short ForcaBruta(char **T, char **P, int k);

//algoritmo BMHS (extra)
short BMHS(char** T, char** P);

//retorna a distancia entre as strings
int LevenshteinDistance(char **char1, char **char2);

//retorna 1 caso a distancia entre as strings seja menor do que 1, 0 caso contrario
short DistanciaMenorK(char **str1, char **str2, int k);

#endif	/* _ALGORITMOS_H */

