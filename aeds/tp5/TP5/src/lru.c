#include "lru.h"

void gerenciaPaginasLru(Buffer *buffer, Mapa *map, char *nomeArquivo, double r, int k, DataOut *datao)
{
    Grafo grafo;
    inicializaGrafo(&grafo, map->size);

    int primeiroPonto, numK, i, j, l, m, firstLine1, firstLine2, idL, idM, idK, pag, idNovaPagina;
    char *buff = NULL;
    int *VPaginas = malloc(sizeof(int) * buffer->numPaginas);
    numK = 0;

    //enche o buffer completamente
    for(i = 0; i < buffer->numPaginas; i++)
    {
        //le as numPaginas primeiras paginas do arquivo e insere o buffer
        readPage(&buff, nomeArquivo, &map->inicio[i], &map->final[i]);
        primeiroPonto = i * buffer->PPPagina;
        insereBuffer(buffer, buff, i, primeiroPonto, i);
        VPaginas[i] = 1; //as paginas carregadas tem a mesma chance de ser substituida, neste caso, substitui a primeira pagina
        free(buff);
    }
    pag = 0;//guardara a pagina a ser substituida

    //enquanto nao comparar todas as paginas entre si
    while(!grafoCompleto(&grafo))
    {
        //l = pagina do buffer a ser utilizada, ela que determinara quais serao carregadas no proximo loop
        l = getBestPage(VPaginas, buffer->numPaginas);

        idL = buffer->idPagina[l]; //id da pagina l
        idNovaPagina = getArestaPagina(&grafo, idL); // procura uma pagina na qual l nao foi comparada ainda

        if(idNovaPagina != -1)
        {
            //aloca no buffer as paginas que ainda nao foram comparadas com a pagina l respeitando que l deve sair daki a buffer->numpaginas
            //l foi escolhida pois ser a ultima pagina a sair do buffer
            for(j = 0; j < buffer->numPaginas && idNovaPagina != -1; j++)
            {
                //se a pagina nao utilizada nao eh a propria pagina l, neste caso nao eh preciso carregala
                if(idL != idNovaPagina)
                {
                    datao->substituicoes++;
                    readPage(&buff, nomeArquivo, &map->inicio[idNovaPagina], &map->final[idNovaPagina]);
                    substituiPaginaBuffer(buffer, buff, pag, map->firstLine[idNovaPagina], idNovaPagina);
                    free(buff);
                    VPaginas[pag] = 0;
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
                        VPaginas[m]++;
                        if(idK != idM)
                        {
                            InsereAresta(&grafo, idK, idM, 1);
                            VPaginas[j]++;
                        }
                    }
                }

                pag = getProxPage(VPaginas, buffer->numPaginas);
                idNovaPagina = getArestaPagina(&grafo, idL); // procura uma pagina na qual l nao foi comparada ainda
            }
        }
        else
        {
            //se esta pagina ja nao precisa mais ser comparada, retirea do buffer
            pag = getBestPage(VPaginas, buffer->numPaginas);
            VPaginas[l] = 0;
        }
    }
}


int getProxPage(int *VPaginas, int size)
{
    int sentinel = VPaginas[0];
    int i;
    int resposta = 0;
    for(i = 1; i < size; i++)
    {
        if(sentinel > VPaginas[i])
        {
            sentinel = VPaginas[i];
            resposta = i;
        }
    }
    return resposta;
}

int getBestPage(int *VPaginas, int size)
{
    int sentinel = VPaginas[0];
    int i;
    int resposta = 0;
    for(i = 1; i < size; i++)
    {
        if(sentinel < VPaginas[i])
        {
            sentinel = VPaginas[i];
            resposta = i;
        }
    }
    return resposta;
}
