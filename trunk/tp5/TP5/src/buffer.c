#include "buffer.h"

void inicializaBuffer(Buffer *buffer, int numPaginas, int PontosPorPagina, int numDim)
{
    buffer->numDim = numDim;
    buffer->pagInseridas = 0;
    buffer->numPaginas = numPaginas;
    buffer->PPPagina = PontosPorPagina;
    buffer->VPaginas = malloc(sizeof(Pagina) * numPaginas);
    buffer->idPagina = malloc(sizeof(int) * numPaginas);


    int i;
    for(i = 0; i < numPaginas; i++)
    {
        inicializaPagina(&buffer->VPaginas[i], PontosPorPagina, numDim);
        buffer->idPagina[i] = 0;
    }
    buffer->ponto = malloc(sizeof(double) * numDim);
}

short insereBuffer(Buffer *buffer, char *buff, int pagina, int firstLine, int idPagina)
{
    if(buffer->pagInseridas == buffer->numPaginas)
    {
        return 0;
    }
    if(pagina < 0 || pagina > (buffer->numPaginas-1))
    {
        return -1;
    }

    buffer->pagInseridas++;
    buffer->idPagina[pagina] = idPagina;
    lePontos(&buffer->VPaginas[pagina], buff, firstLine);
    return 1;
}

short destroiPaginaBuffer(Buffer *buffer, int pagina)
{
    if(pagina < 0 || pagina > (buffer->numPaginas-1))
    {
        return 0;
    }

    buffer->idPagina[pagina] = 0;
    destroiPagina(&buffer->VPaginas[pagina]);
    buffer->pagInseridas--;
    return 1;
}

void destroiBuffer(Buffer *buffer)
{
    int i;
    for(i = 0; i < buffer->numPaginas; i++)
    {
        if(&buffer->VPaginas[i])
        {
            destroiPagina(&buffer->VPaginas[i]);
        }
    }
    buffer->pagInseridas = 0;
    free(buffer->ponto);
    free(buffer->idPagina);
    free(buffer->VPaginas);
}

short substituiPaginaBuffer(Buffer *buffer, char *buff, int pagina, int firstLine, int idPagina)
{
    //se a pagina nao existe retorna zero
    if(pagina < 0 || pagina > (buffer->numPaginas-1))
    {
        return 0;
    }

    //destroi a pagina a ser substituida e inicializa novamente com os valores do buffer
    destroiPaginaBuffer(buffer, pagina);
    inicializaPagina(&buffer->VPaginas[pagina], buffer->PPPagina, buffer->numDim);
    lePontos(&buffer->VPaginas[pagina], buff, firstLine);
    return 1;
}

void recuperaPaginaBuffer(Buffer *buffer, Pagina *pg, int pagina)
{
    //se a pagina nao existe retorna zero
    if(pagina < 0 || pagina > (buffer->numPaginas-1))
    {
        pg = NULL;
        return;
    }
    copiaPagina(&buffer->VPaginas[pagina], pg);
}

int calculaDistanciaPagina(Buffer *buffer, int pagina, double r, int firstLine, int k, int *numK)
{
    //se a pagina nao existe retorna zero
    if(pagina < 0 || pagina > (buffer->numPaginas-1))
    {
        return 0;
    }
    calculaDistanciaPontos(&buffer->VPaginas[pagina], r, firstLine, k, numK);
    return 1;
}

void calculaDistanciaPaginas(Buffer *buffer, int id1, int id2, double r, int firstLine1, int firstLine2, int k, int *numK)
{
    if(id1 < 0 || id1 > (buffer->numPaginas-1))
    {
        return;
    }
    if(id2 < 0 || id2 > (buffer->numPaginas-1))
    {
        return;
    }
    calculaDistanciaDuasPagina(&buffer->VPaginas[id1], &buffer->VPaginas[id2], r, firstLine1, firstLine2, k, numK);
}
