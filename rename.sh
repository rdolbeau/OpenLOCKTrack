#!/bin/bash

SUBDIR=export
BZIP2="bzip2 -c"
DEV=RDO
VER=1.0

#/bin/rm -rf $SUBDIR

mkdir -p $SUBDIR

update() {
    if test \( \! -e $2  \) -o \( $1 -nt $2 \) ; then
	echo "Compressing $1 to $2"
	${BZIP2} $1 >| $2
    fi
}

# Exists at both level:
for L in 0 1; do
    update 3x1Straight_auto_"$L".stl $SUBDIR/SA-$DEV-Straight-Lvl"$L"-v$VER.stl.bz2

    update 3x3Crossing_auto_"$L".stl $SUBDIR/EA-$DEV-Crossing-Lvl"$L"-v$VER.stl.bz2
    
    update 3x3Straight_auto_"$L".stl $SUBDIR/EA-$DEV-Straight-Lvl"$L"-v$VER.stl.bz2
    
    update 3x3ChokePoint_auto_"$L".stl $SUBDIR/EA-$DEV-ChokePoint-Lvl"$L"-v$VER.stl.bz2
    
    update 3x3Turn90_auto_"$L".stl $SUBDIR/EA-$DEV-Turn90-3-Lvl"$L"-v$VER.stl.bz2
    
    update 4x4Turn90_auto_"$L".stl $SUBDIR/U-$DEV-Turn90-4-Lvl"$L"-v$VER.stl.bz2
    update 4x4Turn90_auto_"$L"Y1.stl $SUBDIR/Y-$DEV-Turn90-4Part1-Lvl"$L"-v$VER.stl.bz2
    update 4x4Turn90_auto_"$L"Y2.stl $SUBDIR/Y-$DEV-Turn90-4Part2-Lvl"$L"-v$VER.stl.bz2
    update 4x4Turn90_auto_"$L"OA1.stl $SUBDIR/OA-$DEV-Turn90-4Part1-Lvl"$L"-v$VER.stl.bz2
    update 4x4Turn90_auto_"$L"OA2.stl $SUBDIR/OA-$DEV-Turn90-4Part2-Lvl"$L"-v$VER.stl.bz2
    update 4x4Turn90_auto_"$L"V.stl $SUBDIR/V-$DEV-Turn90-4-Lvl"$L"-v$VER.stl.bz2
    
    update 4x4Side1_auto_"$L".stl $SUBDIR/U-$DEV-Side1-4-Lvl"$L"-v$VER.stl.bz2
    update 4x2-4x4Side1Part1_auto_"$L".stl $SUBDIR/R-$DEV-Side1-4Part1-Lvl"$L"-v$VER.stl.bz2
    update 4x2-4x4Side1Part2_auto_"$L".stl $SUBDIR/R-$DEV-Side1-4Part2-Lvl"$L"-v$VER.stl.bz2
    update 4x4Side1L_auto_"$L".stl $SUBDIR/U-$DEV-Side1L-4-Lvl"$L"-v$VER.stl.bz2
    update 4x2-4x4Side1LPart1_auto_"$L".stl $SUBDIR/R-$DEV-Side1L-4Part1-Lvl"$L"-v$VER.stl.bz2
    update 4x2-4x4Side1LPart2_auto_"$L".stl $SUBDIR/R-$DEV-Side1L-4Part2-Lvl"$L"-v$VER.stl.bz2
    
    update 2x2-6x6Turn90Part1_auto_"$L".stl $SUBDIR/E-$DEV-Turn90-6Part1-Lvl"$L"-v$VER.stl.bz2
    update 2x2-6x6Turn90Part2_auto_"$L".stl $SUBDIR/E-$DEV-Turn90-6Part2-Lvl"$L"-v$VER.stl.bz2
    update 3x3-6x6Turn90Part3_auto_"$L".stl $SUBDIR/EA-$DEV-Turn90-6Part3-Lvl"$L"-v$VER.stl.bz2
    update 3x3-6x6Turn90Part4_auto_"$L".stl $SUBDIR/EA-$DEV-Turn90-6Part4-Lvl"$L"-v$VER.stl.bz2
    
    update 4x4Yinter90_auto_"$L".stl $SUBDIR/U-$DEV-Yinter90-Lvl"$L"-v$VER.stl.bz2
    
    update 4x4Turn90Banked_auto_"$L".stl $SUBDIR/OA-$DEV-4Turn90Banked-Lvl"$L"-v$VER.stl.bz2
    update 4x4Turn90BankedB_auto_"$L".stl $SUBDIR/OA-$DEV-4Turn90BankedB-Lvl"$L"-v$VER.stl.bz2
    update 4x4Turn90BankedBE_auto_"$L".stl $SUBDIR/OA-$DEV-4Turn90BankedBE-Lvl"$L"-v$VER.stl.bz2
    update 4x4Turn90BankedE_auto_"$L".stl $SUBDIR/OA-$DEV-4Turn90BankedE-Lvl"$L"-v$VER.stl.bz2
    
    update 3x3Turn90Banked_auto_"$L".stl $SUBDIR/EA-$DEV-3Turn90Banked-Lvl"$L"-v$VER.stl.bz2
    
    update 3x3StraightIntoBankingLeft_auto_"$L".stl $SUBDIR/EA-$DEV-StraightIntoBankingLeft-Lvl"$L"-v$VER.stl.bz2
    update 3x3StraightIntoBankingRight_auto_"$L".stl $SUBDIR/EA-$DEV-StraightIntoBankingRight-Lvl"$L"-v$VER.stl.bz2
    
    update 2x2-4x4Turn90Part1_auto_"$L".stl $SUBDIR/E-$DEV-Turn90-4Part1-Lvl"$L"-v$VER.stl.bz2
    update 2x2-4x4Turn90Part1_turret0x0_auto_"$L".stl $SUBDIR/E-$DEV-Turn90-4Part1-Turret-Lvl"$L"-v$VER.stl.bz2
    update 2x2-4x4Turn90Part2_auto_"$L".stl $SUBDIR/E-$DEV-Turn90-4Part2-Lvl"$L"-v$VER.stl.bz2
    update 2x2-4x4Turn90Part3_auto_"$L".stl $SUBDIR/E-$DEV-Turn90-4Part3-Lvl"$L"-v$VER.stl.bz2
    update 2x2-4x4Turn90Part4_auto_"$L".stl $SUBDIR/E-$DEV-Turn90-4Part4-Lvl"$L"-v$VER.stl.bz2
    
    update 2x4-6x4Turn90Part1_auto_"$L".stl $SUBDIR/R-$DEV-Turn90-6x4Part1-Lvl"$L"-v$VER.stl.bz2
    update 2x4-6x4Turn90Part2_auto_"$L".stl $SUBDIR/R-$DEV-Turn90-6x4Part2-Lvl"$L"-v$VER.stl.bz2
    update 2x4-6x4Turn90Part3_auto_"$L".stl $SUBDIR/R-$DEV-Turn90-6x4Part3-Lvl"$L"-v$VER.stl.bz2
    update 2x4-6x4Turn90LPart1_auto_"$L".stl $SUBDIR/R-$DEV-Turn90L-6x4Part1-Lvl"$L"-v$VER.stl.bz2
    update 2x4-6x4Turn90LPart2_auto_"$L".stl $SUBDIR/R-$DEV-Turn90L-6x4Part2-Lvl"$L"-v$VER.stl.bz2
    update 2x4-6x4Turn90LPart3_auto_"$L".stl $SUBDIR/R-$DEV-Turn90L-6x4Part3-Lvl"$L"-v$VER.stl.bz2
done

# Ramps and the checkpoint and other not-by-layer stuff
update 3x1CheckPoint.stl $SUBDIR/SA-$DEV-CheckPoint-Lvl0-v$VER.stl.bz2
update 3x1Ramp0_1.stl $SUBDIR/SA-$DEV-Ramp-Lvl0-Lvl1-v$VER.stl.bz2
update 3x1Ramp0_2.stl $SUBDIR/SA-$DEV-Ramp-Lvl0-Lvl2-v$VER.stl.bz2
update 3x1Ramp1_2.stl $SUBDIR/SA-$DEV-Ramp-Lvl1-Lvl2-v$VER.stl.bz2
update 3x3StraightPotholes_auto_1.stl $SUBDIR/EA-$DEV-StraightPotholes-Lvl1-v$VER.stl.bz2
update 4x4Yinter90Raised_auto_0.stl $SUBDIR/U-$DEV-Yinter90Raised-Lvl0-Lvl1-v$VER.stl.bz2
update 3x3SmoothRamp_auto_0.stl $SUBDIR/EA-$DEV-SmoothRamp-Lvl0-Lvl1-v$VER.stl.bz2
