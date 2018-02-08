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

#include <math.h>

#include "PNGFilter_main.h"

void abort_(const char * s, ...)
{
        va_list args;
        va_start(args, s);
        vfprintf(stderr, s, args);
        fprintf(stderr, "\n");
        va_end(args);
        abort();
}

void read_png_file(const char* file_name, pngstruct *png)
{
	int y;
        unsigned char header[8];    // 8 is the maximum size that can be checked

        /* open file and test for it being a png */
        FILE *fp = fopen(file_name, "rb");
        if (!fp)
                abort_("[read_png_file] File %s could not be opened for reading", file_name);
        fread(header, 1, 8, fp);
        if (png_sig_cmp(header, 0, 8))
                abort_("[read_png_file] File %s is not recognized as a PNG file", file_name);


        /* initialize stuff */
        png->png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

        if (!png->png_ptr)
                abort_("[read_png_file] png_create_read_struct failed");
	png_set_gray_to_rgb(png->png_ptr);
	png_set_expand(png->png_ptr);
        png_set_strip_16(png->png_ptr);

        png->info_ptr = png_create_info_struct(png->png_ptr);
        if (!png->info_ptr)
                abort_("[read_png_file] png_create_info_struct failed");

        if (setjmp(png_jmpbuf(png->png_ptr)))
                abort_("[read_png_file] Error during init_io");

        png_init_io(png->png_ptr, fp);
        png_set_sig_bytes(png->png_ptr, 8);

        png_read_info(png->png_ptr, png->info_ptr);

        png->width = png_get_image_width(png->png_ptr, png->info_ptr);
        png->height = png_get_image_height(png->png_ptr, png->info_ptr);
        png->color_type = png_get_color_type(png->png_ptr, png->info_ptr);
        png->bit_depth = png_get_bit_depth(png->png_ptr, png->info_ptr);

        png->number_of_passes = png_set_interlace_handling(png->png_ptr);
        png_read_update_info(png->png_ptr, png->info_ptr);


        /* read file */
        if (setjmp(png_jmpbuf(png->png_ptr)))
                abort_("[read_png_file] Error during read_image");

        png->row_pointers = (png_bytep*) malloc(sizeof(png_bytep) * png->height);

        if (png->bit_depth == 16)
                png->rowbytes = png->width*8;
        else
                png->rowbytes = png->width*4;

        for (y=0; y<png->height; y++)
                png->row_pointers[y] = (png_byte*) malloc(png->rowbytes);

        png_read_image(png->png_ptr, png->row_pointers);

        fclose(fp);
}


void write_png_file(const char* file_name, pngstruct *png)
{
	int y;
        /* create file */
        FILE *fp = fopen(file_name, "wb");
        if (!fp)
                abort_("[write_png_file] File %s could not be opened for writing", file_name);


        /* initialize stuff */
        png->png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

        if (!png->png_ptr)
                abort_("[write_png_file] png_create_write_struct failed");

        png->info_ptr = png_create_info_struct(png->png_ptr);
        if (!png->info_ptr)
                abort_("[write_png_file] png_create_info_struct failed");

        if (setjmp(png_jmpbuf(png->png_ptr)))
                abort_("[write_png_file] Error during init_io");

        png_init_io(png->png_ptr, fp);


        /* write header */
        if (setjmp(png_jmpbuf(png->png_ptr)))
                abort_("[write_png_file] Error during writing header");

        png_set_IHDR(png->png_ptr, png->info_ptr, png->width, png->height,
                     8, 6, PNG_INTERLACE_NONE,
                     PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);

        png_write_info(png->png_ptr, png->info_ptr);


        /* write bytes */
        if (setjmp(png_jmpbuf(png->png_ptr)))
                abort_("[write_png_file] Error during writing bytes");

        png_write_image(png->png_ptr, png->row_pointers);


        /* end write */
        if (setjmp(png_jmpbuf(png->png_ptr)))
                abort_("[write_png_file] Error during end of write");

        png_write_end(png->png_ptr, NULL);

        /* cleanup heap allocation */
        for (y=0; y<png->height; y++)
                free(png->row_pointers[y]);
        free(png->row_pointers);

        fclose(fp);
}

int main(int argc, char **argv)
{
	pngstruct png;
#ifndef PNG_SYNTH
        if (argc < 3)
                abort_("Usage: program_name <file_in> <file_out>  [<filter_options>]");
	{
		const char *in = strndup(argv[1], 4096);
		const char *out = strndup(argv[2], 4096);

		read_png_file(in, &png);
		filter(&png, argc, argv);
		write_png_file(out, &png);
	}
#else
        if (argc < 2)
                abort_("Usage: program_name <file_out>  [<synth_options>]");
	{
		const char *out = strndup(argv[1], 4096);

		synth(&png, argc, argv);
		write_png_file(out, &png);
	}
#endif

        return 0;
}
