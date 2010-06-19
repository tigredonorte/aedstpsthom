#include "lru.h"

void gerenciaPaginasLru(Buffer *buffer, Mapa *map, char *nomeArquivo, double r, int k)
{
    Grafo grafo;
    inicializaGrafo(&grafo, buffer->numPaginas);

    int primeiroPonto, numK, i, j, l, m;
    char *buff = NULL;
    numK = 0;

    //enche o buffer completamente
    for(i = 0; i < buffer->numPaginas; i++)
    {
        //le as numPaginas primeiras paginas do arquivo e insere o buffer
        readPage(&buff, nomeArquivo, &map->inicio[i], &map->final[i]);
        primeiroPonto = i * buffer->PPPagina;
        insereBuffer(buffer, buff, i, primeiroPonto, i);
        free(buff);

        //calcula a distancia entre os pontos da pagina carregada
        calculaDistanciaPagina(buffer, i, r, primeiroPonto, k, &numK);
        if(numK >= k) return;
        InsereAresta(&grafo, i, i, 1);
    }

    int firstLine1;
    int firstLine2;

    //calcula as distancias entre as paginas do buffer cheio
    for(i = 0; i < buffer->numPaginas; i++)
    {
        firstLine1 = map->firstLine[i];
        for(j = i+1; j < buffer->numPaginas; j++)
        {
            firstLine2 = map->firstLine[j];
            calculaDistanciaPaginas(buffer, i, j, r, firstLine1, firstLine2, k, &numK);
            if(numK >= k) return;

            InsereAresta(&grafo, i, j, 1);
            InsereAresta(&grafo, j, i, 1);

        }
    }

    /*
     * Aqui começa a LRU
     */
    int pag = 0;//guardara a pagina a ser substituida
    int aux1, aux2;

    //calcula a distancia entre as paginas substituidas e as paginas que ja existiam no buffer
    for(i = buffer->numPaginas; i < map->size; i++)
    {
        readPage(&buff, nomeArquivo, &map->inicio[i], &map->final[i]);
        substituiPaginaBuffer(buffer, buff, pag, map->firstLine[i], i);
        free(buff);

        //calcula a distancia dos pontos na pagina substiuida
        calculaDistanciaPagina(buffer, pag, r, primeiroPonto, k, &numK);
        if(numK >= k) return;

        firstLine1 = map->firstLine[i];
        aux2 = buffer->idPagina[pag];
        for(j = 0; j < buffer->numPaginas; j++)
        {
            aux1 = buffer->idPagina[j];
            firstLine2 = map->firstLine[aux1];
            if(aux2 != aux1)
            {
                calculaDistanciaPaginas(buffer, aux1, aux2, r, firstLine1, firstLine2, k, &numK);
                if(numK >= k) return;
                InsereAresta(&grafo, aux2, aux1, 1);
                InsereAresta(&grafo, aux1, aux2, 1);
            }
        }
        pag++;
        if(pag >= buffer->numPaginas) pag = 0;
    }

    int id = -1;
    short allPages = 0;

    //parte final da fifo, verifica quais as paginas nao calculadas entre si
    for(i = 0; i < map->size && !allPages; i++)
    {
        //l = pagina do buffer a ser utilizada, ela que determinara quais serao carregadas no proximo loop
        l = pag - 1;
        if(l < 0) l = buffer->numPaginas - 1;

        //aloca no buffer as paginas que ainda nao foram comparadas com a pagina l
        //l foi escolhida pois sera a ultima pagina a sair do buffer nesta politica
        for(j = 0; j < buffer->numPaginas; j++)
        {
            if(j != l)
            {
                aux1 = buffer->idPagina[l];
                id = getArestaPagina(&grafo, aux1);
                if(id != -1)
                {
                    readPage(&buff, nomeArquivo, &map->inicio[id], &map->final[id]);
                    substituiPaginaBuffer(buffer, buff, pag, map->firstLine[id], buffer->idPagina[id]);
                    free(buff);

                    //procura por uma pagina do buffer que nao tenha sido comparada com outra pagina dque estava no buffer
                    for(m = 0; m < buffer->numPaginas; m++)
                    {
                        aux2 = buffer->idPagina[m];
                        if(aux1 != aux2)
                        {
                            //se a pagina carregada nao foi comparada com outra pagina ja existente no buffer
                            if(getAresta(&grafo, aux1, aux2) == 0)
                            {
                                calculaDistanciaPaginas(buffer, aux1, aux2, r, firstLine1, firstLine2, k, &numK);
                                if(numK >= k) return;
                                InsereAresta(&grafo, aux2, aux1, 1);
                                InsereAresta(&grafo, aux1, aux2, 1);
                            }
                        }
                    }
                }
            }
            pag++;
            if(pag >= buffer->numPaginas) pag = 0;
        }
        if(grafoCompleto(&grafo)) return;
    }
}
