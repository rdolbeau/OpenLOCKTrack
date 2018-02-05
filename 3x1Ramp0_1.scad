myinch = 25.4;
$vpt= [ 4.00*myinch, -5.00*myinch, 2.00*myinch ];
$vpr=[ 55.00, 0.00, 35.00 ];

base = 6.995;
low = 0;
height = 1;


module myobject () {
  myxsize = 3;
  myysize = 3;
  mydpi = 120;
  myxscale = myinch / mydpi;
  myyscale = myinch / mydpi;
  translate (v =[0 * myinch, (0 - myysize) * myinch, 7]) {
    scale (v =[myxscale, myyscale, 0.1]) {
      surface (file = "3x3Straight.png", center = false, convexity = 5);
    }
  }
}

module myramp () {
  myxsize = 3;
  myysize = 3;
  mydpi = 120;
  myxscale = myinch / mydpi;
  myyscale = myinch / mydpi;
  polyhedron (points =[[1 * myinch, -3 * myinch, base + low * myinch / 4],
                       [1 * myinch, 0, base + low * myinch / 4],
                       [0, 0, base + low * myinch / 4],
                       [0, -3 * myinch, base + low * myinch / 4],
                       [0, -3 * myinch, 0.005+base + (low + height) * myinch / 4],
                       [0, 0, 0.005+base + (low + height) * myinch / 4]],
              faces =[[0, 1, 2, 3],[5, 4, 3, 2],[0, 4, 5, 1],[0, 3, 4],[5, 2, 1]],
              convexity = 1);
}

module myyline () {
  myxsize = 3;
  myysize = 3;
  translate (v =[0, -(3 * myinch) / 2, 0]) {
    rotate (90, v =[1, 0, 0]) {
      cylinder (h = 3 * myinch, r1 = 0.5, r2 = 0.5, center = true);
    }
  }
}

module myxline () {
  translate (v =[myinch, 0, 0]) {
    rotate (atan (height / 4), v =[0, 1, 0]) {
      translate (v =[-myinch / 2, 0, 0]) {
	rotate (90, v =[0, 1, 0]) {
	  cylinder (h = 2 * myinch, r1 = 0.5, r2 = 0.5, center = true);
	}
      }
    }
  }
}

module mygrid () {
  union () {
  for (i =[0: 1:12]) {
      translate (v =[0, -myinch * (i / 4), base + low * myinch / 4]) {
	myxline ();
      }
    }
  }

  union () {
  for (i =[0: 1:4]) {
      translate (v =[myinch * (4 - i) / 4, 0, base + (height * myinch * i / 16) + low * myinch / 4]) {
	myyline ();
      }
    }
  }
}

angle = atan (height / 4);
extend = 1. / cos (angle);
union () {
  translate (v =[myinch, 0, 7+(low*myinch/4)]) {
    rotate (angle, v =[0, 1, 0]) {
	  scale (v =[extend, 1., 1.]) {
      translate (v =[-myinch, 0, -7]) {
	  intersection () {
	    myobject ();
	    translate (v =[0, -3 * myinch, 0]) {
	      cube ([1 * myinch, 3 * myinch, 33]);
	    }
	  }
	}
      }
    }
  }
  myramp ();
  translate(v=[0,-3*myinch,6.995]) {
      cube([1 * myinch, 3 * myinch, low*(myinch/4)+0.01+(base-7)]);
  }
  translate (v =[0, -3 * myinch, 0]) {
    rotate (90, v =[0, 0, 1]) {
      import ("SA-TRP-v7.0.stl", convexity = 3);
    }
  }
}
