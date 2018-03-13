myinch = 25.4;
$vpt= [ 4.00*myinch, -5.00*myinch, 2.00*myinch ];
$vpr=[ 55.00, 0.00, 35.00 ];
module myobject() {
myxsize = 2.0;
myysize = 2.5;
mydpi = 120;
myxscale = myinch/mydpi;
myyscale = myinch/mydpi;
union() {
translate (v=[-0.0 * myinch,(0.0 - myysize)*myinch, 7+(myinch/4)*0]) {
	scale (v = [myxscale, myyscale, 0.100000]) {
		surface(file = "2x2.5-4x5StraightWidth3to4Part1.png", center = false, convexity = 5);	}
}
}
}
union() {
myobject();
union() {
import("E+A-TRP-v7.0.stl", convexity=3);
translate (v=[0,-2.5*myinch,6.995]) {
	cube(size=[2.0*myinch, 2.5*myinch, 0.01]);
}
}
}
