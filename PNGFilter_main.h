#ifndef _PNGFILTER_MAIN_H_
#define _PNGFILTER_MAIN_H_
#include <png.h>

typedef struct {
	int width, height, rowbytes;
	png_byte color_type;
	png_byte bit_depth;
	
	png_structp png_ptr;
	png_infop info_ptr;
	int number_of_passes;
	png_bytep * row_pointers;
} pngstruct;

void filter(pngstruct *png, int argc, char **argv); 
void synth(pngstruct *png, int argc, char **argv); 
void abort_(const char * s, ...);

void read_png_file(const char* file_name, pngstruct *png);
void write_png_file(const char* file_name, pngstruct *png);

#endif
