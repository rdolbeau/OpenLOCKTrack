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

#define FNAME "PNGFilter_4x4Turn90Banking"

void filter(pngstruct *png, int argc, char **argv) {
	char c;
	extern int optind, optopt;
	int x, y;
	int taperb = 0;
	int tapere = 0;
	int size = 4;
	int tw = 2;
	
	while ((c = getopt (argc, argv, "bes:t:")) != -1) {
		switch (c)
		{
		case 'b':
			taperb = 1;
			break;
		case 'e':
                        tapere = 1;
                        break;
		case 's':
			size = atoi(optarg);
			if (size < 3 || size > 6) {
				abort_("Wrong size specified");
			}
			break;
		case 't':
			tw = atoi(optarg);
			if (tw < 2 || tw > 6) {
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

	int dpi = png->height/size; // should be a 4x4 tile

        for (y=0; y<png->height; y++) {
                png_byte* row = png->row_pointers[y];
                for (x=0; x<png->width; x++) {
			int dpi2 = png->width/size; // should be a 4x4 tile
			if (dpi != dpi2) {
				abort_("%s: non-square PNG", FNAME);
			}
                        png_byte* ptr = &(row[x*4]);
			double dsize = size;
			int cx = (size*dpi) - x;
			int cy = (size*dpi) - y;
			double alimit = M_PI/12.;
			double bankingheight = 162.; // only 1/4 inch, but can't be much higher...
			double dist = sqrt((double)cx*(double)cx+(double)cy*(double)cy);
			double angle = acos((double)cy/dist);
			double angle2 = acos((double)cx/dist);
			if ((dist >= ((dsize-(tw+0.5))*dpi)) && (dist <= ((dsize-0.5)*dpi))) { // banked track
				double ldist = dist - (dsize-(tw+0.5)) * dpi;
				double doffset = bankingheight * (cos(M_PI/2.+M_PI/2.*(1.-ldist/(tw*dpi)))+1.);
				if (taperb && (angle <= alimit)) {
					doffset = doffset * (cos(M_PI*(1.-angle/alimit))+1.)/2.;
				}
                                if (tapere && (angle2 <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle2/alimit))+1.)/2.;
                                }
				int offset = floor(doffset);
				ptr[0] += offset;
				ptr[1] += offset;
				ptr[2] += offset;
			} else
			if ((dist >= ((dsize-0.5)*dpi)) && (dist <= ((dsize-0.4)*dpi))) { // raise outer border
				double doffset = bankingheight;
				if (taperb && (angle <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle/alimit))+1.)/2.;
                                }
                                if (tapere && (angle2 <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle2/alimit))+1.)/2.;
                                }
                                int offset = floor(doffset);
                                ptr[0] += offset;
                                ptr[1] += offset;
                                ptr[2] += offset;
			} else
			if ((dist >= ((dsize-0.4)*dpi)) && (dist< (dsize*dpi))) { // remove cliff by sloping the texture
				double ldist = dist - (dsize-0.4) * dpi;
				double doffset = bankingheight * (cos(M_PI*(ldist/(0.4*dpi)))+1.)/2.;
                                if (taperb && (angle <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle/alimit))+1.)/2.;
                                }
                                if (tapere && (angle2 <= alimit)) {
                                        doffset = doffset * (cos(M_PI*(1.-angle2/alimit))+1.)/2.;
                                }
                                int offset = floor(doffset);
                                ptr[0] += offset;
                                ptr[1] += offset;
                                ptr[2] += offset;
                        }

                }
        }
}
