#include <stdio.h>
#include <math.h>
#include "PNGSynth_gsl.h"

double my_semicircle(double x, void * params) {
	fun_type *fun = (fun_type*)params;
	double r = fun->params[0];
	double cx = fun->params[1];
	double cy = fun->params[2];

	double v = sqrt((r*r)-((x-cx)*(x-cx)))+cy;

	if isnan(v)
		v = -100.;
  
	return v;
}

double my_negsemicircle(double x, void * params) {
        fun_type *fun = (fun_type*)params;
        double r = fun->params[0];
        double cx = fun->params[1];
        double cy = fun->params[2];

        double v = -sqrt((r*r)-((x-cx)*(x-cx)))+cy;

        if isnan(v)
                v = 100.;

        return v;
}

double my_semiellipsis(double x, void * params) {
        fun_type *fun = (fun_type*)params;
        double r1 = fun->params[0];
        double r2 = fun->params[1];
        double cx = fun->params[2];
        double cy = fun->params[3];

        double v = (r2/r1)*sqrt((r1*r1)-((x-cx)*(x-cx)))+cy;

        if isnan(v)
                v = -100.;

        return v;
}

double my_negsemiellipsis(double x, void * params) {
        fun_type *fun = (fun_type*)params;
        double r1 = fun->params[0];
	double r2 = fun->params[1];
        double cx = fun->params[2];
        double cy = fun->params[3];

        double v = -(r2/r1)*sqrt((r1*r1)-((x-cx)*(x-cx)))+cy;

        if isnan(v)
                v = 100.;

        return v;
}

double my_yline(double x, void * params) {
	fun_type *fun = (fun_type*)params;
	double p = fun->params[0];
	if (x < fun->min)
		return -100.;
	if (x > fun->max)
		return -100.;
	return p;
}

double my_wavyline(double x, void *params) {
	fun_type *fun = (fun_type*)params;
	double p0 = fun->params[0]; // start
	double p1 = fun->params[1]; // end
	double p2 = fun->params[2]; // low
	double p3 = fun->params[3]; // high
	double length = p1 - p0;
	double height = p3 - p2;
	
	if (x <= p0)
		return p2;
	if (x >= p1)
		return p3;

	double w = sin((((x - p0)/length) * M_PI) - M_PI_2);
	w = w + 1.;
	w = w / 2.;
	w = w * height;

	return w + p2;
}

double my_dist(double x, void * params) {
	fun_type *fun = (fun_type*)params;
	double px = fun->x;
	double py = fun->y;

	double fx = fun->fun(x, params);
	double dx = px - x;
	double dy = py - fx;
	double r = sqrt(dx*dx+dy*dy);
//fprintf(stderr, "(%f, %f) %f %f %f %f -> %f\n", px, py, x, fx, dx, dy, r);

	return r;
}

double min_dist(void *params) {
	fun_type *fun = (fun_type*)params;
	int status;
	int iter = 0, max_iter = 1000;
	const gsl_min_fminimizer_type *T;
	gsl_min_fminimizer *s;
	double m = fun->min;
	double a = fun->min - 0.001, b = fun->max + 0.001;
	double prec = 1e-6;
	gsl_function F;

	F.function = &my_dist;
	F.params = params;

	gsl_set_error_handler_off();
	
	T = gsl_min_fminimizer_brent;
	//T = gsl_min_fminimizer_goldensection;
	s = gsl_min_fminimizer_alloc (T);
	do {
		status = gsl_min_fminimizer_set(s, &F, m, a, b);
		if (GSL_EINVAL == status) {
			//fprintf(stderr, "%f didn't work for %f %f (@ %f %f)\n", m, a, b, fun->x, fun->y);
			m += 0.01;
			if (m > b)
				return nan("");
		}
	} while (status != GSL_SUCCESS);

	do {
		iter++;
		status = gsl_min_fminimizer_iterate (s);
		if ((status != GSL_SUCCESS) &&
		    (status != GSL_CONTINUE)) {
			fprintf(stderr, "%s: gsl_min_fminimizer_iterate failed at %d with %d: '%s'\n", __PRETTY_FUNCTION__, iter, status, gsl_strerror (status));
			return nan("");
		}

		m = gsl_min_fminimizer_x_minimum (s);
		a = gsl_min_fminimizer_x_lower (s);
		b = gsl_min_fminimizer_x_upper (s);

		status = gsl_min_test_interval (a, b, prec, 0.0);
		if ((status != GSL_SUCCESS) &&
		    (status != GSL_CONTINUE)) {
                        fprintf(stderr, "%s: gsl_min_test_interval failed at %d with %d: '%s'\n", __PRETTY_FUNCTION__, iter, status, gsl_strerror (status));
                        return nan("");
                }
//fprintf(stderr, "%f / %f -> %f (%d after %d)\n", fun->x, fun->y, m, status, iter);


	} while (status == GSL_CONTINUE && iter < max_iter);

	gsl_min_fminimizer_free (s);

//fprintf(stderr, "%f / %f -> %f (%d after %d) [%f]\n", fun->x, fun->y, m, status, iter, my_dist(m, params));

	if (status == GSL_SUCCESS)
		return my_dist(m, params);
	return nan("");
}

#if DOTESTMAIN
int main(int argc, char ** argv) {
	fun_type myfun;

	myfun.x = 2.;
	myfun.y = 3.;
	myfun.min = 0.;
	myfun.max = 3.;
	myfun.fun = &my_semicircle;
	myfun.params[0] = 1.;
	myfun.params[1] = 3.;
	myfun.params[2] = 3.;

	double m = min_dist(&myfun);
	printf("%f\n", m);
	
  return 0;
}
#endif
