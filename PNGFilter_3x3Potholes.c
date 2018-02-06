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

#define FNAME "PNGFilter_3x3Potholes"

void filter(pngstruct *png, int argc, char **argv) {
 	char c;
	extern int optind, optopt;
	int x, y, z;
	int *lx = (int*)malloc(sizeof(int));
	int *ly = (int*)malloc(sizeof(int));
	int np = 0;	

	while ((c = getopt (argc, argv, "p:")) != -1) {
		switch (c)
		{
		case 'p':
			{
				int tx, ty;
				int r = sscanf(optarg, "%d,%d", &tx, &ty);
				if (r!=2) {
					abort_("Wrong parameter '%s' to filter %", optarg, FNAME);
				}
				if ((tx < 0) || (tx > 12) ||
				    (ty < 0) || (ty > 12)) {
					abort_("Wrong position '%d,%d' to filter %", tx, ty, FNAME);
				}
				lx[np] = tx;
				ly[np] = ty;
				np++;
				lx = (int*)realloc(lx, sizeof(int)*np);
				ly = (int*)realloc(ly, sizeof(int)*np);
			}	
			break;
		default:
			abort_("Unknown option to filter %", FNAME);
		}
	}
	
	srand48(0); // reproducible random;

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
			double sqradius = (dpi/8.)*(dpi/8.)-1;
			int offset = 162; // 1/4 inch (255 is 10 mm, 1/4 inch is 6.35 mm and 162/255 ~= .635
			for (z = 0 ; z < np ; z++) {
				double centerx = ((double)lx[z] * (double)dpi) / 4. + (dpi / 8.)-1;
				double centery = ((double)ly[z] * (double)dpi) / 4. + (dpi / 8.)-1;
				double d = (x-centerx)*(x-centerx) + (y-centery)*(y-centery);
				d += drand48()*10.; // jagged edge
				if (d < sqradius) {
					offset = (162 * 3) / 4; // potholes are 1/16 inch deep
					offset += floor(20.*(d/sqradius));
					offset += floor(20.*(d/sqradius)) * drand48(); // jagged bottom
				}
			}
			ptr[0] += offset;
			ptr[1] += offset;
			ptr[2] += offset;
		}
        }
}
