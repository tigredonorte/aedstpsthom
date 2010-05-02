/* 
 * File:   arvore.h
 * Author: thompson
 *
 * Created on 29 de Abril de 2010, 08:47
 */

#ifndef _ARVORE_H
#define	_ARVORE_H

#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


typedef struct Registro_str
{
    char *chave;
}Registro;

typedef struct Nodo_str *PNodo;

typedef struct Nodo_str
{
    Registro reg;
    PNodo esq, dir;
}Nodo;

typedef PNodo Arvore;

/*copia a arvore fonte para o destino*/
void CopiaArvore(Arvore src, Arvore *dst);

/*inicializa a arvore*/
void InicializaArvore(Arvore *ar);

/*cria um novo registro*/
void InicializaRegistro(Registro *x, char *palavra);

/*Em caso de sucesso na pesquisa, retorna 1 e o registro na variavel x
 *Em caso de falha retorna 0 e x nao e alterado;*/
int PesquisaArvore(PNodo *p, Registro *x);

/*insere um registro x na arvore*/
void InsereArvore(PNodo *p, Registro x);

/*imprime as palavras da arvore em ordem*/
void PrintArvore(Arvore *ar);

/*imprime as palavras da arvore em ordem*/
void PrintNodos(PNodo *n);

/*recebe uma arvore e um vetor de inteiros com o numero de elementos da arvore
 retorna este vetor com a profundidade dos elementos em ordem de profundidade*/
void criaVetorProfundidadeArvore(Arvore *ar, char ***vString, int **vetor, int *numeroNos);

/*retorna um vetor com a progundidade ordenada e um vetor de string ordenado*/
void criaVetorProfundidade(PNodo *n, char ***vString, int **vProf, int *prof, int *i, int *numeroNos);

#endif	/* _ARVORE_H */

