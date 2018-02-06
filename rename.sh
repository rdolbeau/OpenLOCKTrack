#!/bin/bash -x

SUBDIR=export
BZIP2="bzip2 -c"
DEV=RDO
VER=0.9

#/bin/rm -rf $SUBDIR

mkdir -p $SUBDIR

# Lvl 0 
${BZIP2} 3x3Crossing_auto_0.stl >| $SUBDIR/EA-$DEV-Crossing-Lvl0-v$VER.stl.bz2

${BZIP2} 3x3Straight_auto_0.stl >| $SUBDIR/EA-$DEV-Straight-Lvl0-v$VER.stl.bz2

${BZIP2} 3x3Turn90_auto_0.stl >| $SUBDIR/EA-$DEV-Turn90-3-Lvl0-v$VER.stl.bz2

${BZIP2} 4x4Turn90_auto_0Y1.stl >| $SUBDIR/Y-$DEV-Turn90-4Part1-Lvl0-v$VER.stl.bz2
${BZIP2} 4x4Turn90_auto_0Y2.stl >| $SUBDIR/Y-$DEV-Turn90-4Part2-Lvl0-v$VER.stl.bz2

${BZIP2} 4x4Turn90_auto_0OA1.stl >| $SUBDIR/OA-$DEV-Turn90-4Part1-Lvl0-v$VER.stl.bz2
${BZIP2} 4x4Turn90_auto_0OA2.stl >| $SUBDIR/OA-$DEV-Turn90-4Part2-Lvl0-v$VER.stl.bz2

${BZIP2} 4x4Turn90_auto_0V.stl >| $SUBDIR/V-$DEV-Turn90-4-Lvl0-v$VER.stl.bz2

${BZIP2} 4x2-4x4Side1Part1_auto_0.stl >| $SUBDIR/R-$DEV-Side1-4Part1-Lvl0-v$VER.stl.bz2
${BZIP2} 4x2-4x4Side1Part2_auto_0.stl >| $SUBDIR/R-$DEV-Side1-4Part2-Lvl0-v$VER.stl.bz2

${BZIP2} 2x2-6x6Turn90Part1_auto_0.stl >| $SUBDIR/E-$DEV-Turn90-6Part1-Lvl0-v$VER.stl.bz2
${BZIP2} 2x2-6x6Turn90Part2_auto_0.stl >| $SUBDIR/E-$DEV-Turn90-6Part2-Lvl0-v$VER.stl.bz2
${BZIP2} 3x3-6x6Turn90Part3_auto_0.stl >| $SUBDIR/EA-$DEV-Turn90-6Part3-Lvl0-v$VER.stl.bz2
${BZIP2} 3x3-6x6Turn90Part4_auto_0.stl >| $SUBDIR/EA-$DEV-Turn90-6Part4-Lvl0-v$VER.stl.bz2

${BZIP2} 4x4Yinter90_auto_0.stl >| $SUBDIR/U-$DEV-Yinter90-Lvl0-v$VER.stl.bz2

${BZIP2} 4x4Turn90Banked_auto_0.stl >| $SUBDIR/OA-$DEV-4Turn90Banked-Lvl0-v$VER.stl.bz2
${BZIP2} 4x4Turn90BankedB_auto_0.stl >| $SUBDIR/OA-$DEV-4Turn90BankedB-Lvl0-v$VER.stl.bz2
${BZIP2} 4x4Turn90BankedBE_auto_0.stl >| $SUBDIR/OA-$DEV-4Turn90BankedBE-Lvl0-v$VER.stl.bz2
${BZIP2} 4x4Turn90BankedE_auto_0.stl >| $SUBDIR/OA-$DEV-4Turn90BankedE-Lvl0-v$VER.stl.bz2


# Lvl 1
${BZIP2} 3x3Crossing_auto_1.stl >| $SUBDIR/EA-$DEV-Crossing-Lvl1-v$VER.stl.bz2

${BZIP2} 3x3Straight_auto_1.stl >| $SUBDIR/EA-$DEV-Straight-Lvl1-v$VER.stl.bz2

${BZIP2} 3x3Turn90_auto_1.stl >| $SUBDIR/EA-$DEV-Turn90-3-Lvl1-v$VER.stl.bz2

${BZIP2} 4x4Turn90_auto_1Y1.stl >| $SUBDIR/Y-$DEV-Turn90-4Part1-Lvl1-v$VER.stl.bz2
${BZIP2} 4x4Turn90_auto_1Y2.stl >| $SUBDIR/Y-$DEV-Turn90-4Part2-Lvl1-v$VER.stl.bz2

${BZIP2} 4x4Turn90_auto_1OA1.stl >| $SUBDIR/OA-$DEV-Turn90-4Part1-Lvl1-v$VER.stl.bz2
${BZIP2} 4x4Turn90_auto_1OA2.stl >| $SUBDIR/OA-$DEV-Turn90-4Part2-Lvl1-v$VER.stl.bz2

${BZIP2} 4x4Turn90_auto_1V.stl >| $SUBDIR/V-$DEV-Turn90-4-Lvl1-v$VER.stl.bz2

${BZIP2} 4x2-4x4Side1Part1_auto_1.stl >| $SUBDIR/R-$DEV-Side1-4Part1-Lvl1-v$VER.stl.bz2
${BZIP2} 4x2-4x4Side1Part2_auto_1.stl >| $SUBDIR/R-$DEV-Side1-4Part2-Lvl1-v$VER.stl.bz2

${BZIP2} 2x2-6x6Turn90Part1_auto_1.stl >| $SUBDIR/E-$DEV-Turn90-6Part1-Lvl1-v$VER.stl.bz2
${BZIP2} 2x2-6x6Turn90Part2_auto_1.stl >| $SUBDIR/E-$DEV-Turn90-6Part2-Lvl1-v$VER.stl.bz2
${BZIP2} 3x3-6x6Turn90Part3_auto_1.stl >| $SUBDIR/EA-$DEV-Turn90-6Part3-Lvl1-v$VER.stl.bz2
${BZIP2} 3x3-6x6Turn90Part4_auto_1.stl >| $SUBDIR/EA-$DEV-Turn90-6Part4-Lvl1-v$VER.stl.bz2

${BZIP2} 4x4Yinter90_auto_1.stl >| $SUBDIR/U-$DEV-Yinter90-Lvl1-v$VER.stl.bz2

${BZIP2} 4x4Turn90Banked_auto_1.stl >| $SUBDIR/OA-$DEV-4Turn90Banked-Lvl1-v$VER.stl.bz2
${BZIP2} 4x4Turn90BankedB_auto_1.stl >| $SUBDIR/OA-$DEV-4Turn90BankedB-Lvl1-v$VER.stl.bz2
${BZIP2} 4x4Turn90BankedBE_auto_1.stl >| $SUBDIR/OA-$DEV-4Turn90BankedBE-Lvl1-v$VER.stl.bz2
${BZIP2} 4x4Turn90BankedE_auto_1.stl >| $SUBDIR/OA-$DEV-4Turn90BankedE-Lvl1-v$VER.stl.bz2


# Ramps and the checkpoint and other not-by-layer stuff
${BZIP2} 3x1CheckPoint.stl >| $SUBDIR/SA-$DEV-CheckPoint-Lvl0-v$VER.stl.bz2
${BZIP2} 3x1Ramp0_1.stl >| $SUBDIR/SA-$DEV-Ramp-Lvl0-Lvl1-v$VER.stl.bz2
${BZIP2} 3x1Ramp0_2.stl >| $SUBDIR/SA-$DEV-Ramp-Lvl0-Lvl2-v$VER.stl.bz2
${BZIP2} 3x1Ramp1_2.stl >| $SUBDIR/SA-$DEV-Ramp-Lvl1-Lvl2-v$VER.stl.bz2
${BZIP2} 3x3StraightPotholes_auto_1.stl >| $SUBDIR/EA-$DEV-StraightPotholes-Lvl1-v$VER.stl.bz2
${BZIP2} 4x4Yinter90Raised_auto_0.stl >| $SUBDIR/U-$DEV-Yinter90Raised-Lvl0-Lvl1-v$VER.stl.bz2
${BZIP2} 3x3SmoothRamp_auto_0.stl >| $SUBDIR/EA-$DEV-SmoothRamp-Lvl0-Lvl1-v$VER.stl.bz2

