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

#define FNAME "PNGFilter_NxMStraightIntoBanking"

void filter(pngstruct *png, int argc, char **argv) {
	char c;
	extern int optind, optopt;
	int x, y;
	int mirror = 0;
	int width = 3;
	int length = 3;
	double tw = 2;
	
	while ((c = getopt (argc, argv, "mw:l:s:t:")) != -1) {
		switch (c)
		{
		case 'm':
			mirror = 1;
			break;
		case 'w':
			width = atoi(optarg);
			if (width < 1 || width > 6) {
				abort_("Wrong width specified");
			}
			break;
		case 'l':
			length = atoi(optarg);
			if (length < 1 || length > 6) {
				abort_("Wrong length specified");
			}
			break;
		case 't':
			tw = atof(optarg);
			if (tw < 2. || tw > 6.) {
				abort_("Wrong trackwidth specified");
			}
			break;
		default:
			abort_("Unknown option to filter %", FNAME);
		}
	}

        /* Expand any grayscale, RGB, or palette images to RGBA */
        png_set_expand(png->png_ptr);

        /* Reduce any 16-bits-per-sample images to 8-bits-per-sample */
        png_set_strip_16(png->png_ptr);

	int dpi = png->height/width;

        for (y=0; y<png->height; y++) {
                png_byte* row = png->row_pointers[y];
                for (x=0; x<png->width; x++) {
			int dpi2 = png->width/length;
			if (dpi != dpi2) {
				abort_("%s: wrong sized PNG", FNAME);
			}
                        png_byte* ptr = &(row[x*4]);
			
			double cy = y;
			if (mirror)
				cy = ((double)width*(double)dpi)-y;
			double bankingheight = 162.; // only 1/4 inch, but can't be much higher...
			double inner = (width - (tw + 0.5)) * dpi;
			double outer = (width - 0.5) * dpi;
			double outerb = (width - 0.4) * dpi;
			if ((cy >= inner) && (cy <= outer)) { // banked track
				double ldist = cy - 0.5 * dpi;
				double doffset = bankingheight * (cos(M_PI/2.+M_PI/2.*(1.-ldist/(tw*dpi)))+1.);
       		                double sdist = (cos(M_PI*(1.-x/((double)length*(double)dpi)))+1.)/2.;
				int offset = floor(doffset*sdist);
				ptr[0] += offset;
				ptr[1] += offset;
				ptr[2] += offset;
			} else
			if ((cy >= outer) && (cy <= outerb)) { // raise outer border
				double doffset = bankingheight;
                                double sdist = (cos(M_PI*(1.-x/((double)length*(double)dpi)))+1.)/2.;
                                int offset = floor(doffset*sdist);
                                ptr[0] += offset;
                                ptr[1] += offset;
                                ptr[2] += offset;
			} else
			if ((cy >= outerb) && (cy < ((double)width * (double)dpi))) { // remove cliff by sloping the texture
				double ldist = cy - outerb;
				double doffset = bankingheight * (cos(M_PI*(ldist/(0.4*dpi)))+1.)/2.;
                                double sdist = (cos(M_PI*(1.-x/((double)length*(double)dpi)))+1.)/2.;
                                int offset = floor(doffset*sdist);
                                ptr[0] += offset;
                                ptr[1] += offset;
                                ptr[2] += offset;
                        }

                }
        }
}
