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

#define FNAME "PNGFilter_3x3StraightIntoBanking"

void filter(pngstruct *png, int argc, char **argv) {
	char c;
	extern int optind, optopt;
	int x, y;
	int mirror = 0;
	
	while ((c = getopt (argc, argv, "m")) != -1) {
		switch (c)
		{
		case 'm':
			mirror = 1;
			break;
		default:
			abort_("Unknown option to filter %", FNAME);
		}
	}

        /* Expand any grayscale, RGB, or palette images to RGBA */
        png_set_expand(png->png_ptr);

        /* Reduce any 16-bits-per-sample images to 8-bits-per-sample */
        png_set_strip_16(png->png_ptr);

	int dpi = png->height/3; // should be a 3x3 tile

        for (y=0; y<png->height; y++) {
                png_byte* row = png->row_pointers[y];
                for (x=0; x<png->width; x++) {
			int dpi2 = png->width/3; // should be a 3x3 tile
			if (dpi != dpi2) {
				abort_("%s: non-square PNG", FNAME);
			}
                        png_byte* ptr = &(row[x*4]);
			
			int cy = y;
			if (mirror)
				cy = (3*dpi)-y;
			double bankingheight = 162.; // only 1/4 inch, but can't be much higher...
			if ((cy >= (0.5*dpi)) && (cy <= (2.5*dpi))) { // banked track
				double ldist = cy - 0.5 * dpi;
				double doffset = bankingheight * (cos(M_PI/2.+M_PI/2.*(1.-ldist/(2.*dpi)))+1.);
	                        double hdist = (3.*dpi)-(3.*dpi-x);
       		                double sdist = (cos(M_PI*(1.-hdist/(3.*dpi)))+1.)/2.;
				int offset = floor(doffset*sdist);
				ptr[0] += offset;
				ptr[1] += offset;
				ptr[2] += offset;
			} else
			if ((cy >= (2.5*dpi)) && (cy <= (2.6*dpi))) { // raise outer border
				double doffset = bankingheight;
                                double hdist = (3.*dpi)-(3.*dpi-x);
                                double sdist = (cos(M_PI*(1.-hdist/(3.*dpi)))+1.)/2.;
                                int offset = floor(doffset*sdist);
                                ptr[0] += offset;
                                ptr[1] += offset;
                                ptr[2] += offset;
			} else
                        if ((cy >= (2.6*dpi)) && (cy < (3.0*dpi))) { // remove cliff by sloping the texture
				double ldist = cy - 2.6 * dpi;
				double doffset = bankingheight * (cos(M_PI*(ldist/(0.4*dpi)))+1.)/2.;
                                double hdist = (3.*dpi)-(3.*dpi-x);
                                double sdist = (cos(M_PI*(1.-hdist/(3.*dpi)))+1.)/2.;
                                int offset = floor(doffset*sdist);
                                ptr[0] += offset;
                                ptr[1] += offset;
                                ptr[2] += offset;
                        }

                }
        }
}
