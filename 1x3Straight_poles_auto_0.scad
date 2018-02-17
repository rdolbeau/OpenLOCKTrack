myinch = 25.4;
$vpt= [ 4.00*myinch, -5.00*myinch, 2.00*myinch ];
$vpr=[ 55.00, 0.00, 35.00 ];
module myobject() {
myxsize = 1.0;
myysize = 3.0;
mydpi = 120;
myxscale = myinch/mydpi;
myyscale = myinch/mydpi;
union() {
translate (v=[-0.0 * myinch,(0.0 - myysize)*myinch, 7+(myinch/4)*0]) {
	scale (v = [myxscale, myyscale, 0.100000]) {
		surface(file = "1x3Straight.png", center = false, convexity = 5);	}
}
}
}
union() {
myobject();
union() {
translate (v=[0,-3.0*myinch,0]) { rotate (90, v=[0,0,1]) {
import("SA-TRP-v7.0.stl", convexity=3);
}}
translate (v=[0,-3.0*myinch,6.995]) {
	cube(size=[1.0*myinch, 3.0*myinch, 0.01]);
}
}
}
module mypole() {
	cylinder (r1=myinch/8,r2=myinch/8,myinch/8);
	cylinder (r1=myinch/16,r2=myinch/16-0.2,3/2*myinch);
}
translate(v=[myinch/4,-myinch/4,7]) { mypole();}
translate(v=[myinch/4,-11*myinch/4,7]) { mypole();}
