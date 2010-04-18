#ifndef GEN_DATA_H
#define GEN_DATA_H

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>

//Constants
#define AVG_DOC_SIZE 300
#define VAR_DOC_SIZE 100

#define AVG_QUERY_SIZE 2
#define VAR_QUERY_SIZE 1
#define MAX_LINE_SIZE 100

typedef struct {
	char **terms;
	uint size;
	int type;
        uint sizeInBytes;
} termsT;

gsl_rng * r;  // global generator

int init_random_functions();

termsT *gen_doc(char **terms, uint terms_size);

termsT *gen_query(char **terms, uint terms_size);

termsT *gen_data(char **terms, uint terms_size);

void imprimeTerms(termsT *terms);

int free_doc_query(termsT *data);
#endif