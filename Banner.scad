myinch = 25.4;
//module mypole() {
//	cylinder (r1=myinch/8,r2=myinch/8,myinch/8);
//	cylinder (r1=myinch/16,r2=myinch/16-0.2,3/2*myinch);
//}
//translate(v=[myinch/4,-myinch/4,7]) { mypole();}
//translate(v=[myinch/4,-11*myinch/4,7]) { mypole();}
//include <3x3Straight_auto_0.scad>;

module mybanner() {
	bheight=10;
	union() {
		difference() {
			cylinder (r1=myinch/8,r2=myinch/8,bheight);
			translate(v=[0,0,-bheight]) { cylinder (r1=myinch/8,r2=myinch/16+0.2,2*bheight); }
		}
		translate(v=[0,-10*myinch/4]) {
			difference() {
				cylinder (r1=myinch/8,r2=myinch/8,bheight);
				translate(v=[0,0,-myinch/2]) { cylinder (r1=myinch/8,r2=myinch/16+0.2,myinch); }
			}
		}
        	translate(v=[-myinch/32,-9*myinch/4-myinch/8-1,0]) {
			cube(size=[myinch/16,9*myinch/4+2,bheight]);
        	}
	}
}

mybanner();
