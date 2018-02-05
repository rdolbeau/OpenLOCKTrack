myinch = 25.4;
$vpt= [ 4.00*myinch, -5.00*myinch, 2.00*myinch ];
$vpr=[ 55.00, 0.00, 35.00 ];
module myobject() {
myxsize = 4.0;
myysize = 4.0;
mydpi = 120;
myxscale = myinch/mydpi;
myyscale = myinch/mydpi;
union() {
translate (v=[0.0 * myinch,(0.0 - myysize)*myinch, 7+(myinch/4)*0]) {
	scale (v = [myxscale, myyscale, 0.100000]) {
		surface(file = "4x4Turn90.png", center = false, convexity = 5);	}
}
}
}
union() {
intersection() {
myobject();
	rotate(180,v=[0,0,1]) {
	linear_extrude(height=50) {
		polygon(points=[[0,0],[0,4*myinch],[-4*myinch, 4*myinch]]    );
	}
}
}
translate(v=[0,-4*myinch,0]) { rotate(0, v=[0,0,1]) {
import("OA-TRP-v7.0.stl");
}
}
}
