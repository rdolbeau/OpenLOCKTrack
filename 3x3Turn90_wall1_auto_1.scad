myinch = 25.4;
$vpt= [ 4.00*myinch, -5.00*myinch, 2.00*myinch ];
$vpr=[ 55.00, 0.00, 35.00 ];
module myobject() {
myxsize = 3.0;
myysize = 3.0;
mydpi = 120;
myxscale = myinch/mydpi;
myyscale = myinch/mydpi;
union() {
translate (v=[-0.0 * myinch,(0.0 - myysize)*myinch, 7+(myinch/4)*1]) {
	scale (v = [myxscale, myyscale, 0.100000]) {
		surface(file = "3x3Turn90.png", center = false, convexity = 5);	}
}
translate (v=[0,-3.0*myinch,6.995]) {
	cube(size=[myxsize*myinch, myysize*myinch, 1*(myinch/4)+0.01]);
}
}
}
union() {
myobject();
union() {
import("EA-TRP-v7.0.stl", convexity=3);
translate (v=[0,-3.0*myinch,6.995]) {
	cube(size=[3.0*myinch, 3.0*myinch, 0.01]);
}
}
}
include <Wall.scad>
translate(v=[0,0,1*myinch/4]) { // layer translate
mywall(walllength=myinch*3.000000);
} // layer translate
