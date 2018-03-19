CC=gcc
CFLAGS=-O2 -Wall

OPENSCAD=/usr/local/openscad-openscad-2015.03/bin/openscad
DPI=120

.SECONDARY:

all:gen_scad

gen_scad: gen_scad.c
	$(CC) $(CFLAGS) $< -o $@

# STL from auto-generated scad, Level 0 
STLS=	1x3Straight_poles_auto_0.stl \
	3x1Straight_auto_0.stl \
	3x3Crossing_auto_0.stl \
	3x3Straight_auto_0.stl \
	3x3ChokePoint_auto_0.stl \
	3x3Turn90_auto_0.stl \
	3x3Turn90_turret0x0_auto_0.stl \
	4x4Turn90_auto_0.stl \
	4x4Turn90_auto_0Y1.stl 4x4Turn90_auto_0Y2.stl \
	4x4Turn90_auto_0OA1.stl 4x4Turn90_auto_0OA2.stl \
	4x4Turn90_auto_0V.stl \
	2x2-4x4Turn90Part1_auto_0.stl 2x2-4x4Turn90Part2_auto_0.stl 2x2-4x4Turn90Part3_auto_0.stl 2x2-4x4Turn90Part4_auto_0.stl 2x2-4x4Turn90Part1_turret0x0_auto_0.stl \
	2x4-6x4Turn90Part1_auto_0.stl 2x4-6x4Turn90Part2_auto_0.stl 2x4-6x4Turn90Part3_auto_0.stl \
	2x4-6x4Turn90LPart1_auto_0.stl 2x4-6x4Turn90LPart2_auto_0.stl 2x4-6x4Turn90LPart3_auto_0.stl \
	4x4Side1_auto_0.stl \
	4x2-4x4Side1Part1_auto_0.stl 4x2-4x4Side1Part2_auto_0.stl \
	4x4Side1L_auto_0.stl \
	4x2-4x4Side1LPart1_auto_0.stl 4x2-4x4Side1LPart2_auto_0.stl \
	2x2-6x6Turn90Part1_auto_0.stl 2x2-6x6Turn90Part2_auto_0.stl 3x3-6x6Turn90Part3_auto_0.stl 3x3-6x6Turn90Part4_auto_0.stl \
	4x4Turn90BankedBE_auto_0.stl \
	4x4Turn90BankedB_auto_0.stl \
	4x4Turn90BankedE_auto_0.stl \
	4x4Turn90Banked_auto_0.stl \
	3x3Turn90Banked_auto_0.stl \
	4x4Yinter90_auto_0.stl \
	4x4Yinter90Raised_auto_0.stl \
	3x3SmoothRamp_auto_0.stl \
	3x3StraightIntoBankingRight_auto_0.stl 3x3StraightIntoBankingLeft_auto_0.stl \
	3x3Straight_wall1_auto_0.stl 3x3Turn90_wall1_auto_0.stl 3x3Turn90_wall2_auto_0.stl

STL1S=	3x1Straight_auto_1.stl \
	3x3Crossing_auto_1.stl \
	3x3Straight_auto_1.stl \
	3x3ChokePoint_auto_1.stl \
	3x3Turn90_auto_1.stl \
	3x3Turn90_turret0x0_auto_1.stl \
	4x4Turn90_auto_1.stl \
	4x4Turn90_auto_1Y1.stl 4x4Turn90_auto_1Y2.stl \
	4x4Turn90_auto_1OA1.stl 4x4Turn90_auto_1OA2.stl \
	4x4Turn90_auto_1V.stl \
	2x2-4x4Turn90Part1_auto_1.stl 2x2-4x4Turn90Part2_auto_1.stl 2x2-4x4Turn90Part3_auto_1.stl 2x2-4x4Turn90Part4_auto_1.stl 2x2-4x4Turn90Part1_turret0x0_auto_1.stl \
	2x4-6x4Turn90Part1_auto_1.stl 2x4-6x4Turn90Part2_auto_1.stl 2x4-6x4Turn90Part3_auto_1.stl \
	2x4-6x4Turn90LPart1_auto_1.stl 2x4-6x4Turn90LPart2_auto_1.stl 2x4-6x4Turn90LPart3_auto_1.stl \
	4x4Side1_auto_1.stl \
	4x2-4x4Side1Part1_auto_1.stl 4x2-4x4Side1Part2_auto_1.stl \
	4x4Side1L_auto_1.stl \
	4x2-4x4Side1LPart1_auto_1.stl 4x2-4x4Side1LPart2_auto_1.stl \
	2x2-6x6Turn90Part1_auto_1.stl 2x2-6x6Turn90Part2_auto_1.stl 3x3-6x6Turn90Part3_auto_1.stl 3x3-6x6Turn90Part4_auto_1.stl \
	4x4Turn90BankedBE_auto_1.stl \
	4x4Turn90BankedB_auto_1.stl \
	4x4Turn90BankedE_auto_1.stl \
	4x4Turn90Banked_auto_1.stl \
	3x3Turn90Banked_auto_1.stl \
	4x4Yinter90_auto_1.stl \
	3x3StraightIntoBankingRight_auto_1.stl 3x3StraightIntoBankingLeft_auto_1.stl \
	3x3Straight_wall1_auto_1.stl 3x3Turn90_wall1_auto_1.stl 3x3Turn90_wall2_auto_1.stl \
	3x3StraightPotholes_auto_1.stl

# STL from manual scad
EXTRASTLS=3x1CheckPoint.stl 3x1Ramp0_1.stl 3x1Ramp0_2.stl 3x1Ramp1_2.stl

# Other-than-2 track size

MORESTLS=2x4StraightWidth2to3_auto_0.stl 2x4StraightWidth2to3Left_auto_0.stl 2x4W3Straight_auto_0.stl 4x4W3Turn90_auto_0.stl \
	2x4StraightWidth2to3_auto_1.stl 2x4StraightWidth2to3Left_auto_1.stl 2x4W3Straight_auto_1.stl 4x4W3Turn90_auto_1.stl \
	2x2.5-4x5StraightW1SplitLPart1_auto_0.stl \
	2x2.5-4x5StraightW1SplitLPart2_auto_0.stl \
	2x2.5-4x5StraightW1SplitLPart3_auto_0.stl \
	2x1.5-4x5StraightW1SplitLPart4_auto_0.stl \
	2x2.5-4x5StraightW1SplitPart1_auto_0.stl \
	2x1.5-4x5StraightW1SplitPart2_auto_0.stl \
	2x2.5-4x5StraightW1SplitPart3_auto_0.stl \
	2x2.5-4x5StraightW1SplitPart4_auto_0.stl

# 1x4W3Straight_auto_0.stl 1x4W3Straight_auto_1.stl # seems to have an issue in OpenSCAD (SB base ?)

SCADS=$(STLS:.stl=.scad) $(STL1S:.stl=.scad) $(MORESTLS)

GENPNGS=3x3Straight.png 3x3Crossing.png 3x3Turn90.png 4x4Side1.png 6x6Turn90.png 4x4Yinter90.png

# generate the OpenSCAD files
allscad: $(SCADS)

# convert scad to stl (IT TAKES A LOT OF MEMORY !)
allstl: allscad $(STLS) $(STL1S) $(EXTRASTLS)

allpng: $(STLS:.stl=.png) $(STL1S:.stl=.png) $(EXTRASTLS:.stl=.png) $(MORESTLS:.stl=.png)

# default rule for the simple stuff, using
# a PNG on a regular OpenLOCK piece
%_auto_0.scad: %.png gen_scad
	./gen_scad -d $(DPI) $<

%_auto_1.scad: %.png gen_scad
	./gen_scad -d $(DPI) -L 1 $<

# 3x3 Turn90 with turret
3x3Turn90_turret0x0_auto_0.scad: 3x3Turn90.png gen_scad
	./gen_scad -d $(DPI) -t 0x0 $<
3x3Turn90_turret0x0_auto_1.scad: 3x3Turn90.png gen_scad
	./gen_scad -d $(DPI) -t 0x0 -L 1 $<

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

# 4x4 Turn90 in 4 pieces, with an optional turret
2x2-4x4Turn90Part1.png: 4x4Turn90.png
	convert $< -crop 240x240+0+0 $@
2x2-4x4Turn90Part2.png: 4x4Turn90.png
	convert $< -crop 240x240+240+0 $@
2x2-4x4Turn90Part3.png: 4x4Turn90.png
	convert $< -crop 240x240+0+240 $@
2x2-4x4Turn90Part4.png: 4x4Turn90.png
	convert $< -crop 240x240+240+240 $@

2x2-4x4Turn90Part1_turret0x0_auto_0.scad: 2x2-4x4Turn90Part1.png gen_scad
	./gen_scad -d $(DPI) -t 0x0 $<
2x2-4x4Turn90Part1_turret0x0_auto_1.scad: 2x2-4x4Turn90Part1.png gen_scad
	./gen_scad -d $(DPI) -t 0x0 -L 1 $<

# cut an U piece into 2 R pieces
4x2-4x4Side1Part1.png: 4x4Side1.png
	convert $< -crop 480x240+0+0 $@
4x2-4x4Side1Part2.png: 4x4Side1.png
	convert $< -crop 480x240+0+240 $@
4x2-4x4Side1LPart1.png: 4x4Side1L.png
	convert $< -crop 480x240+0+0 $@
4x2-4x4Side1LPart2.png: 4x4Side1L.png
	convert $< -crop 480x240+0+240 $@


# cut an U piece into 2 Y pieces - beware loss of surface !
4x4Turn90_auto_0Y1.scad 4x4Turn90_auto_0Y2.scad: 4x4Turn90.png gen_scad
	./gen_scad -d $(DPI) -T Y $<

4x4Turn90_auto_1Y1.scad 4x4Turn90_auto_1Y2.scad: 4x4Turn90.png gen_scad
	./gen_scad -d $(DPI) -T Y -L 1 $<


# cut an U piece into 2 OA pieces
4x4Turn90_auto_0OA1.scad 4x4Turn90_auto_0OA2.scad: 4x4Turn90.png gen_scad
	./gen_scad -d $(DPI) -T OA $<

4x4Turn90_auto_1OA1.scad 4x4Turn90_auto_1OA2.scad: 4x4Turn90.png gen_scad
	./gen_scad -d $(DPI) -T OA -L 1 $<


# trim a U piece to a V piece
4x4Turn90_auto_0V.scad: 4x4Turn90.png gen_scad
	./gen_scad -d $(DPI) -T V $<

4x4Turn90_auto_1V.scad: 4x4Turn90.png gen_scad
	./gen_scad -d $(DPI) -T V -L 1 $<

# variable-height ramps on SA pieces (STL)
3x1Ramp0_1.stl: 3x1Ramp0_1.scad 3x1Straight.png
	$(OPENSCAD) -Dlow=0 -Dheight=1 $< -o $@

3x1Ramp0_2.stl: 3x1Ramp0_1.scad 3x1Straight.png
	$(OPENSCAD) -Dlow=0 -Dheight=2 $< -o $@

3x1Ramp1_2.stl: 3x1Ramp0_1.scad 3x1Straight.png
	$(OPENSCAD) -Dlow=1 -Dheight=1 $< -o $@


3x1Ramp0_1.png: 3x1Ramp0_1.scad 3x1Straight.png
	$(OPENSCAD) -Dlow=0 -Dheight=1 $< -o $@

3x1Ramp0_2.png: 3x1Ramp0_1.scad 3x1Straight.png
	$(OPENSCAD) -Dlow=0 -Dheight=2 $< -o $@

3x1Ramp1_2.png: 3x1Ramp0_1.scad 3x1Straight.png
	$(OPENSCAD) -Dlow=1 -Dheight=1 $< -o $@

# checkpoint
3x1CheckPoint.stl: 3x1CheckPoint.scad 3x1Straight.png
	$(OPENSCAD) $< -o $@

3x1CheckPoint.png: 3x1CheckPoint.scad 3x1Straight.png
	$(OPENSCAD) $< -o $@

# Potholes - there use -L 0 but are Lvl1 because of the post-processing
3x3StraightPotholes_auto_1.scad: 3x3StraightPotholes.png gen_scad
	./gen_scad -d $(DPI) -L 0 -E 1 $<

# poles to support a banner
1x3Straight_poles_auto_0.scad: 1x3Straight.png
	./gen_scad -d $(DPI) -P $<

# Wall examples
3x3Straight_wall1_auto_0.scad: 3x3Straight.png
	./gen_scad -d $(DPI) -w 0x1 $<

3x3Turn90_wall1_auto_0.scad: 3x3Turn90.png
	./gen_scad -d $(DPI) -w 0x1 $<

3x3Turn90_wall2_auto_0.scad: 3x3Turn90.png
	./gen_scad -d $(DPI) -w 0x2 $<

3x3Straight_wall1_auto_1.scad: 3x3Straight.png
	./gen_scad -d $(DPI) -L 1 -w 0x1 $<

3x3Turn90_wall1_auto_1.scad: 3x3Turn90.png
	./gen_scad -d $(DPI) -L 1 -w 0x1 $<

3x3Turn90_wall2_auto_1.scad: 3x3Turn90.png
	./gen_scad -d $(DPI) -L 1 -w 0x2 $<

# default rule to generate the STL
%.stl: %.scad
	$(OPENSCAD) $< -o $@

%.png: %.scad
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


PNGFilter_NxNPotholes: PNGFilter_main.c PNGFilter_NxNPotholes.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm

3x3StraightPotholes.png: 3x3Straight.png PNGFilter_NxNPotholes
	./PNGFilter_NxNPotholes $< $@ -p 1,5 -p 9,9 -p 8,4 -s 3


PNGFilter_3x3SmoothRamp: PNGFilter_main.c PNGFilter_3x3SmoothRamp.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm

3x3SmoothRamp.png: 3x3Straight.png PNGFilter_3x3SmoothRamp
	./PNGFilter_3x3SmoothRamp $< $@


PNGFilter_NxNTurn90Banking: PNGFilter_main.c PNGFilter_NxNTurn90Banking.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm

PNGFilter_NxNTurn90BankingDbleDepth: PNGFilter_main.c PNGFilter_NxNTurn90BankingDbleDepth.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm


4x4Turn90BankedBE.png: 4x4Turn90.png PNGFilter_NxNTurn90Banking
	./PNGFilter_NxNTurn90Banking $< $@ -b -e -s 4
4x4Turn90BankedB.png: 4x4Turn90.png PNGFilter_NxNTurn90Banking
	./PNGFilter_NxNTurn90Banking $< $@ -b -s 4
4x4Turn90BankedE.png: 4x4Turn90.png PNGFilter_NxNTurn90Banking
	./PNGFilter_NxNTurn90Banking $< $@ -e -s 4
4x4Turn90Banked.png: 4x4Turn90.png PNGFilter_NxNTurn90Banking
	./PNGFilter_NxNTurn90Banking $< $@ -s 4
4x4Turn90BankedDbleDepth.png: 4x4Turn90.png PNGFilter_NxNTurn90BankingDbleDepth
	./PNGFilter_NxNTurn90BankingDbleDepth $< $@
4x4Turn90BankedDbleDepth_auto_0.scad: 4x4Turn90BankedDbleDepth.png gen_scad
	./gen_scad -d $(DPI) -s 0.2 $<

3x3Turn90Banked.png: 3x3Turn90.png PNGFilter_NxNTurn90Banking
	./PNGFilter_NxNTurn90Banking $< $@ -s 3

PNGFilter_NxMStraightIntoBanking: PNGFilter_main.c PNGFilter_NxMStraightIntoBanking.c
	$(CC) $(CFLAGS) $^ -o $@ -lpng -lm

3x3StraightIntoBankingRight.png: 3x3Straight.png PNGFilter_NxMStraightIntoBanking
	./PNGFilter_NxMStraightIntoBanking $< $@ -l 3 -w 3 -t 2
3x3StraightIntoBankingLeft.png: 3x3Straight.png PNGFilter_NxMStraightIntoBanking
	./PNGFilter_NxMStraightIntoBanking $< $@ -l 3 -w 3 -t 2 -m

2x4-6x4Turn90Part1.png: 6x4Turn90.png
	convert $< -crop 240x480+0+0 $@
2x4-6x4Turn90Part2.png: 6x4Turn90.png
	convert $< -crop 240x480+240+0 $@
2x4-6x4Turn90Part3.png: 6x4Turn90.png
	convert $< -crop 240x480+480+0 $@

2x4-6x4Turn90LPart1.png: 6x4Turn90L.png
	convert $< -crop 240x480+0+0 $@
2x4-6x4Turn90LPart2.png: 6x4Turn90L.png
	convert $< -crop 240x480+240+0 $@
2x4-6x4Turn90LPart3.png: 6x4Turn90L.png
	convert $< -crop 240x480+480+0 $@

# Procedurally generate PNG
PNGSynth: PNGFilter_main.c PNGSynth_gsl.c PNGSynth_Procedural.c PNGSynth_support.c
	$(CC) $(CFLAGS) -fopenmp -DPNG_SYNTH -lpng -lgsl -lgslcblas -lm $^ -o $@

1x1Nothing.png: PNGSynth
	./PNGSynth $@ -l 1 -w 1

3x3Nothing.png: PNGSynth
	./PNGSynth $@ -l 3 -w 3

3x3PitBase.png: PNGSynth
	./PNGSynth $@ -l 3 -w 3 -t 3 -f straight

1x3Straight.png: PNGSynth
	./PNGSynth $@ -t 2 -f straight -l 1 -w 3

3x1Straight.png: PNGSynth
	./PNGSynth $@ -t 2 -T -f straight -l 3 -w 1

3x3Straight.png: PNGSynth
	./PNGSynth $@ -t 2 -f straight -l 3 -w 3

3x3Crossing.png: PNGSynth
	./PNGSynth $@ -t 2 -f straight -T -f straight -T -l 3 -w 3

3x3ChokePoint.png: PNGSynth
	./PNGSynth $@ -t 0.5 -f side -M -f side -w 3 -l 3 -t 1 -f middlestraight # ends up at trackwidth == 2.

3x3Turn90.png: PNGSynth
	./PNGSynth $@ -t 2 -f turn90 -l 3 -w 3

4x4Turn90.png: PNGSynth
	./PNGSynth $@ -t 2 -f turn90 -l 4 -w 4

6x4Turn90.png: PNGSynth
	./PNGSynth $@ -t 2 -f turn90 -l 6 -w 4

6x4Turn90L.png: PNGSynth
	./PNGSynth $@ -t 2 -M -f turn90 -l 6 -w 4

4x4Side1.png: PNGSynth
	./PNGSynth $@ -t 2 -f side -l 4 -w 4

4x4Side1L.png: PNGSynth
	./PNGSynth $@ -t 2 -F -f side -l 4 -w 4

6x6Turn90.png: PNGSynth
	./PNGSynth $@ -t 2 -f turn90 -l 6 -w 6

4x4Yinter90.png: PNGSynth #TODO: flipped version
	./PNGSynth $@ -t 2 -f turn90 -f straight -l 4 -w 4

##### Wider track
# Convert W2 to W3
4x4StraightWidth2to3.png: PNGSynth
	./PNGSynth $@ -t 2 -f side -f straight -l 4 -w 4

2x4StraightWidth2to3.png: PNGSynth
	./PNGSynth $@ -t 1 -F -f middleside -F -t 2 -f straight -l 2 -w 4

2x4StraightWidth2to3Left.png: PNGSynth
	./PNGSynth $@ -t 1 -f middleside -F -t 2 -f straight -l 2 -w 4

4x5StraightWidth3to4.png: PNGSynth
	./PNGSynth $@ -t 3 -f side -f straight -l 4 -w 5
2x2.5-4x5StraightWidth3to4Part1.png: 4x5StraightWidth3to4.png
	convert $< -crop 240x300+0+0 $@
2x2.5-4x5StraightWidth3to4Part2.png: 4x5StraightWidth3to4.png
	convert $< -crop 240x300+0+300 $@
2x2.5-4x5StraightWidth3to4Part3.png: 4x5StraightWidth3to4.png
	convert $< -crop 240x300+240+0 $@
2x2.5-4x5StraightWidth3to4Part4.png: 4x5StraightWidth3to4.png
	convert $< -crop 240x300+240+300 $@

# Width 3
2x4W3Straight.png: PNGSynth
	./PNGSynth $@ -t 3 -f straight -l 2 -w 4

1x4W3Straight.png: PNGSynth
	./PNGSynth $@ -t 3 -f straight -l 1 -w 4

4x4W3Turn90.png: PNGSynth
	./PNGSynth $@ -t 3 -f turn90 -l 4 -w 4

4x4W3Crossing.png: PNGSynth
	./PNGSynth $@ -t 3 -f straight -T -f straight -T -l 4 -w 4

4x4W3Turn90Banked.png: 4x4W3Turn90.png PNGFilter_NxNTurn90Banking
	./PNGFilter_NxNTurn90Banking $< $@ -s 4 -t 3

# Width 4
2x5W4Straight.png: PNGSynth
	./PNGSynth $@ -t 4 -f straight -l 2 -w 5
2x2.5-2x5W4StraightPart1.png: 2x5W4Straight.png
	convert $< -crop 240x300+0+0 $@
2x2.5-2x5W4StraightPart2.png: 2x5W4Straight.png
	convert $< -crop 240x300+0+300 $@

# Width 1 (used for e.g. pits)
1x3W1Straight.png: PNGSynth
	./PNGSynth $@ -t 1 -w 3 -l 1 -f straight

3x3StraightWidth2to1.png: PNGSynth
	./PNGSynth $@ -t 1 -w 3 -l 3 -f straight -f side
3x3StraightWidth1to2.png: PNGSynth
	./PNGSynth $@ -t 1 -w 3 -l 3 -f straight -F -f side
#3x3W1Side1.png: PNGSynth
#	./PNGSynth $@ -t 1 -w 3 -l 3 -f side
#3x3W1Side1L.png: PNGSynth
#	./PNGSynth $@ -t 1 -w 3 -l 3 -F -f side

4x5StraightW1Split.png: PNGSynth
	./PNGSynth $@ -t 2 -w 5 -l 4 -f straight -F -t 1 -f offmiddleside
2x2.5-4x5StraightW1SplitPart1.png: 4x5StraightW1Split.png
	convert $< -crop 240x300+0+0 $@
2x1.5-4x5StraightW1SplitPart2.png: 4x5StraightW1Split.png
	convert $< -crop 240x180+0+300 $@
2x2.5-4x5StraightW1SplitPart3.png: 4x5StraightW1Split.png
	convert $< -crop 240x300+240+0 $@
2x2.5-4x5StraightW1SplitPart4.png: 4x5StraightW1Split.png
	convert $< -crop 240x300+240+300 $@

4x5StraightW1SplitL.png: PNGSynth
	./PNGSynth $@ -t 2 -w 5 -l 4 -f straight -F -M -t 1 -f offmiddleside
2x2.5-4x5StraightW1SplitLPart1.png: 4x5StraightW1SplitL.png
	convert $< -crop 240x300+0+0 $@
2x2.5-4x5StraightW1SplitLPart2.png: 4x5StraightW1SplitL.png
	convert $< -crop 240x300+0+300 $@
2x2.5-4x5StraightW1SplitLPart3.png: 4x5StraightW1SplitL.png
	convert $< -crop 240x300+240+0 $@
2x1.5-4x5StraightW1SplitLPart4.png: 4x5StraightW1SplitL.png
	convert $< -crop 240x180+240+300 $@

# Pits
# scads are hand-written
# Pit.scad
# 3x3Pits.scad
# 1x3W1PitEntry.scad
# 1x3W1PitExit.scad
# 3x3PitEntry.scad
# 3x3PitExit.scad
PITSSTLS=3x3Pits.stl 1x3W1PitEntry.stl 1x3W1PitExit.stl
PITSPNGS=$(PITSSTLS:.stl=.png)
allpits: $(PITSSTLS) $(PITSPNGS)

#### useful stuff
rename_preview.sh: rename.sh
	cp -f rename.sh rename_preview.sh && sed -i -e 's/\.stl\.bz2/.png/g' -e 's/\.stl/.png/g' -e 's/SUBDIR=export/SUBDIR=previews/' -e 's/BZIP2="bzip2 -c"/BZIP2="cat"/' rename_preview.sh