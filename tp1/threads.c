#include "threads.h"

void inicializaTStruct(t_struct *estrutura, char* outfile, char* statisticFile, char* vocabularioFile, int numTrabGerado, int tamBuffer, DicionarioH *dic)
{
    esvaziaFilaProc(&estrutura->fila, tamBuffer);

    estrutura->outFile = malloc(sizeof(char) * strlen(outfile));
    strcpy(estrutura->outFile, outfile);
    
    estrutura->numTrabGerado = numTrabGerado;
    
    estrutura->dic = dic;

    // este flag indica se ainda tem mais itens a serem produzidos '1' ou se terminou a producao '0'
    estrutura->produzindo = 1;

    /*comeco da parte foda da especificacao*/
    //salvara as estatisticas do programa( parte fora da especificacao, criada para facilitar criacao de graficos
    estrutura->statisticFile = malloc(sizeof(char) * strlen(statisticFile));
    strcpy(estrutura->statisticFile , statisticFile);
    deleteFileContent(estrutura->statisticFile);
    FILE *estatisticFile;
    //verifica se o arquivo ja exite, se existir abre ele novamente para adicionar ao fim do aquivo
    if((estatisticFile = fopen(estrutura->statisticFile, "r")))
    {
        fclose(estatisticFile);
        //cria o arquivo de saida caso ele nao exista e abre caso ele exista
        estatisticFile = fopen(estrutura->statisticFile, "a");
    }
    //se arquivo nao existia cria um novo arquivo com o nome enviado
    else
    {
        estatisticFile = fopen(estrutura->statisticFile, "a");
    }
    //salva dados no arquivo
    fprintf (estatisticFile, "ID \t Latencia Pesquisa \t Latencia Media Pesquisa "
            "\t Latencia Insercao \t Latencia Media Insercao \t Tempo de execussao da thread \n");
    fclose(estatisticFile);
    /*Fim da parte foda da especificacao*/

     /*
     *  Gera o char terms
     */
    //leitura do arquivo de entrada
    FILE* fp = fopen(vocabularioFile,"r");
    if (!fp)
    {
        printf("Arquivo inexistente!");
        exit(1);
    }
    uint terms_size = TERMS_SIZE;
    estrutura->terms = (char **)malloc(sizeof(char *) * terms_size);
    char *term = (char *)malloc(sizeof(char)*MAX_LINE_SIZE);
    uint i = 0;
    while (i < terms_size)
    {
        if (fgets(term, MAX_LINE_SIZE-1, fp)==NULL)
        {
            printf("error : input file!");
            exit(1);
        }
        estrutura->terms[i]= (char *)malloc(sizeof(char)*(strlen(term)+1));
        strcpy(estrutura->terms[i],term);
        i++;
    }
    free(term);
    /*
     *  fim da geracao
     */
}

//inicializa um novo item
void inicializaItemProc(FItemProc *it, termsT *buffer)
{
    it->buffer = buffer;
}

//Esvazia fila de processos
void esvaziaFilaProc(FilaProc *fila, int tamBuffer)
{
    fila->frente = (PFilaProc)malloc(sizeof(CFilaProc));
    fila->tras = fila->frente;
    fila->frente->prox = NULL;
    if (fila)
    {
        pthread_mutex_init(&fila->mutex, NULL);
        pthread_cond_init(&fila->generate, NULL);
        pthread_cond_init(&fila->stop, NULL);
    }
    //seta os flags iniciais
    fila->full = 0;
    fila->empty = 1;
    fila->size = 0;

    //tamanho maximo que a fila pode atingir (em bits)
    fila->max_size = 1024*1024*tamBuffer;
}

//insere novo elemento na fila de processos
void insereFilaProc(FItemProc it, FilaProc *fila)
{
    //pthread_mutex_lock (&fila->mutex);

    fila->tras->prox = (PFilaProc)malloc(sizeof(CFilaProc));
    fila->tras = fila->tras->prox;
    fila->tras->item = it;
    fila->tras->prox = NULL;

    fila->size += (it.buffer->sizeInBytes + sizeof(termsT));
    if( (fila->size) > (fila->max_size) )
    {
        fila->full = 1;
    }
    fila->empty = 0;


    //pthread_mutex_unlock (&fila->mutex);
}

//remove um item da fila
void removeFilaProc(FItemProc *it, FilaProc *fila)
{
    PFilaProc celula;
    if(fila->frente == fila->tras)
    {
        return;
    }

    //pthread_mutex_lock (&fila->mutex);

    celula = fila->frente;
    fila->frente = fila->frente->prox;
    *it = fila->frente->item;

    //se retirou um elemento e a fila ficou vazia
    if( fila->frente == fila->tras )
    {
        fila->empty = 1;
        fila->full = 0;
    }
    else
    {
         // atualiza tamanho da fila
        fila->size -= (it->buffer->sizeInBytes + sizeof(termsT));

        // verifica se a fila ainda esta cheia
        if( (fila->size) < (fila->max_size) )
        {
            fila->full = 0;
        }
    }

   // pthread_mutex_unlock(&fila->mutex);
    free(celula);
}

void* consumidor(void * argumento)
{
    double iniTime = 0;
    iniTime = getTime();

    double finalTime = 0;
    double latenciaTotalPesquisa = 0;
    double latenciaTotalInsercao = 0;
    double latenciaMediaPesquisa = 0;
    double latenciaMediaInsercao = 0;

    // começa com 1 para evitar divisao por zero posteriormente
    //note que para um numero pequeno de testes fara diferenca, mas para testes muito grandes nao
    int numPesquisas = 1;
    int numInsercoes = 1;
    

    t_struct *estrutura_thread;
    estrutura_thread = argumento;

    //realiza o loop ate a thread produtora parara de produzir e
    //nao existirem documentos na fila
    //while( &estrutura_thread->produzindo || &estrutura_thread->fila.full)
    while( estrutura_thread->produzindo || !&estrutura_thread->fila.empty)
    {
        pthread_mutex_lock(&estrutura_thread->fila.mutex);
        //se a fila esta vazia, aguarda o produtor inserir mais uma tarefa
        //ou sai do loop caso o produtor tenha terminado

        //espera a threads produtora colocar algo no buffer
        while(estrutura_thread->fila.empty)
        {
            pthread_cond_wait( &estrutura_thread->fila.generate, &estrutura_thread->fila.mutex );
        }

        //se realmente a fila possuir mais itens, remove o item e coloca
        if(!estrutura_thread->fila.empty)
        {
            FItemProc it;
            removeFilaProc(&it, &estrutura_thread->fila);
            if(&it == NULL)
            {
                printf("\nItem ja foi apagado, ERRO!"
                       "\nArquivo: threads.c"
                       "\nFuncao: Consumidor"
                       "\nLinha (aproximadamente, pois pode mudar): 170"
                       "\nPossivel erro: double free"
                       "\n O programa sera fechado");
                getc(stdin);
                exit(EXIT_FAILURE);
            }

            pthread_mutex_unlock (&estrutura_thread->fila.mutex);

            //se for consulta
            if(it.buffer->type == 1)
            {
                double iTime = getTime();
                PesquisaIndiceInvertido(it.buffer->terms, estrutura_thread->dic, estrutura_thread->outFile, it.buffer->size);
                double fTime = getTime() - iTime;
                latenciaTotalPesquisa += fTime;
                numPesquisas++;
            }
            //se for insercao
            else if(it.buffer->type == 0)
            {
                double iTime = getTime();
                insereIndiceInvertido(it.buffer->terms, estrutura_thread->dic, it.buffer->size);
                double fTime = getTime() - iTime;
                latenciaTotalInsercao += fTime;
                numInsercoes++;
            }
            free_doc_query(it.buffer);
        }
        pthread_mutex_unlock (&estrutura_thread->fila.mutex);
    }
    latenciaMediaPesquisa = latenciaTotalPesquisa/numPesquisas;
    latenciaMediaInsercao = latenciaTotalInsercao/numInsercoes;
    finalTime = getTime() - iniTime;

    pthread_mutex_lock(&estrutura_thread->fila.mutex);
    static int cid = 0;
    cid++;
    printf("\nFim do consumidor id = (%d)"
           "\nLatencia total de pesquisa = (%f)"
           "\nLatencia media de pesquisa = (%f)"
           "\nLatencia total de insercao = (%f)"
           "\nLatencia media de Insercao = (%f)"
           "\nTempo de execussao da thread = (%f)\n\n",
            cid,
            latenciaTotalPesquisa,
            latenciaMediaPesquisa,
            latenciaTotalInsercao,
            latenciaMediaInsercao,
            finalTime);
    
    writeFileThread(estrutura_thread->statisticFile, cid, latenciaTotalPesquisa, latenciaMediaPesquisa, latenciaTotalInsercao, latenciaMediaInsercao, finalTime);
    //garantia que vai destravar
    pthread_mutex_unlock (&estrutura_thread->fila.mutex);
    
    return (NULL);
}

void* produtor(void * argumento)
{
    t_struct *estrutura_thread;
    estrutura_thread = argumento;

    termsT *data = NULL;

    pthread_mutex_lock( &estrutura_thread->fila.mutex );
    estrutura_thread->produzindo = 1;
    pthread_mutex_unlock( &estrutura_thread->fila.mutex );

    int i = 0;
    while( i < estrutura_thread->numTrabGerado )
    {
        //tranca o acesso a esta parte do codigo
        pthread_mutex_lock( &estrutura_thread->fila.mutex );
        //espera as threads consumidoras esvaziarem o buffer (caso este esteje cheio)
        if( estrutura_thread->fila.full )
        {
            pthread_cond_wait( &estrutura_thread->fila.generate, &estrutura_thread->fila.mutex );
        }
        data = gen_data( estrutura_thread->terms, TERMS_SIZE );
        
        //imprimeTerms(data);

        //insere uma nova tarefa na fila
        FItemProc it;
        inicializaItemProc(&it, data);
        insereFilaProc(it, &estrutura_thread->fila);

        //destranca o acesso e avisa com um sinalizador que a fila esta gerando
        pthread_cond_signal( &estrutura_thread->fila.generate);
        pthread_mutex_unlock( &estrutura_thread->fila.mutex );
        i++;
    }

    pthread_mutex_lock( &estrutura_thread->fila.mutex );
    estrutura_thread->produzindo = 0;
    pthread_mutex_unlock( &estrutura_thread->fila.mutex );

    printf("\nFim do produtor");
    return NULL;
}
