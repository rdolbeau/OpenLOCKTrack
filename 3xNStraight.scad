myinch = 25.4;
length = 5;
$vpt =[4.00 * myinch, -5.00 * myinch, 2.00 * myinch];
$vpr =[55.00, 0.00, 35.00];
module
myobject () {
  myxsize = 3.0;
  myysize = 3.0;
  mydpi = 120;
  myxscale = myinch / mydpi;
  myyscale = myinch / mydpi;
  union () {
  for (pos =[0: 3:length]) {
      translate (v =
		 [pos * myinch, (0.0 - myysize) * myinch,
		  7 + (myinch / 4) * 0]) {
	scale (v =[myxscale, myyscale, 0.1]) {
	  surface (file = "3x3Straight.png", center = false, convexity = 5);
	}
      }
    }
  }
}

module
mysupport () {
  difference () {
    cylinder (h = 6.995, r1 = 5, r2 = 5, center = true);
    translate (v =[0, 0, -1]) {
      cylinder (h = 10, r1 = 4, r2 = 4, center = true);
    }
  }
}


union () {
  intersection () {
    myobject ();
    translate (v =[0, -3.0 * myinch, 0]) {
      cube ([length * myinch, 3.0 * myinch, 33]);
    }
  }
  translate (v =[0, -3 * myinch, 0]) {
    rotate (90, v =[0, 0, 1]) {
      import ("D-TRP-v7.0.stl", convexity = 3);
  }}
  translate (v =[length * myinch, 0, 0]) {
    rotate (-90, v =[0, 0, 1]) {
      import ("D-TRP-v7.0.stl", convexity = 3);
  }}
  bound = floor ((length - 5) / 3) * 3;
for (pos =[0: 3:bound]) {
    translate (v =[1 * myinch + pos * myinch, 0, 0]) {
      rotate (0, v =[0, 0, 1]) {
	import ("D-TRP-v7.0.stl", convexity = 3);
      }
    }
    translate (v =[4 * myinch + pos * myinch, -3 * myinch, 0]) {
      rotate (180, v =[0, 0, 1]) {
	import ("D-TRP-v7.0.stl", convexity = 3);
      }
    }
  }
for (pos =[1: 1:length - 1]) {
    translate (v =[pos * myinch, -1 * myinch, 0]) {
      mysupport ();
    }
    translate (v =[pos * myinch, -2 * myinch, 0]) {
      mysupport ();
    }
  }
  intersection () {
  for (pos =[1: 1:length]) {
      translate (v =[pos * myinch - 0.5 * myinch, -0.5 * myinch, 0]) {
	mysupport ();
      }
      translate (v =[pos * myinch - 0.5 * myinch, -1.5 * myinch, 0]) {
	mysupport ();
      }
      translate (v =[pos * myinch - 0.5 * myinch, -2.5 * myinch, 0]) {
	mysupport ();
      }
    }
    translate (v =[myinch * 0.5, -2.5 * myinch - 0.05, -1]) {
      cube ([(length - 1) * myinch, 2.0 * myinch + 0.1, 33]);
    }
  }
}
