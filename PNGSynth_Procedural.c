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
	void (*init)(fun_type*, int, int, double);
} track_fun;

void init_myyline(fun_type* fun, int width, int length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_yline;
        fun->params[0] = tw/2.+0.5;
}

void init_mynegsemiellipsis(fun_type* fun, int width, int length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_negsemiellipsis;
        fun->params[0] = length-(tw/2.+0.5); // !
        fun->params[1] = width-(tw/2.+0.5);
        fun->params[2] = length;
        fun->params[3] = width;
}

void init_mywavyline(fun_type* fun, int width, int length, double tw) {
        fun->min = 0.;
        fun->max = length;
        fun->fun = &my_wavyline;
        fun->params[0] = 0;
        fun->params[1] = length;
	fun->params[2] = width-(tw/2.+0.5);
	fun->params[3] = 0.5 + tw/2.;
}

track_fun all_track_fun[] = {
	{ "straight", &init_myyline },
	{ "turn90", &init_mynegsemiellipsis },
	{ "side", &init_mywavyline },
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
	int width = 3; // inches
	int length = 3; // inches
	int dogrid = 1;
	double trackwidth = 2.;
	const char * fname;
	int transpose = 0;
	int mirror = 0;
	int x,y;
	int lf[10];
	int tr[10];
	int mi[10];
	int lfs = 0;
	int nf;

	while ((c = getopt (argc, argv, "d:w:l:gt:f:TM")) != -1) {
		switch (c)
		{
		case 'd':
			dpi = atoi(optarg);
			break;
		case 'w':
			width = atoi(optarg);
			break;
		case 'l':
			length = atoi(optarg);
			break;
		case 'g':
			dogrid = !dogrid;
			break;
		case 't':
			trackwidth = atof(optarg);
			break;
		case 'f':
			fname = optarg;
			int nf = find_track_fun(fname);
			if (nf == -1)
				abort_("Don't know function '%s'\n", fname);
			lf[lfs] = nf;
			tr[lfs] = transpose;
			mi[lfs] = mirror;
			lfs++;
			break;
		case 'T':
			transpose = !transpose;
			break;
		case 'M':
			mirror = !mirror;
			break;
		default:
			abort_("Unknown option to Synth");
		}
	}

	png->height = dpi * width;
	png->width = dpi * length; // don't ask
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
	tiletexture(png, "InchGrass.png", 0, 0, png->width, png->height, 0.1);
	// track
	fun_type fun[10];
	
	for (nf = 0 ; nf < lfs ; nf++) {
		all_track_fun[lf[nf]].init(&fun[nf], width, length, trackwidth);
	}

	int byinches[length][width];
	memset(byinches, 0, sizeof(int)*width*length);
	for (y=0; y<png->height; y++) {
                png_byte* row = png->row_pointers[y];
#pragma omp parallel for default(shared) private(x)
		for (x=0; x<png->width; x++) {
			png_byte* ptr = &(row[x*4]);
			double m = 100000.;
			int lnf;
			for (lnf = 0 ; lnf < lfs ; lnf++) {
				fun_type lfun;
				memcpy(&lfun, &fun[lnf], sizeof(fun_type));
				int lx = x;
				if (mi[lnf])
					lx = png->width-x;
				if (!tr[lnf]) {
					lfun.x = (double)lx/(double)dpi;
					lfun.y = (double)y/(double)dpi;
				} else {
					lfun.y = (double)lx/(double)dpi;
					lfun.x = (double)y/(double)dpi;
				}
				double m2 = min_dist(&lfun);
				if (!isnan(m2))
					m = fmin(m, m2);
			}
			if (!isnan(m)) {
				if (m <= (trackwidth/2.)) {
					// track surface
					ptr[0] = 10;
					ptr[1] = 10;
					ptr[2] = 10;
					byinches[x/dpi][y/dpi] = 1;
				} else if (m <= (trackwidth/2.+0.1)) {
					// hard border
					double offset = sin(10. * ((trackwidth/2.+0.1)-m) * M_PI);
					double height = 20.;
					ptr[0] = floor(10. + height * offset);
					ptr[1] = floor(10. + height * offset);
					ptr[2] = floor(10. + height * offset);
				} 
			}
		}
	}
	// grid
	if (dogrid)
		grid(png, dpi);

#if 0
	for (x = 0 ; x < width ; x++) {
		for (y = 0 ; y < length ; y++) {
			printf("\t%d", byinches[x][y]);
		}
		printf("\n");
	}
#endif
}
