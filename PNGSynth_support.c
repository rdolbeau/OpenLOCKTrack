#include "PNGSynth_support.h"

#include <malloc.h>
#include <math.h>

void allocpng(pngstruct *png) {
	int y;
        png->row_pointers = (png_bytep*)malloc(sizeof(png_bytep) * png->height);
	png->rowbytes = png->width*4;
        for (y=0; y<png->height; y++)
                png->row_pointers[y] = (png_byte*)malloc(png->rowbytes);
}

void grid(pngstruct *png, const int dpi) {
	int x = 0,y = 0,z = 0;
	int adist[2] = { dpi/4, dpi }; // where are the lines (1/4 inch, inch)
	int aw[2] = { 2, 2 }; // line width, should be even
	unsigned char aoff[2] = { 5, 10 }; // line depth
	int i;
	unsigned char* layer = calloc(png->height * png->width, sizeof(unsigned char));
	// create a layer of offset
	for (i = 0 ; i < 2 ; i++) {
		int dist = adist[i];
		int w = aw[i];
		unsigned char off = aoff[i];
	
		for (y=0; y<png->height+1; y+=dist) {
			for (z = 0 ; z < w ; z++) {
				int o = z - w/2;
				if (((y+o)>=0) && ((y+o)<png->height)) {
					for (x=0; x<png->width; x++) {
						layer[x+(y+o)*png->width] = off;
					}
				}
			}
		}
	
		for (y=0; y<png->height; y++) {
			for (x=0; x<png->width+1; x+=dist) {
				for (z = 0 ; z < w ; z++) {
					int o = z - w/2;
					if (((x+o)>=0) && ((x+o)<png->width)) {
						layer[(x+o)+y*png->width] = off;
					}
				}
			}
		}
	}
	// apply layer to image
	for (y=0; y<png->height; y++) {
		png_byte *row = png->row_pointers[y];
		for (x=0; x<png->width; x++) {
			png_byte* ptr = &(row[x*4]);
			if (ptr[0] >= layer[x+y*png->width])
				ptr[0] -= layer[x+y*png->width];
			else
				ptr[0] = 0;
			if (ptr[1] >= layer[x+y*png->width])
				ptr[1] -= layer[x+y*png->width];
			else
				ptr[1] = 0;
			if (ptr[2] >= layer[x+y*png->width])
				ptr[2] -= layer[x+y*png->width];
			else
				ptr[2] = 0;
		}
	}
	free(layer);
}


int tiletexture(pngstruct *png, const char* filename, const int px, const int py, const int lx, const int ly, const double g) {
	pngstruct texture;
	int x, y;
	read_png_file(filename, &texture);

	for (y = 0 ; y < ly ; y++) {
		png_byte *row  = png->row_pointers[y+py];
		png_byte *trow = texture.row_pointers[y%texture.height];
		for (x = 0 ; x < lx ; x++) {
			png_byte* ptr  = &( row[(x+px)*4]);
			png_byte* tptr = &(trow[(x%texture.width)*4]);
			ptr[0] = floor(tptr[0] * g);
			ptr[1] = floor(tptr[1] * g);
			ptr[2] = floor(tptr[2] * g);
		}
	}
	return 1;
}
