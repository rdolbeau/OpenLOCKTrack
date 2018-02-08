#ifndef _PNGSYNTH_SUPPORT_H_
#define _PNGSYNTH_SUPPORT_H_
#include "PNGFilter_main.h"

void allocpng(pngstruct *png);
void grid(pngstruct *png, const int dpi);

int tiletexture(pngstruct *png, const char* filename, const int px, const int py, const int lx, const int ly, const double g);

#endif
