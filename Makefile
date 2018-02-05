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
	4x4Side1_auto_0cx2.0cy4.0mx2.0.stl 4x4Side1_auto_0cx2.0cy4.0.stl \
	6x6Turn90_auto_0cx2.0cy2.0mx1.0my1.0.stl 6x6Turn90_auto_0cx2.0cy2.0mx3.0my3.0.stl 6x6Turn90_auto_0cx3.0cy3.0mx3.0.stl 6x6Turn90_auto_0cx3.0cy3.0my3.0.stl \
	4x4Turn90BankedBE_auto_0.stl \
	4x4Turn90BankedB_auto_0.stl \
	4x4Turn90BankedE_auto_0.stl \
	4x4Turn90Banked_auto_0.stl \
	4x4Yinter90_auto_0.stl \
	4x4Yinter90Raised_auto_0.stl \
	3x3SmoothRamp_auto_0.stl

STL1S=	3x3Crossing_auto_1.stl \
	3x3Straight_auto_1.stl \
	3x3Turn90_auto_1.stl \
	4x4Turn90_auto_1Y1.stl 4x4Turn90_auto_1Y2.stl \
	4x4Turn90_auto_1OA1.stl 4x4Turn90_auto_1OA2.stl \
	4x4Turn90_auto_1V.stl \
	4x4Side1_auto_1cx2.0cy4.0mx2.0.stl 4x4Side1_auto_1cx2.0cy4.0.stl \
	6x6Turn90_auto_1cx2.0cy2.0mx1.0my1.0.stl 6x6Turn90_auto_1cx2.0cy2.0mx3.0my3.0.stl 6x6Turn90_auto_1cx3.0cy3.0mx3.0.stl 6x6Turn90_auto_1cx3.0cy3.0my3.0.stl \
	4x4Turn90BankedBE_auto_1.stl \
	4x4Turn90BankedB_auto_1.stl \
	4x4Turn90BankedE_auto_1.stl \
	4x4Turn90Banked_auto_1.stl \
	4x4Yinter90_auto_1.stl \
	3x3StraightPotholes_auto_1.stl

# STL from manual scad
EXTRASTLS=3x1CheckPoint.stl 3x1Ramp0_1.stl 3x1Ramp0_2.stl 3x1Ramp1_2.stl

SCADS=$(STLS:.stl=.scad) $(STL1S:.stl=.scad)

SVGS=3x3Crossing.svg 3x3Turn90.svg 4x4Turn90.svg 5x5Side2.svg 6x6Turn90.svg 3x3Straight.svg 4x4Side1.svg 4x4Yinter90.svg 6x6Side2.svg

GENPNGS=$(SVGS:%.svg=%.png)

# generate the OpenSCAD files
allscad: gen_scad $(SCADS)

# convert scad to stl (IT TAKES A LOT OF MEMORY !)
allstl: $(STLS) $(STL1S) $(EXTRASTLS)

# default rule for the simple stuff, using
# a PNG on a regular OpenLOCK piece
%_auto_0.scad: %.png
	./gen_scad -d $(DPI) $^

%_auto_1.scad: %.png
	./gen_scad -d $(DPI) -L 1 $^

## some usefule split for easier printing
# This one uses only 26 square inches instead of 36
# by using 2 EA and 2 E pieces (instead of a 6x6)
6x6Turn90_auto_0cx2.0cy2.0mx1.0my1.0.scad: 6x6Turn90.png
	./gen_scad -d $(DPI) -x 2 -y 2 -X 1 -Y 1 $^
6x6Turn90_auto_0cx2.0cy2.0mx3.0my3.0.scad: 6x6Turn90.png
	./gen_scad -d $(DPI) -x 2 -y 2 -X 3 -Y 3 $^
6x6Turn90_auto_0cx3.0cy3.0mx3.0.scad: 6x6Turn90.png
	./gen_scad -d $(DPI) -x 3 -y 3 -X 3 -Y 0 $^
6x6Turn90_auto_0cx3.0cy3.0my3.0.scad: 6x6Turn90.png
	./gen_scad -d $(DPI) -x 3 -y 3 -X 0 -Y 3 $^

6x6Turn90_auto_1cx2.0cy2.0mx1.0my1.0.scad: 6x6Turn90.png
	./gen_scad -d $(DPI) -x 2 -y 2 -X 1 -Y 1 -L 1 $^
6x6Turn90_auto_1cx2.0cy2.0mx3.0my3.0.scad: 6x6Turn90.png
	./gen_scad -d $(DPI) -x 2 -y 2 -X 3 -Y 3 -L 1 $^
6x6Turn90_auto_1cx3.0cy3.0mx3.0.scad: 6x6Turn90.png
	./gen_scad -d $(DPI) -x 3 -y 3 -X 3 -Y 0 -L 1 $^
6x6Turn90_auto_1cx3.0cy3.0my3.0.scad: 6x6Turn90.png
	./gen_scad -d $(DPI) -x 3 -y 3 -X 0 -Y 3 -L 1 $^


# cut an U piece into 2 R pieces
4x4Side1_auto_0cx2.0cy4.0mx2.0.scad: 4x4Side1.png
	./gen_scad -d $(DPI) -x 2 -y 4 -X 2 -Y 0 $^
4x4Side1_auto_0cx2.0cy4.0.scad: 4x4Side1.png
	./gen_scad -d $(DPI) -x 2 -y 4 -X 0 -Y 0 $^

4x4Side1_auto_1cx2.0cy4.0mx2.0.scad: 4x4Side1.png
	./gen_scad -d $(DPI) -x 2 -y 4 -X 2 -Y 0 -L 1 $^
4x4Side1_auto_1cx2.0cy4.0.scad: 4x4Side1.png
	./gen_scad -d $(DPI) -x 2 -y 4 -X 0 -Y 0 -L 1 $^


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
4x4Turn90_auto_0V.scad : 4x4Turn90.png
	./gen_scad -d $(DPI) -T V $<

4x4Turn90_auto_1V.scad : 4x4Turn90.png
	./gen_scad -d $(DPI) -T V -L 1 $<

# variable-height ramps on SA pieces (STL)
3x1Ramp0_1.stl: 3x1Ramp0_1.scad
	$(OPENSCAD) -Dlow=0 -Dheight=1 $^ -o $@

3x1Ramp0_2.stl: 3x1Ramp0_1.scad
	$(OPENSCAD) -Dlow=0 -Dheight=2 $^ -o $@

3x1Ramp1_2.stl: 3x1Ramp0_1.scad
	$(OPENSCAD) -Dlow=1 -Dheight=1 $^ -o $@

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

#�custom filters
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
	./PNGFilter_4x4Turn90Banking $< $@ -b -e
4x4Turn90BankedB.png: 4x4Turn90.png PNGFilter_4x4Turn90Banking
	./PNGFilter_4x4Turn90Banking $< $@ -b
4x4Turn90BankedE.png: 4x4Turn90.png PNGFilter_4x4Turn90Banking
	./PNGFilter_4x4Turn90Banking $< $@ -e
4x4Turn90Banked.png: 4x4Turn90.png PNGFilter_4x4Turn90Banking
	./PNGFilter_4x4Turn90Banking $< $@
4x4Turn90BankedDbleDepth.png: 4x4Turn90.png PNGFilter_4x4Turn90BankingDbleDepth
	./PNGFilter_4x4Turn90BankingDbleDepth $< $@
4x4Turn90BankedDbleDepth_auto_0.scad: 4x4Turn90BankedDbleDepth.png
	./gen_scad -d $(DPI) -s 0.2 $^


# Generate PNG from the SVG
%.png: %.svg
	$(INKSCAPE) -f $< -e $@ -d $(DPI)