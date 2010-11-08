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
#define AVG_GAIN_SIZE 200
#define VAR_GAIN_SIZE 150

#define AVG_COST_SIZE 30
#define VAR_COST_SIZE 20

#define MAX_COST 1000.0

typedef struct {
	int id_comp;
	int id_exp;
	double cost;
	double gain;
} Texp;

gsl_rng * r;  /* global generator */

int init_random_functions();

Texp *gen_exp(uint id_comp, uint id_exp);

int **gen_competitors(uint num_comps, double p);

void free_exps(Texp **exps, uint num_exps);

void free_competitors(int **matrix, uint num_comps);

void print_output_file (Texp **exps, int **matrix, uint num_comps, uint num_exps, FILE *out_file);

void geraEntrada(char *entrada, uint numEmpresas, uint numExperimentos, double probabilidade);

#endif
