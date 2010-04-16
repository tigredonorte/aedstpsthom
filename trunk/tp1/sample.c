#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "gen_data.h"

#define MAX_LINE_SIZE 100

void geradorPalavras(char *arqIn, int size, char ***terms)
{

    FILE* fp = fopen(arqIn,"r");

    if (!fp)
    {
        printf("Arquivo inexistente!");
        exit(1);
    }

    uint terms_size = size;
    *terms = (char **)malloc(sizeof(char *) * terms_size);

    char *term = (char *)malloc(sizeof(char)*MAX_LINE_SIZE);
    uint i = 0;
    while (i < terms_size)
    {
        if (fgets(term, MAX_LINE_SIZE-1, fp)==NULL)
        {
            printf("error : input file!");
            exit(1);
        }
        *terms[i]= (char *)malloc(sizeof(char)*(strlen(term)+1));
        strcpy(*terms[i],term);
        i++;
    }
    free(term);


    int j=0;
    termsT *data = NULL;

    init_random_functions();
    for (j = 0; j < 100; j++)
    {
        data=gen_data(*terms, terms_size);
    }

    free_doc_query(data);

    for (i=0;i<terms_size; i++)
    {
        free(*terms[i]);
    }
    free(*terms);
}
