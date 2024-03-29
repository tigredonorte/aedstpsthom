#include "gen_data.h"


int init_random_functions()
{
    //init random numbers functions
    const gsl_rng_type * T;
    T = gsl_rng_default;
    r = gsl_rng_alloc (T);

    return 1;
}

termsT *gen_doc(char **terms, uint terms_size)
{

    termsT *doc = (termsT *) malloc(sizeof(termsT));
    uint number_of_terms = abs(gsl_ran_gaussian(r, VAR_DOC_SIZE) + AVG_DOC_SIZE);
    doc->size = number_of_terms;
    doc->sizeInBytes = sizeof(char*) * doc->size;
    doc->type=0;
    doc->terms = (char **) malloc(number_of_terms*sizeof(char *));
    while (number_of_terms>0)
    {
        uint id = gsl_ran_flat (r, 0, terms_size-1);
        doc->terms[number_of_terms-1] = (char *) malloc (sizeof(char) * (strlen(terms[id])+1));
        strcpy(doc->terms[number_of_terms-1],terms[id]);

        //tamanho em bytes = tamanho da string + 1(terminador de string) * o tamanho de cada caractere
        doc->sizeInBytes += (strlen(terms[id])+1)*sizeof(char);

        number_of_terms--;
    }
    return doc;
}


termsT *gen_query(char **terms, uint terms_size)
{

    termsT *query = (termsT *) malloc(sizeof(termsT));
    uint number_of_terms = abs(gsl_ran_gaussian(r, VAR_QUERY_SIZE)) + AVG_QUERY_SIZE;
    query->size = number_of_terms;
    query->type=1;
    query->terms = (char **) malloc(number_of_terms*sizeof(char *));

    //tamanho em bytes = numero de termos a ser gerado * o tamanho de cada ponteiro pra termo
    query->sizeInBytes = number_of_terms * sizeof(char*);
    while (number_of_terms>0)
    {
        uint id = gsl_ran_flat (r, 0, terms_size-1);
        query->terms[number_of_terms-1] = (char *) malloc (sizeof(char) * (strlen(terms[id])+1));
        strcpy(query->terms[number_of_terms-1],terms[id]);

        //tamanho em bytes = tamanho da string + 1(terminador de string) * o tamanho de cada caractere
        query->sizeInBytes += (strlen(terms[id])+1)*sizeof(char);
        number_of_terms--;
    }
    return query;
}


int free_doc_query(termsT *data)
{

    int i=0;

    for (i=0;i<data->size;i++)
    {
        free(data->terms[i]);
    }
    free(data->terms);
    free(data);

    return 1;
}

termsT *gen_data(char **terms, uint terms_size)
{
    double prob = gsl_ran_flat (r, 0, 1);
    //printf("prob %lf\n", prob);
    if (prob>0.5)
    {
        return gen_doc(terms, terms_size);
    }
    else
    {
        return gen_query(terms, terms_size);
    }
}

void imprimeTerms(termsT *terms)
{
    static int size = 0;
    static int num = 0;
    num++;
    size += terms->sizeInBytes;
    printf("\nInicio da impressao (%d)\n", num);
   /* int i;
    for(i = 0; i < terms->size; i++)
    {
       printf("(%d)%s", i, terms->terms[i]);
    }
    */
    printf("\nnumero de termos: (%d)", terms->size);
    printf("\ntamanho em bytes: (%d)", terms->sizeInBytes);
    printf("\ntamanho acumulado: (%d)", size);
    if(terms->type == 0) printf("\nEstrutura de insercao");
    else if(terms->type == 1) printf("\nEstrutura de pesquisa");
    printf("\nFim da impressao\n\n");
}

