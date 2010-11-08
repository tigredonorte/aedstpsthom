/* 
 * File:   arvore.h
 * Author: thom
 *
 * Created on 10 de Outubro de 2010, 10:07
 */

#ifndef _ARVORE_H
#define	_ARVORE_H

#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


typedef struct Registro_str
{
    char *chave; //label
    int valor;
}Registro;

typedef struct Nodo_str *PNodo;

typedef struct Nodo_str
{
    Registro reg;
    PNodo esq, dir;
}Nodo;

typedef PNodo Arvore;

/*inicializa a arvore*/
void InicializaArvore(Arvore *ar);

/*cria um novo registro*/
void InicializaRegistro(Registro *x, char *palavra, int valor);

/*Em caso de sucesso na pesquisa, retorna 1 e o registro na variavel x
 *Em caso de falha retorna 0 e x nao e alterado;*/
int PesquisaArvore(PNodo *p, Registro *x);

/*insere um registro x na arvore*/
void InsereArvore(PNodo *p, Registro x);

/*Imprime a arvore*/
void PrintArvore(Arvore *ar);

/*Imprime os nodos da arvore*/
void PrintNodos(PNodo *n);
#endif	/* _ARVORE_H */

