#include "gen_data.h"


int init_random_functions()
{
	//init random numbers functions
	const gsl_rng_type * T;
	T = gsl_rng_default;
	r = gsl_rng_alloc (T);

	gsl_rng_env_setup();      
	
	return 1;
}

Texp *gen_exp(uint id_comp, uint id_exp){

	Texp *exp = (Texp *) malloc (sizeof(Texp)); 	

	exp->id_comp = id_comp;
	exp->id_exp = id_exp;
	exp->gain = fabs(gsl_ran_gaussian(r, VAR_GAIN_SIZE)) + AVG_GAIN_SIZE;
	exp->cost = fabs(gsl_ran_gaussian(r, VAR_COST_SIZE)) + AVG_COST_SIZE;

	//printf("comp %d \t exp %d \t gain %lf \t cost %lf\n", exp->id_comp, exp->id_exp, exp->gain, exp->cost);
	return exp;
}


// it is a random graph
int **gen_competitors(uint num_comps, double p){

	int **matrix = (int **) malloc (sizeof(int*)*num_comps);
	
	uint i=0, j=0;
	for (i=0; i < num_comps; i++)
		matrix[i] = (int *) malloc (sizeof(int)*num_comps);

	for (i = 0; i < num_comps; i++)
	{
		for (j = (i+1); j < num_comps; j++)
		{
			double prob = gsl_ran_flat (r, 0, 1);
			if (prob < p)
			{
				matrix[i][j]=1;
				matrix[j][i]=1;
			}
			else
			{
				matrix[i][j]=0;
				matrix[j][i]=0;
			}
		}
		matrix[i][i]=0;
	}
	return matrix;
}

void free_exps(Texp **exps, uint num_exps)
{
	uint i=0;
	for (i=0; i<num_exps; i++)
		free(exps[i]);
	free(exps);
}

void free_competitors(int **matrix, uint num_comps )
{
	uint i=0;
	for (i=0; i<num_comps; i++)
		free(matrix[i]);
	free(matrix);

}

void print_output_file (Texp **exps, int **matrix, uint num_comps, uint num_exps, FILE *out_file)
{
	fprintf(out_file, "%lf %d %d \n", MAX_COST , num_comps, num_exps);
	uint i=0, j=0;
	for (i=0; i < num_exps; i++)
		fprintf(out_file, "e %d %d %lf %lf \n", exps[i]->id_exp, exps[i]->id_comp, exps[i]->gain, exps[i]->cost);
	for (i=0; i < num_comps; i++)
	{
		fprintf(out_file, "e %d ", i);
		for (j=0; j < num_comps; j++)
		{
			if (matrix[i][j]==1)
				fprintf(out_file, "%d ", j);
		}
		fprintf(out_file, "\n");
	}
}

void geraEntrada(char *entrada, uint numEmpresas, uint numExperimentos, double probabilidade)
{

	init_random_functions();

	FILE* fp = fopen(entrada,"w");

	if (!fp)
	{
		printf("input file doesnt exist!");
		exit(1);
	}

	uint comps_size = numEmpresas;
	uint exps_size = numExperimentos;
	Texp **exps = (Texp **)malloc(sizeof(Texp *) * exps_size);

	uint i = 0;
	while (i < exps_size)
	{
            exps[i] = gen_exp( gsl_ran_flat(r, 0, comps_size), i);
            i++;
	}

	double p = probabilidade;
	int **matrix = gen_competitors(comps_size, p);

	print_output_file(exps, matrix, comps_size, exps_size, fp);

	fclose(fp);

	// free
	free_exps(exps, exps_size);
	free_competitors(matrix, comps_size);
	gsl_rng_free (r);
}
