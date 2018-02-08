CC=gcc
CFLAGS=-O2 -Wall

OPENSCAD=/usr/local/openscad-openscad-2015.03/bin/openscad
INKSCAPE=inkscape
DPI=120

all:gen_scad

gen_scad: gen_scad.c
	$(CC) $(CFLAGS) $< -o $@

# STL from auto-generated scad, Level 0 
STLS=	3x3Crossing_auto_0.stl \
	3x3Straight_auto_0.stl \
	3x3Turn90_auto_0.stl \
	4x4Turn90_auto_0Y1.stl 4x4Turn90_auto_0Y2.stl \
	4x4Turn90_auto_0OA1.stl 4x4Turn90_auto_0OA2.stl \
	4x4Turn90_auto_0V.stl \
	4x2-4x4Side1Part1_auto_0.stl 4x2-4x4Side1Part2_auto_0.stl \
	2x2-6x6Turn90Part1_auto_0.stl 2x2-6x6Turn90Part2_auto_0.stl 3x3-6x6Turn90Part3_auto_0.stl 3x3-6x6Turn90Part4_auto_0.stl \
	4x4Turn90BankedBE_auto_0.stl \
	4x4Turn90BankedB_auto_0.stl \
	4x4Turn90BankedE_auto_0.stl \
	4x4Turn90Banked_auto_0.stl \
	3x3Turn90Banked_auto_0.stl \
	4x4Yinter90_auto_0.stl \
	4x4Yinter90Raised_auto_0.stl \
	3x3SmoothRamp_auto_0.stl \
	3x3StraightIntoBankingRight_auto_0.stl 3x3StraightIntoBankingLeft_auto_0.stl

STL1S=	3x3Crossing_auto_1.stl \
	3x3Straight_auto_1.stl \
	3x3Turn90_auto_1.stl \
	4x4Turn90_auto_1Y1.stl 4x4Turn90_auto_1Y2.stl \
	4x4Turn90_auto_1OA1.stl 4x4Turn90_auto_1OA2.stl \
	4x4Turn90_auto_1V.stl \
	4x2-4x4Side1Part1_auto_1.stl 4x2-4x4Side1Part2_auto_1.stl \
	2x2-6x6Turn90Part1_auto_1.stl 2x2-6x6Turn90Part2_auto_1.stl 3x3-6x6Turn90Part3_auto_1.stl 3x3-6x6Turn90Part4_auto_1.stl \
	4x4Turn90BankedBE_auto_1.stl \
	4x4Turn90BankedB_auto_1.stl \
	4x4Turn90BankedE_auto_1.stl \
	4x4Turn90Banked_auto_1.stl \
	3x3Turn90Banked_auto_1.stl \
	4x4Yinter90_auto_1.stl \
	3x3StraightIntoBankingRight_auto_1.stl 3x3StraightIntoBankingLeft_auto_1.stl \
	3x3StraightPotholes_auto_1.stl

# STL from manual scad
EXTRASTLS=3x1CheckPoint.stl 3x1Ramp0_1.stl 3x1Ramp0_2.stl 3x1Ramp1_2.stl

SCADS=$(STLS:.stl=.scad) $(STL1S:.stl=.scad)

GENPNGS=3x3Straight.png 3x3Crossing.png 3x3Turn90.png 4x4Side1.png 6x6Turn90.png 4x4Yinter90.png

# generate the OpenSCAD files
allscad: gen_scad $(SCADS)

# convert scad to stl (IT TAKES A LOT OF MEMORY !)
allstl: allscad $(STLS) $(STL1S) $(EXTRASTLS)

# default rule for the simple stuff, using
# a PNG on a regular OpenLOCK piece
%_auto_0.scad: %.png
	./gen_scad -d $(DPI) $^

%_auto_1.scad: %.png
	./gen_scad -d $(DPI) -L 1 $^

## some usefule split for easier printing
# This one uses only 26 square inches instead of 36
# by using 2 EA and 2 E pieces (instead of a 6x6)
2x2-6x6Turn90Part1.png: 6x6Turn90.png
	convert $< -crop 240x240+120+120 $@
2x2-6x6Turn90Part2.png: 6x6Turn90.png
	convert $< -crop 240x240+360+360 $@
3x3-6x6Turn90Part3.png: 6x6Turn90.png
	convert $< -crop 360x360+360+0 $@
3x3-6x6Turn90Part4.png: 6x6Turn90.png
	convert $< -crop 360x360+0+360 $@


# cut an U piece into 2 R pieces
4x2-4x4Side1Part1.png: 4x4Side1.png
	convert $< -crop 480x240+0+0 $@
4x2-4x4Side1Part2.png: 4x4Side1.png
	convert $< -crop 480x240+0+240 $@


# cut an U piece into 2 Y pieces - beware loss of surface !
4x4Turn90_auto_0Y1.scad 4x4Turn90_auto_0Y2.scad: 4x4Turn90.png
	./gen_scad -d $(DPI) -T Y $<

4x4Turn90_auto_1Y1.scad 4x4Turn90_auto_1Y2.scad: 4x4Turn90.png
	./gen_scad -d $(DPI) -T Y -L 1 $<


# cut an U piece into 2 OA pieces
4x4Turn90_auto_0OA1.scad 4x4Turn90_auto_0OA2.scad: 4x4Turn90.png
	./gen_scad -d $(DPI) -T OA $<

4x4Turn90_auto_1OA1.scad 4x4Turn90_auto_1OA2.scad: 4x4Turn90.png
	./gen_scad -d $(DPI) -T OA -L 1 $<


# trim a U piece to a V piece
4x4Turn90_auto_0V.scad: 4x4Turn90.png
	./gen_scad -d $(DPI) -T V $<

4x4Turn90_auto_1V.scad: 4x4Turn90.png
	./gen_scad -d $(DPI) -T V -L 1 $<

# variable-height ramps on SA pieces (STL)
3x1Ramp0_1.stl: 3x1Ramp0_1.scad 3x3Straight.png
	$(OPENSCAD) -Dlow=0 -Dheight=1 $< -o $@

3x1Ramp0_2.stl: 3x1Ramp0_1.scad 3x3Straight.png
	$(OPENSCAD) -Dlow=0 -Dheight=2 $< -o $@

3x1Ramp1_2.stl: 3x1Ramp0_1.scad 3x3Straight.png
	$(OPENSCAD) -Dlow=1 -Dheight=1 $< -o $@

# checkpoint
3x1CheckPoint.stl: 3x1CheckPoint.scad 3x3Straight.png
	$(OPENSCAD) $< -o $@

# Potholes - there use -L 0 but are Lvl1 because of the post-processing
3x3StraightPotholes_auto_1.scad: 3x3StraightPotholes.png
	./gen_scad -d $(DPI) -L 0 -E 1 $<

# default rule to generate the STL
%.stl: %.scad
	$(OPENSCAD) $< -o $@

clean:
	echo "Are you sure ? Creating STL is a long and memory-hungry process. If so, use make veryclean"

veryclean:
	/bin/rm -f $(STLS) $(STL1S) $(SCADS) $(EXTRASTLS)

# custom filters
PNGFilter_4x4Yinter90raisesplitto1: PNGFilter_main.c PNGFilter_4x4Yinter90raisesplitto1.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm

4x4Yinter90Raised.png: 4x4Yinter90.png PNGFilter_4x4Yinter90raisesplitto1
	./PNGFilter_4x4Yinter90raisesplitto1 $< $@


PNGFilter_3x3Potholes: PNGFilter_main.c PNGFilter_3x3Potholes.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm

3x3StraightPotholes.png: 3x3Straight.png PNGFilter_3x3Potholes
	./PNGFilter_3x3Potholes $< $@ -p 1,5 -p 9,9 -p 8,4


PNGFilter_3x3SmoothRamp: PNGFilter_main.c PNGFilter_3x3SmoothRamp.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm

3x3SmoothRamp.png: 3x3Straight.png PNGFilter_3x3SmoothRamp
	./PNGFilter_3x3SmoothRamp $< $@


PNGFilter_4x4Turn90Banking: PNGFilter_main.c PNGFilter_4x4Turn90Banking.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm

PNGFilter_4x4Turn90BankingDbleDepth: PNGFilter_main.c PNGFilter_4x4Turn90BankingDbleDepth.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm


4x4Turn90BankedBE.png: 4x4Turn90.png PNGFilter_4x4Turn90Banking
	./PNGFilter_4x4Turn90Banking $< $@ -b -e -s 4
4x4Turn90BankedB.png: 4x4Turn90.png PNGFilter_4x4Turn90Banking
	./PNGFilter_4x4Turn90Banking $< $@ -b -s 4
4x4Turn90BankedE.png: 4x4Turn90.png PNGFilter_4x4Turn90Banking
	./PNGFilter_4x4Turn90Banking $< $@ -e -s 4
4x4Turn90Banked.png: 4x4Turn90.png PNGFilter_4x4Turn90Banking
	./PNGFilter_4x4Turn90Banking $< $@ -s 4
4x4Turn90BankedDbleDepth.png: 4x4Turn90.png PNGFilter_4x4Turn90BankingDbleDepth
	./PNGFilter_4x4Turn90BankingDbleDepth $< $@
4x4Turn90BankedDbleDepth_auto_0.scad: 4x4Turn90BankedDbleDepth.png
	./gen_scad -d $(DPI) -s 0.2 $^

3x3Turn90Banked.png: 3x3Turn90.png PNGFilter_4x4Turn90Banking
	./PNGFilter_4x4Turn90Banking $< $@ -s 3

PNGFilter_3x3StraightIntoBanking: PNGFilter_main.c PNGFilter_3x3StraightIntoBanking.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm

3x3StraightIntoBankingRight.png: 3x3Straight.png PNGFilter_3x3StraightIntoBanking
	./PNGFilter_3x3StraightIntoBanking $< $@
3x3StraightIntoBankingLeft.png: 3x3Straight.png PNGFilter_3x3StraightIntoBanking
	./PNGFilter_3x3StraightIntoBanking $< $@ -m


# Procedurally generate PNG
PNGSynth: PNGFilter_main.c PNGSynth_gsl.c PNGSynth_Procedural.c PNGSynth_support.c
	$(CC) $(CFLAGS) -fopenmp -DPNG_SYNTH -lpng -lgsl -lgslcblas -lm $^ -o $@

3x3Straight.png: PNGSynth
	./PNGSynth $@ -f straight -t 2 -l 3 -w 3

3x3Crossing.png: PNGSynth
	./PNGSynth $@ -f straight -T -f straight -T -t 2 -l 3 -w 3

3x3Turn90.png: PNGSynth
	./PNGSynth $@ -f turn90 -t 2 -l 3 -w 3

4x4Turn90.png: PNGSynth
	./PNGSynth $@ -f turn90 -t 2 -l 4 -w 4

4x4Side1.png: PNGSynth
	./PNGSynth $@ -f side -t 2 -l 4 -w 4

6x6Turn90.png: PNGSynth
	./PNGSynth $@ -f turn90 -t 2 -l 6 -w 6

4x4Yinter90.png: PNGSynth
	./PNGSynth $@ -f turn90 -f straight -t 2 -l 4 -w 4
