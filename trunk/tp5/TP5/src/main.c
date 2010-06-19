/* 
 * File:   main.c
 * Author: thompson
 *
 * Created on 22 de Maio de 2010, 07:46
 */

#include <stdio.h>
#include "pontos.h"
#include <stdlib.h>
#include "interface.h"
#include "fifo.h"
#include "lru.h"

int main(int argc, char** argv)
{
    DataIn data;
    readArgs(argc, argv, &data);

    Mapa map;
    Buffer buffer;
    leEntrada(&data, &map, &buffer);

    if(buffer.numPaginas > 1)
    {
        //escolhe entre os tres algoritmos
        switch(data.SPolitica)
        {
            case FIFO:
                        gerenciaPaginasFifo(&buffer, &map, data.IEntrada, data.RRaio, data.KPontos);
                        break;
            case LRU:
                        gerenciaPaginasLru(&buffer, &map, data.IEntrada, data.RRaio, data.KPontos);
                        break;
            default:
                printf("nao existe o algoritmo com id %d", data.SPolitica);
        }
    }
    else
    {
        gerenciaPaginas(&buffer, &map, data.IEntrada, data.RRaio, data.KPontos);
    }

    return (EXIT_SUCCESS);
}

