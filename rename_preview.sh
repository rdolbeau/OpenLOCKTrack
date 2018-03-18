#!/bin/bash

SUBDIR=previews
BZIP2="cat"
DEV=RDO
VER=1.0

#/bin/rm -rf $SUBDIR

mkdir -p $SUBDIR
mkdir -p $SUBDIR/TrackWidth2
mkdir -p $SUBDIR/TrackWidth3
mkdir -p $SUBDIR/TrackWidth4
mkdir -p $SUBDIR/TrackWidthChange

update() {
    if test -e $1 -a \( \( \! -e $2  \) -o \( $1 -nt $2 \) \); then
	echo "Compressing $1 to $2"
	${BZIP2} $1 >| $2
    fi
    if test \! -e $1; then
	echo "WARNING: File $1 doesn't exist"
    fi
}

# Track width 2, exists at both level:
for L in 0 1; do
    update 3x1Straight_auto_"$L".png $SUBDIR/TrackWidth2/SA-$DEV-W2Straight-Lvl"$L"-v$VER.png

    update 3x3Crossing_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W2Crossing-Lvl"$L"-v$VER.png
    
    update 3x3Straight_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W2Straight-Lvl"$L"-v$VER.png
    
    update 3x3ChokePoint_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W2ChokePoint-Lvl"$L"-v$VER.png
    
    update 3x3Turn90_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W2Turn90-3-Lvl"$L"-v$VER.png
    update 3x3Turn90_turret0x0_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W2Turn90-3-Turret-Lvl"$L"-v$VER.png
    
    update 4x4Turn90_auto_"$L".png $SUBDIR/TrackWidth2/U-$DEV-W2Turn90-4-Lvl"$L"-v$VER.png
    update 4x4Turn90_auto_"$L"Y1.png $SUBDIR/TrackWidth2/Y-$DEV-W2Turn90-4Part1-Lvl"$L"-v$VER.png
    update 4x4Turn90_auto_"$L"Y2.png $SUBDIR/TrackWidth2/Y-$DEV-W2Turn90-4Part2-Lvl"$L"-v$VER.png
    update 4x4Turn90_auto_"$L"OA1.png $SUBDIR/TrackWidth2/OA-$DEV-W2Turn90-4Part1-Lvl"$L"-v$VER.png
    update 4x4Turn90_auto_"$L"OA2.png $SUBDIR/TrackWidth2/OA-$DEV-W2Turn90-4Part2-Lvl"$L"-v$VER.png
    update 4x4Turn90_auto_"$L"V.png $SUBDIR/TrackWidth2/V-$DEV-W2Turn90-4-Lvl"$L"-v$VER.png
    
    update 4x4Side1_auto_"$L".png $SUBDIR/TrackWidth2/U-$DEV-W2Side1-4-Lvl"$L"-v$VER.png
    update 4x2-4x4Side1Part1_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Side1-4Part1-Lvl"$L"-v$VER.png
    update 4x2-4x4Side1Part2_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Side1-4Part2-Lvl"$L"-v$VER.png
    update 4x4Side1L_auto_"$L".png $SUBDIR/TrackWidth2/U-$DEV-W2Side1L-4-Lvl"$L"-v$VER.png
    update 4x2-4x4Side1LPart1_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Side1L-4Part1-Lvl"$L"-v$VER.png
    update 4x2-4x4Side1LPart2_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Side1L-4Part2-Lvl"$L"-v$VER.png
    
    update 2x2-6x6Turn90Part1_auto_"$L".png $SUBDIR/TrackWidth2/E-$DEV-W2Turn90-6Part1-Lvl"$L"-v$VER.png
    update 2x2-6x6Turn90Part2_auto_"$L".png $SUBDIR/TrackWidth2/E-$DEV-W2Turn90-6Part2-Lvl"$L"-v$VER.png
    update 3x3-6x6Turn90Part3_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W2Turn90-6Part3-Lvl"$L"-v$VER.png
    update 3x3-6x6Turn90Part4_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W2Turn90-6Part4-Lvl"$L"-v$VER.png
    
    update 4x4Yinter90_auto_"$L".png $SUBDIR/TrackWidth2/U-$DEV-W2Yinter90-Lvl"$L"-v$VER.png
    
    update 4x4Turn90Banked_auto_"$L".png $SUBDIR/TrackWidth2/OA-$DEV-W24Turn90Banked-Lvl"$L"-v$VER.png
    update 4x4Turn90BankedB_auto_"$L".png $SUBDIR/TrackWidth2/OA-$DEV-W24Turn90BankedB-Lvl"$L"-v$VER.png
    update 4x4Turn90BankedBE_auto_"$L".png $SUBDIR/TrackWidth2/OA-$DEV-W24Turn90BankedBE-Lvl"$L"-v$VER.png
    update 4x4Turn90BankedE_auto_"$L".png $SUBDIR/TrackWidth2/OA-$DEV-W24Turn90BankedE-Lvl"$L"-v$VER.png
    
    update 3x3Turn90Banked_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W23Turn90Banked-Lvl"$L"-v$VER.png
    
    update 3x3StraightIntoBankingLeft_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W2StraightIntoBankingLeft-Lvl"$L"-v$VER.png
    update 3x3StraightIntoBankingRight_auto_"$L".png $SUBDIR/TrackWidth2/EA-$DEV-W2StraightIntoBankingRight-Lvl"$L"-v$VER.png
    
    update 2x2-4x4Turn90Part1_auto_"$L".png $SUBDIR/TrackWidth2/E-$DEV-W2Turn90-4Part1-Lvl"$L"-v$VER.png
    update 2x2-4x4Turn90Part1_turret0x0_auto_"$L".png $SUBDIR/TrackWidth2/E-$DEV-W2Turn90-4Part1-Turret-Lvl"$L"-v$VER.png
    update 2x2-4x4Turn90Part2_auto_"$L".png $SUBDIR/TrackWidth2/E-$DEV-W2Turn90-4Part2-Lvl"$L"-v$VER.png
    update 2x2-4x4Turn90Part3_auto_"$L".png $SUBDIR/TrackWidth2/E-$DEV-W2Turn90-4Part3-Lvl"$L"-v$VER.png
    update 2x2-4x4Turn90Part4_auto_"$L".png $SUBDIR/TrackWidth2/E-$DEV-W2Turn90-4Part4-Lvl"$L"-v$VER.png
    
    update 2x4-6x4Turn90Part1_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Turn90-6x4Part1-Lvl"$L"-v$VER.png
    update 2x4-6x4Turn90Part2_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Turn90-6x4Part2-Lvl"$L"-v$VER.png
    update 2x4-6x4Turn90Part3_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Turn90-6x4Part3-Lvl"$L"-v$VER.png
    update 2x4-6x4Turn90LPart1_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Turn90L-6x4Part1-Lvl"$L"-v$VER.png
    update 2x4-6x4Turn90LPart2_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Turn90L-6x4Part2-Lvl"$L"-v$VER.png
    update 2x4-6x4Turn90LPart3_auto_"$L".png $SUBDIR/TrackWidth2/R-$DEV-W2Turn90L-6x4Part3-Lvl"$L"-v$VER.png

    update 3x3Turn90_wall1_auto_"$L".png     $SUBDIR/TrackWidth2/EA-$DEV-W2Turn90-3-Wall1-Lvl"$L"-v$VER.png
    update 3x3Turn90_wall2_auto_"$L".png     $SUBDIR/TrackWidth2/EA-$DEV-W2Turn90-3-Wall2-Lvl"$L"-v$VER.png
    update 3x3Straight_wall1_auto_"$L".png   $SUBDIR/TrackWidth2/EA-$DEV-W2Straight-Wall1-Lvl"$L"-v$VER.png
done

# Track width change
for L in 0 1; do
# Width 2 to 3
    update 2x4StraightWidth2to3_auto_"$L".png $SUBDIR/TrackWidthChange/R-$DEV-StraightW2to3-Lvl"$L"-v$VER.png
    update 2x4StraightWidth2to3Left_auto_"$L".png $SUBDIR/TrackWidthChange/R-$DEV-StraightW2to3Left-Lvl"$L"-v$VER.png
# Width 4 to 4
    update 2x2.5-4x5StraightWidth3to4Part1_auto_"$L".png $SUBDIR/TrackWidthChange/E+A-$DEV-StraightW3to4Part1-Lvl"$L"-v$VER.png
    update 2x2.5-4x5StraightWidth3to4Part2_auto_"$L".png $SUBDIR/TrackWidthChange/E+A-$DEV-StraightW3to4Part2-Lvl"$L"-v$VER.png
    update 2x2.5-4x5StraightWidth3to4Part3_auto_"$L".png $SUBDIR/TrackWidthChange/E+A-$DEV-StraightW3to4Part3-Lvl"$L"-v$VER.png
    update 2x2.5-4x5StraightWidth3to4Part4_auto_"$L".png $SUBDIR/TrackWidthChange/E+A-$DEV-StraightW3to4Part4-Lvl"$L"-v$VER.png
done

# Other track width
for L in 0 1; do
# Width 3
    update 2x4W3Straight_auto_"$L".png        $SUBDIR/TrackWidth3/R-$DEV-W3Straight-Lvl"$L"-v$VER.png
#    update 1x4W3Straight_auto_"$L".png        $SUBDIR/TrackWidth3/SB-$DEV-W3Straight-Lvl"$L"-v$VER.png
    update 4x4W3Turn90_auto_"$L".png          $SUBDIR/TrackWidth3/U-$DEV-W3Turn90-Lvl"$L"-v$VER.png
# Width 4
    update 2x2.5-2x5W4StraightPart1_auto_"$L".png        $SUBDIR/TrackWidth4/E+A-$DEV-W4StraightPart1-Lvl"$L"-v$VER.png
    update 2x2.5-2x5W4StraightPart2_auto_"$L".png        $SUBDIR/TrackWidth4/E+A-$DEV-W4StraightPart2-Lvl"$L"-v$VER.png
done

# Ramps and the checkpoint and other not-by-layer stuff
update 3x1CheckPoint.png $SUBDIR/TrackWidth2/SA-$DEV-W2CheckPoint-Lvl0-v$VER.png
update 3x1Ramp0_1.png $SUBDIR/TrackWidth2/SA-$DEV-W2Ramp-Lvl0-Lvl1-v$VER.png
update 3x1Ramp0_2.png $SUBDIR/TrackWidth2/SA-$DEV-W2Ramp-Lvl0-Lvl2-v$VER.png
update 3x1Ramp1_2.png $SUBDIR/TrackWidth2/SA-$DEV-W2Ramp-Lvl1-Lvl2-v$VER.png
update 1x3Straight_poles_auto_0.png $SUBDIR/TrackWidth2/SA-$DEV-W2StraightPoles-Lvl0-v$VER.png
update 3x3StraightPotholes_auto_1.png $SUBDIR/TrackWidth2/EA-$DEV-W2StraightPotholes-Lvl1-v$VER.png
update 4x4Yinter90Raised_auto_0.png $SUBDIR/TrackWidth2/U-$DEV-W2Yinter90Raised-Lvl0-Lvl1-v$VER.png
update 3x3SmoothRamp_auto_0.png $SUBDIR/TrackWidth2/EA-$DEV-W2SmoothRamp-Lvl0-Lvl1-v$VER.png
