
#include "grafo.h"

#include "fifo.h"

void gerenciaPaginasFifo(Buffer *buffer, Mapa *map, char *nomeArquivo, double r, int k, DataOut *datao)
{
    Grafo grafo;
    inicializaGrafo(&grafo, map->size);

    int primeiroPonto, numK, i, j, l, m, firstLine1, firstLine2, idL, idM, idK, pag, idNovaPagina;
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
    }

    pag = 0;//guardara a pagina a ser substituida

    //enquanto nao comparar todas as paginas entre si
    while(!grafoCompleto(&grafo))
    {
        //l = pagina do buffer a ser utilizada, ela que determinara quais serao carregadas no proximo loop
        l = pag - 1;
        if(l < 0) l = buffer->numPaginas - 1;

        idL = buffer->idPagina[l]; //id da pagina l
        idNovaPagina = getArestaPagina(&grafo, idL); // procura uma pagina na qual l nao foi comparada ainda

        if(idNovaPagina != -1)
        {
            //aloca no buffer as paginas que ainda nao foram comparadas com a pagina l respeitando que l deve sair daki a buffer->numpaginas
            //l foi escolhida pois ser a ultima pagina a sair do buffer
            for(j = 0; j < buffer->numPaginas && idNovaPagina != -1; j++)
            {
                //se a pagina nao utilizada nao eh a propria pagina l, neste caso nao eh preciso carregala
                if((idL != idNovaPagina) && (buffer->numPaginas < map->size))
                {
                    datao->substituicoes++;
                    readPage(&buff, nomeArquivo, &map->inicio[idNovaPagina], &map->final[idNovaPagina]);
                    substituiPaginaBuffer(buffer, buff, pag, map->firstLine[idNovaPagina], idNovaPagina);
                    free(buff);
                }

                idK = buffer->idPagina[j];
                firstLine1 = map->firstLine[idK];

                //procura por uma pagina do buffer que nao tenha sido comparada com outra pagina dque estava no buffer
                for(m = 0; m < buffer->numPaginas; m++)
                {
                    idM = buffer->idPagina[m];
                    //se a pagina carregada nao foi comparada com outra pagina ja existente no buffer
                    if(getAresta(&grafo, idK, idM) == 0)
                    {
                        firstLine2 = map->firstLine[idM];
                        calculaDistanciaPaginas(buffer, idK, idM, r, firstLine1, firstLine2, k, &numK, &datao->fila);
                        if(numK >= k) {return;}
                        InsereAresta(&grafo, idM, idK, 1);
                        if(idK != idM)
                        {
                            InsereAresta(&grafo, idK, idM, 1);
                        }
                    }
                }

                pag++;
                if(pag >= buffer->numPaginas) pag = 0;
                idNovaPagina = getArestaPagina(&grafo, idL); // procura uma pagina na qual l nao foi comparada ainda
            }
        }
        else
        {
            pag++;
            if(pag >= buffer->numPaginas) pag = 0;
        }
    }
}

//estrategia usada caso o tamanho do buffer seja = 1
void gerenciaPaginas(Buffer *buffer, Mapa *map, char *nomeArquivo, double r, int k, DataOut *datao)
{
    int primeiroPonto, numK, i;
    char *buff = NULL;
    numK = 0;
    primeiroPonto = map->firstLine[0];

    int temp = map->inicio[0];
    temp = map->final[0];
    readPage(&buff, nomeArquivo, &map->inicio[0], &map->final[0]);
    insereBuffer(buffer, buff, 0, primeiroPonto, 0);
    free(buff);

    calculaDistanciaPagina(buffer, 0, r, primeiroPonto, k, &numK, &datao->fila);
    if(numK >= k) return;

    //carrega cada pagina separadamente e verifica as distancias dentro de cada pagina
    for(i = 1; i < map->size; i++)
    {
        primeiroPonto = map->firstLine[i];
        //le cada pagina separadamente e insere no buffer
        readPage(&buff, nomeArquivo, &map->inicio[i], &map->final[i]);
        substituiPaginaBuffer(buffer, buff, primeiroPonto, map->firstLine[i], i);
        free(buff);
        
        //calcula a distancia entre os pontos da pagina
        calculaDistanciaPagina(buffer, 0, r, primeiroPonto, k, &numK, &datao->fila);
        if(numK >= k) return;

        datao->substituicoes++;
    }
}
