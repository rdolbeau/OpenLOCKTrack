myinch = 25.4;
$vpt =[4.00 * myinch, -5.00 * myinch, 2.00 * myinch];
$vpr =[55.00, 0.00, 35.00];
base = 0;
low = 0;
height = 1;

angle = 15;
depth = 1.5;
wallwidth = 3;

module
myhalfpin () {
  intersection () {
    translate(v=[0,0,-0.1]) cylinder (r1 = 2, r2 = 2, 2.9);
    translate (v =[-5, -10, -5]) {
      cube (size =[10, 10.001, 10]);
    }
  }
}

module
mybiggerhalfpin () {
  intersection () {
    translate(v=[0,0,-0.1]) { cylinder (r1 = 2.05, r2 = 2.05, 3); }
    translate (v =[-5, -10, -5]) {
      cube (size =[10, 10.01, 10]);
    }
  }
}

module
mywallABottom () {
  difference () {
    translate (v =[0, -wallwidth, 0]) {
      cube (size =[depth * myinch, wallwidth + 0.001, myinch * 3 / 4]);
    }
    translate (v =[depth / 4 * myinch, -wallwidth * 3 / 2, myinch / 4]) {
      cube (size =[depth / 2 * myinch, 2 * wallwidth, myinch]);
    }
  }
  translate (v =[1 / 8 * depth * myinch, 0, 3 / 4 * myinch]) {
    myhalfpin ();
  }
  translate (v =[7 / 8 * depth * myinch, 0, 3 / 4 * myinch]) {
    myhalfpin ();
  }
}

module
mywallBBottom () {
  mirror (v =[0, 1, 0]) {
    mywallABottom ();
  }
}

module
mywallCBottom () {
  difference () {
    translate (v =[depth * myinch - wallwidth, -myinch, 0]) {
      cube (size =[wallwidth, myinch, 3 / 4 * myinch]);
    }
    translate (v =
	       [depth * myinch - 2 * wallwidth, -3 / 4 * myinch,
		myinch / 4]) {
      cube (size =[wallwidth * 3, myinch / 2, myinch]);
    }
  }
}

module
mywallATop () {
  translate (v =[0, -wallwidth, myinch]) {
    polyhedron (points =[[depth * myinch, wallwidth + 0.001, 0],
			 [depth * myinch, 0, 0],
			 [0, 0, 0],
			 [0, wallwidth + 0.001, 0],
			 [0, wallwidth + 0.001,
			  depth * myinch * sin (angle) / cos (angle)],[0, 0, depth * myinch * sin (angle) / cos (angle)]],
		faces =
		[[0, 1, 2, 3],[5, 4, 3, 2],[0, 4, 5, 1],[0, 3, 4],[5, 2, 1]],
		convexity = 1);
  }
  difference () {
    translate (v =[0, -wallwidth, myinch * 3 / 4]) {
      cube (size =[depth * myinch, wallwidth + 0.001, myinch / 4 + 0.001]);
    }
    union () {
      translate (v =[1 / 8 * depth * myinch, 0, 3 / 4 * myinch]) {
	mybiggerhalfpin ();
      }
      translate (v =[7 / 8 * depth * myinch, 0, 3 / 4 * myinch]) {
	mybiggerhalfpin ();
      }
  }}
}

module
mywallBTop () {
  mirror (v =[0, 1, 0]) {
    mywallATop ();
  }
}

module
mywallCTop () {
  translate (v =[depth * myinch - wallwidth, -myinch, 3 / 4 * myinch]) {
    cube (size =[wallwidth, myinch, 1 / 4 * myinch + 0.001]);
  }

}

module
mystand (size) {
for (i =[0:size - 1]) {
    translate (v =[0, -myinch * i, 0]) {
      mywallABottom ();
      translate (v =[0, -myinch, 0]) {
	mywallBBottom ();
      }
      mywallCBottom ();
    }
    }
}


module
myroof (size) {
  roofpoints =[[depth * myinch, -myinch * size - wallwidth, 0],	//0
	       [depth * myinch, wallwidth, 0],	//1
	       [0, wallwidth, depth * myinch * sin (angle) / cos (angle)],	//2
	       [0, -myinch * size - wallwidth, depth * myinch * sin (angle) / cos (angle)],	//3
	       [depth * myinch, -myinch * size - wallwidth, wallwidth],	//4
	       [depth * myinch, wallwidth, wallwidth],	//5
	       [0, wallwidth, depth * myinch * sin (angle) / cos (angle) + wallwidth],	//6
	       [0, -myinch * size - wallwidth, depth * myinch * sin (angle) / cos (angle) + wallwidth]];	//4

  rooffaces =[[0, 1, 2, 3],	// bottom
	      [4, 5, 1, 0],	// front
	      [7, 6, 5, 4],	// top
	      [5, 6, 2, 1],	// right
	      [6, 7, 3, 2],	// back
	      [7, 4, 0, 3]];	// left

  translate (v =[0, 0, myinch]) {
    polyhedron (roofpoints, rooffaces);
  }
  
	mywallBTop ();
for (i =[0:size - 1]) {
    translate (v =[0, -myinch * i, 0]) {
      mywallATop ();
      translate (v =[0, -myinch, 0]) {
	mywallBTop ();
      }
      mywallCTop ();
    }
  }
  translate (v =[0, -myinch*size, 0]) {
      mywallATop ();
  }
}

//mywallA();
//mywallB();

//myroof(3);

//mystand(3);
