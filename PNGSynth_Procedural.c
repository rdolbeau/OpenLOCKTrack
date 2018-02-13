/*
 * Copyright 2002-2011 Guillaume Cottenceau and contributors.
 * 
 * Custom Filters Copyright 2018 Romain Dolbeau
 *
 * This software may be freely redistributed under the terms
 * of the X11 license.
 *
 */

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#define PNG_DEBUG 3
#include <png.h>

#include <math.h>

#include "PNGFilter_main.h"

#include "PNGSynth_support.h"
#include "PNGSynth_gsl.h"

typedef struct {
	const char *name;
	void (*init)(fun_type*, double, double, double);
} track_fun;

void init_topstraight(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_yline;
        fun->params[0] = tw/2.+0.5;
}

void init_topstraight15(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_yline;
        fun->params[0] = tw/2.+1.5;
}


void init_topstraighthalf(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = length/2.;
        fun->fun = &my_yline;
        fun->params[0] = tw/2.+0.5;
}

void init_middlepoint(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = 0.01;
        fun->fun = &my_yline;
        fun->params[0] = width/2.;
}

void init_middlestraight(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_yline;
        fun->params[0] = width/2.;
}

void init_quarterellipsis(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_negsemiellipsis;
        fun->params[0] = length-(tw/2.+0.5); // !
        fun->params[1] = width-(tw/2.+0.5);
        fun->params[2] = length;
        fun->params[3] = width;
}

void init_topsemiellipsis(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_negsemiellipsis;
        fun->params[0] = length/2.-(tw/2.+0.5); // !
        fun->params[1] = width/2.-(tw/2.+0.5);
        fun->params[2] = length/2;
        fun->params[3] = width/2;
}
void init_bottomsemiellipsis(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_semiellipsis;
        fun->params[0] = length/2.-(tw/2.+0.5); // !
        fun->params[1] = width/2.-(tw/2.+0.5);
        fun->params[2] = length/2;
        fun->params[3] = width/2;
}

void init_fullside(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_wavyline;
        fun->params[0] = 0;
        fun->params[1] = length;
	fun->params[2] = width-(tw/2.+0.5);
	fun->params[3] = 0.5 + tw/2.;
}

void init_middleside(fun_type* fun, double width, double length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_wavyline;
        fun->params[0] = 0;
        fun->params[1] = length;
        fun->params[2] = width/2.;
        fun->params[3] = 0.5 + tw/2.;
}

track_fun all_track_fun[] = {
	{ "straight", &init_topstraight }, /* straight line, 1/2" off the top */
	{ "turn90", &init_quarterellipsis }, /* 90 deg turn, 1/2" off the top and side */
	{ "side", &init_fullside }, /* move from 1/2" off the top to 1/2" off the bottom */
	{ "tophalfellipsis", &init_topsemiellipsis }, /* centered half-circle in the top half */
	{ "bottomhalfellipsis", &init_bottomsemiellipsis }, /* centered half-circle in the bottom half */
	{ "middlestraight", &init_middlestraight }, /* straight line, in the middle */
	{ "middleside", &init_middleside }, /* move from the middle to 1/2" off the bottom */
	{ "straighthalf", &init_topstraighthalf }, /* straight line, 1/2" off the top, stops in the middle; beware the rounded end */
	{ "middlepoint", &init_middlepoint }, /* just the rounded bit */
	{ "straight15", &init_topstraight15 }, /* straight line, 1+1/2" off the top */
	{ NULL, NULL}
};

int find_track_fun(const char *fname) {
	int nf = 0;
	int done = 0;
	while (!done && all_track_fun[nf].init != NULL) {
		if (strcmp(all_track_fun[nf].name, fname) == 0) {
			return nf;
		} else
			nf++;
	}
	return -1;
}


void synth(pngstruct *png, int argc, char **argv) {
	char c;
	extern int optind, optopt;
	int dpi = 120; // dot per inch
	double width = 3; // inches
	double length = 3; // inches
	int dogrid = 1;
	double trackwidth = 2.;
	const char * fname;
	int transpose = 0;
	int mirror = 0;
	int flip = 0;
	int x,y;
	int lf[10];
	int tr[10];
	int mi[10];
	int fl[10];
	double tw[10];
	int lfs = 0;
	int nf;
	const char* texname = "InchGrass.png";

	while ((c = getopt (argc, argv, "d:w:l:gt:f:TMFz:")) != -1) {
		switch (c)
		{
		case 'd':
			dpi = atoi(optarg);
			break;
		case 'w':
			width = atof(optarg);
			break;
		case 'l':
			length = atof(optarg);
			break;
		case 'g':
			dogrid = !dogrid;
			break;
		case 't':
			trackwidth = atof(optarg); /* width of the track, in each, sticky per-function */
			break;
		case 'f':
			fname = optarg;
			int nf = find_track_fun(fname);
			if (nf == -1)
				abort_("Don't know function '%s'\n", fname);
			lf[lfs] = nf;
			tr[lfs] = transpose;
			mi[lfs] = mirror;
			fl[lfs] = flip;
			tw[lfs] = trackwidth;
			lfs++;
			break;
		case 'T':
			transpose = !transpose; /* transpose, sticky per-function */
			break;
		case 'M':
			mirror = !mirror; /* mirror, sticky per-function */
			break;
		case 'F':
			flip = !flip; /* vertical mirror, sticky per-function */
			break;
		case 'z':
			texname = strdup(optarg);
			break;
		default:
			abort_("Unknown option to Synth");
		}
	}

	png->height = floor(dpi * width);
	png->width = floor(dpi * length); // don't ask
	png->bit_depth = 8;
	png->color_type = 0; // ???
	png->number_of_passes = 0; // ???

	allocpng(png);

	// Make everything black
        for (y=0; y<png->height; y++) {
                png_byte* row = png->row_pointers[y];
                for (x=0; x<png->width; x++) {
                        png_byte* ptr = &(row[x*4]);
			ptr[0] = 0;
			ptr[1] = 0;
			ptr[2] = 0;
			ptr[3] = 0;
                }
        }
	// texture
	tiletexture(png, texname, 0, 0, png->width, png->height, 0.1);
	// track
	fun_type fun[10];
	
	for (nf = 0 ; nf < lfs ; nf++) {
		all_track_fun[lf[nf]].init(&fun[nf], width, length, tw[nf]);
	}

	for (y=0; y<png->height; y++) {
                png_byte* row = png->row_pointers[y];
#pragma omp parallel for default(shared) private(x)
		for (x=0; x<png->width; x++) {
			png_byte* ptr = &(row[x*4]);
			int lnf;
			int intrack = 0;
			int inborder = 0;
			double maxborder = -1000.;
			for (lnf = 0 ; lnf < lfs ; lnf++) {
				fun_type lfun;
				memcpy(&lfun, &fun[lnf], sizeof(fun_type));
				int lx = x;
				int ly = y;
				if (mi[lnf])
					lx = png->width-x;
				if (fl[lnf])
					ly = png->height-y;
				if (!tr[lnf]) {
					lfun.x = (double)lx/(double)dpi;
					lfun.y = (double)ly/(double)dpi;
				} else {
					lfun.y = (double)lx/(double)dpi;
					lfun.x = (double)ly/(double)dpi;
				}
				double m = min_dist(&lfun);
				if (!isnan(m)) {
					if (m <= (tw[lnf]/2.)) {
						intrack = 1;
					} else if (m <= (tw[lnf]/2.+0.1)) {
						inborder = 1;
						maxborder = fmax(maxborder, 10. * ((tw[lnf]/2.+0.1)-m));
					}
				}
			}
			if (intrack) {
				// track surface
				ptr[0] = 10;
				ptr[1] = 10;
				ptr[2] = 10;
			} else if (inborder) {
				// hard border
				double offset = sin(maxborder * M_PI);
				double height = 20.;
				ptr[0] = floor(10. + height * offset);
				ptr[1] = floor(10. + height * offset);
				ptr[2] = floor(10. + height * offset);
			} 
		}
	}
	// grid
	if (dogrid)
		grid(png, dpi);
}
