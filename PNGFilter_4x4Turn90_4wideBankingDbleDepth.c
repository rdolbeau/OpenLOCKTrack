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

#define FNAME "PNGFilter_4x4Turn90_4wideBankingDbleDepth"

void filter(pngstruct *png, int argc, char **argv) {
	char c;
	extern int optind, optopt;
	int x, y;
	int taperb = 0;
	int tapere = 0;
	
	while ((c = getopt (argc, argv, "be")) != -1) {
		switch (c)
		{
		case 'b':
			taperb = 1;
			break;
		case 'e':
                        tapere = 1;
                        break;
		default:
			abort_("Unknown option to filter %", FNAME);
		}
	}

        /* Expand any grayscale, RGB, or palette images to RGBA */
        png_set_expand(png->png_ptr);

        /* Reduce any 16-bits-per-sample images to 8-bits-per-sample */
        png_set_strip_16(png->png_ptr);

	int dpi = png->height/6; // should be a 6x6 tile // width

        for (y=0; y<png->height; y++) {
                png_byte* row = png->row_pointers[y];
                for (x=0; x<png->width; x++) {
			int dpi2 = png->width/6; // width
			if (dpi != dpi2) {
				abort_("%s: non-square PNG", FNAME);
			}
                        png_byte* ptr = &(row[x*4]);
			
			int cx = (6*dpi) - x; //width
			int cy = (6*dpi) - y; //width
			double alimit = M_PI/12.;
			double depthscale = 2.;
			double bankingheight = 162. * 2.;
			double dist = sqrt((double)cx*(double)cx+(double)cy*(double)cy);
			double angle = acos((double)cy/dist);
			double angle2 = acos((double)cx/dist);
			if ((dist >= (1.5*dpi)) && (dist <= (5.5*dpi))) { // banked track
				double ldist = dist - 1.5 * dpi;
				double doffset = bankingheight * (cos(M_PI/2.+M_PI/2.*(1.-ldist/(4.*dpi)))+1.);
				if (taperb && (angle <= alimit)) {
					doffset = doffset * (cos(M_PI*(1.-angle/alimit))+1.)/2.;
				}
                                if (tapere && (angle2 <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle2/alimit))+1.)/2.;
                                }
				ptr[0] = floor(((double)ptr[0] + doffset)/depthscale);
				ptr[1] = floor(((double)ptr[1] + doffset)/depthscale);
				ptr[2] = floor(((double)ptr[2] + doffset)/depthscale);
			} else
			if ((dist >= (5.5*dpi)) && (dist <= (5.6*dpi))) { // raise outer border
				double doffset = bankingheight;
				if (taperb && (angle <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle/alimit))+1.)/2.;
                                }
                                if (tapere && (angle2 <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle2/alimit))+1.)/2.;
                                }
                                ptr[0] = floor(((double)ptr[0] + doffset)/depthscale);
                                ptr[1] = floor(((double)ptr[1] + doffset)/depthscale);
                                ptr[2] = floor(((double)ptr[2] + doffset)/depthscale);
			} else
                        if ((dist >= (5.6*dpi)) && (dist< (6.0*dpi))) { // remove cliff by sloping the texture
				double ldist = dist - 5.6 * dpi;
				double doffset = bankingheight * (cos(M_PI*(ldist/(0.4*dpi)))+1.)/2.;
                                if (taperb && (angle <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle/alimit))+1.)/2.;
                                }
                                if (tapere && (angle2 <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle2/alimit))+1.)/2.;
                                }
                                ptr[0] = floor(((double)ptr[0] + doffset)/depthscale);
                                ptr[1] = floor(((double)ptr[1] + doffset)/depthscale);
                                ptr[2] = floor(((double)ptr[2] + doffset)/depthscale);
                        } else {
				ptr[0] /= 2;
                                ptr[1] /= 2;
                                ptr[2] /= 2;
			}

                }
        }
}
