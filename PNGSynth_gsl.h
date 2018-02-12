#ifndef __PNGSYNTH_GSL_H_
#define __PNGSYNTH_GSL_H_
#include <gsl/gsl_multimin.h>

typedef struct {
	double min, max;
        double x, y;
        double (*fun)(double, void*);
        double params[11];
} fun_type;


double my_semicircle(double x, void * params);
double my_negsemicircle(double x, void * params);
double my_semiellipsis(double x, void * params);
double my_negsemiellipsis(double x, void * params);
double my_yline(double x, void * params);
double my_wavyline(double x, void *params);
double min_dist(void *params);

#endif

