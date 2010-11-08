/* 
 * File:   Maquina.h
 * Author: thom
 *
 * Created on 7 de Setembro de 2010, 17:40
 */

#ifndef _MAQUINA_H
#define	_MAQUINA_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//definicoes
#define LOAD  1
#define STORE 2
#define ADD   3
#define SUB   4
#define JMP   5
#define JPG   6
#define JPL   7
#define JPE   8
#define JPNE  9
#define PUSH  10
#define POP   11
#define READ  12
#define WRITE 13
#define CALL  14
#define RET   15
#define DEC   16
#define INC   17
#define AND   18
#define OR    19
#define HALT  20



//Cria o tipo memoria com tamanho MEM_SIZE
#define MEM_SIZE 1000
typedef int Memoria;

typedef struct Registradores_str
{
    int AC;
    int SP;
    int PC;
}Registradores;

//inicializa  a maquina
void InicializaSimulador(Registradores *reg, Memoria **mem, int PC, int SP, int posInicial, int verbose, char* entrada);

//simula a maquina
void Simulador(int PC, int SP, int posInicial, int verbose, char* entrada);

//imprime a memoria apartir do inicio ate o final
void ImprimeMemoria(Memoria **mem, int inicio, int final);
#endif	/* _MAQUINA_H */

