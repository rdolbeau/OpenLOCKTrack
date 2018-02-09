myinch = 25.4;
$vpt =[4.00 * myinch, -5.00 * myinch, 2.00 * myinch];
$vpr =[55.00, 0.00, 35.00];
module
myobject () {
  myxsize = 3;
  myysize = 1;
  mydpi = 120;
  myxscale = myinch / mydpi;
  myyscale = myinch / mydpi;
  translate (v =[0 * myinch, (0 - myysize) * myinch, 7]) {
    scale (v =[myxscale, myyscale, 0.1]) {
      surface (file = "3x1Straight.png", center = false, convexity = 5);
    }
  }
}

union () {
  difference () {
    translate (v =[0, -3 * myinch, 0]) {
      rotate (90, v =[0, 0, 1]) {
	myobject ();
      }
    }
    translate (v =[0.5 * myinch, -1.5 * myinch, 7]) {
      scale (v =[1, 2 / 3, 1]) {
	rotate (90, v =[0, 0, 01]) {
	  linear_extrude (height = 10) {
	    text ("Checkpoint", halign = "center", valign = "center");
	  }
	}
      }
    }
  }
  translate (v =[0, -3 * myinch, 0]) {
    rotate (90, v =[0, 0, 1]) {
      import ("SA-TRP-v7.0.stl", convexity = 3);
  }}
}
