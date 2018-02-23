myinch = 25.4;

module
mywall(	wallwidth = 2 / 3 * myinch / 2,
	walllength = myinch,
	wallheight = myinch * 3 / 4) {

  translate (v =[0, - wallwidth - 1, 6.95]) {
    cube (size =[walllength, wallwidth, wallheight+0.1]);
  }
  translate (v =[0, - wallwidth - 1, 7 + wallheight]) {
    rotate (90, v =[0, 1, 0]) {
      rotate (90, v =[0, 0, 1]) {
	linear_extrude (height = walllength, convexity = 2) {
	  polygon (points =
		   [[-1, 0],[wallwidth + 1, 0],[wallwidth + 1, 3],
		    [wallwidth * 3 / 4, 6],[wallwidth * 1 / 4, 6],[-1, 3]]);
	}
      }
    }
  }
}
