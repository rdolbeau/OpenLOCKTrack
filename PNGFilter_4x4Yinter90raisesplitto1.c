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

#define FNAME "PNGFilter_4x4Yinter90raisesplitto1"

void filter(pngstruct *png, int argc, char **argv) {
	char c;
	extern int optind, optopt;
	int x, y;
	int taper = 0;
	
	while ((c = getopt (argc, argv, "t")) != -1) {
		switch (c)
		{
		case 't':
			taper = 1;
			break;
		default:
			abort_("Unknown option to filter %", FNAME);
		}
	}

        /* Expand any grayscale, RGB, or palette images to RGBA */
        png_set_expand(png->png_ptr);

        /* Reduce any 16-bits-per-sample images to 8-bits-per-sample */
        png_set_strip_16(png->png_ptr);

	int dpi = png->height/4; // should be a 4x4 tile

        for (y=0; y<png->height; y++) {
                png_byte* row = png->row_pointers[y];
                for (x=0; x<png->width; x++) {
			int dpi2 = png->width/4;
			if (dpi != dpi2) {
				abort_("%s: non-square PNG", FNAME);
			}
                        png_byte* ptr = &(row[x*4]);

			if (y>(2*dpi+dpi/2+dpi/10)) {
				double dist = ((1.5*dpi)-(double)(4*dpi-y))/(1.5*dpi);
				double sdist = (cos(M_PI*(1.-dist))+1.)/2.;
				//int offset = floor(162.*((1.5*dpi)-(double)(4*dpi-y))/(1.5*dpi));
				int offset = floor(162. * sdist);
				// tapering
				if (taper && (x < (dpi/2 - dpi/10))) {
					double factor = (double)x/(0.45*dpi);
					offset = floor(offset * factor);
				}
				if (taper && (x > 3*dpi)) {
					double factor = (4.*dpi-(double)x)/(double)dpi;
					offset = floor(offset * factor);
				}
				ptr[0] += offset;
				ptr[1] += offset;
				ptr[2] += offset;
			}

                }
        }
}
