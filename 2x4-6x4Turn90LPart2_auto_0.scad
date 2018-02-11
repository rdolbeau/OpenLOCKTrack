myinch = 25.4;
$vpt= [ 4.00*myinch, -5.00*myinch, 2.00*myinch ];
$vpr=[ 55.00, 0.00, 35.00 ];
module myobject() {
myxsize = 2.0;
myysize = 4.0;
mydpi = 120;
myxscale = myinch/mydpi;
myyscale = myinch/mydpi;
union() {
translate (v=[-0.0 * myinch,(0.0 - myysize)*myinch, 7+(myinch/4)*0]) {
	scale (v = [myxscale, myyscale, 0.100000]) {
		surface(file = "2x4-6x4Turn90LPart2.png", center = false, convexity = 5);	}
}
}
}
union() {
myobject();
union() {
translate (v=[0,-4.0*myinch,0]) { rotate (90, v=[0,0,1]) {
import("R-TRP-v7.0.stl", convexity=3);
}}
translate (v=[0,-4.0*myinch,6.995]) {
	cube(size=[2.0*myinch, 4.0*myinch, 0.01]);
}
}
}
