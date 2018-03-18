#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


typedef struct {
	const float x;
	const float y;
	const char* name;
} openlockrect;

const openlockrect openlockrectdb[] = {
	/* squares */
	{1.,1.,"I-TRP-v7.0.stl"},
	{2.,2.,"E-TRP-v7.0.stl"},
	{3.,3.,"EA-TRP-v7.0.stl"},
	{4.,4.,"U-TRP-v7.0.stl"},
	{6.,6.,"6x6-TRP-v7.0.stl"},
	{1.5,1.5,"ED-TRP-v7.0.stl"},
	/* rectangles */
	{2.,1.,"S-TRP-v7.0.stl"},
	{3.,1.,"SA-TRP-v7.0.stl"},
	{4.,1.,"SB-TRP-v7.1.stl"},
	{4.,2.,"R-TRP-v7.0.stl"},
	{2.,2.5,"E+A-TRP-v7.0.stl"},
	{1.5,2.,"EC-TRP-v7.0.stl"},
	{-1.,-1.,NULL}
};

const char* findopenlock(const float fx, const float fy, int *rotate) {
	int i = 0;
	while (openlockrectdb[i].name != NULL) {
		if ((openlockrectdb[i].x == fx) && 
		    (openlockrectdb[i].y == fy))
			return openlockrectdb[i].name;
		i++;
	}
	i = 0;
	while (openlockrectdb[i].name != NULL) {
		if ((openlockrectdb[i].x == fy) && 
		    (openlockrectdb[i].y == fx)) {
			*rotate = 90;
			return openlockrectdb[i].name;
		}
		i++;
	}
	return NULL;
}

void printobject(FILE* out, const char* ol, const char* file, 
		 const int layer, const int dpi,
		 const float fx, const float fy,
		 const float mvx, const float mvy,
		 const float depthscale) {
	fprintf(out, "myxsize = %3.1f;\n", fx);
	fprintf(out, "myysize = %3.1f;\n", fy);
	fprintf(out, "mydpi = %d;\n", dpi);
	fprintf(out, "myxscale = myinch/mydpi;\n");
	fprintf(out, "myyscale = myinch/mydpi;\n");
	fprintf(out, "union() {\n");
	fprintf(out, "translate (v=[%3.1f * myinch,(%3.1f - myysize)*myinch, 7+(myinch/4)*%d]) {\n", mvx, mvy, layer);
	fprintf(out, "\tscale (v = [myxscale, myyscale, %f]) {\n", depthscale);
	fprintf(out, "\t\tsurface(file = \"%s.png\", center = false, convexity = 5);", file);
	fprintf(out, "\t}\n"); // scale
	fprintf(out, "}\n"); // translate
	if (layer) {
		fprintf(out, "translate (v=[0,-%3.1f*myinch,6.995]) {\n", fy);
		fprintf(out, "\tcube(size=[myxsize*myinch, myysize*myinch, %d*(myinch/4)+0.01]);\n", layer);
		fprintf(out, "}\n"); // union
	}
	fprintf(out, "}\n"); // union

}

void printolbase(FILE* out, const char* ol, const char* file, const int dpi,
		 const float cropx, const float cropy,
		 const int rotate) {
	if (!rotate) {
		fprintf(out, "union() {\n");
		fprintf(out, "import(\"%s\", convexity=3);\n", ol);
		fprintf(out, "translate (v=[0,-%3.1f*myinch,6.995]) {\n", cropy);
		fprintf(out, "\tcube(size=[%3.1f*myinch, %3.1f*myinch, 0.01]);\n", cropx, cropy);
		fprintf(out, "}\n");
		fprintf(out, "}\n"); // union
	} else { // rotate should be 90
		fprintf(out, "union() {\n");
		fprintf(out, "translate (v=[0,-%3.1f*myinch,0]) { rotate (%d, v=[0,0,1]) {\n", cropy, rotate);
		fprintf(out, "import(\"%s\", convexity=3);\n", ol);
		fprintf(out, "}}\n");
		fprintf(out, "translate (v=[0,-%3.1f*myinch,6.995]) {\n", cropy);
		fprintf(out, "\tcube(size=[%3.1f*myinch, %3.1f*myinch, 0.01]);\n", cropx, cropy);
		fprintf(out, "}\n");
		fprintf(out, "}\n"); // union
	}
}

void printprolog(FILE* out) {
	fprintf(out, "myinch = 25.4;\n");
	fprintf(out, "$vpt= [ 4.00*myinch, -5.00*myinch, 2.00*myinch ];\n");
	fprintf(out, "$vpr=[ 55.00, 0.00, 35.00 ];\n");
}

void printscad(FILE* out, const char* ol, const char* file,
	       const int layer, const int dpi,
	       const float fx, const float fy,
	       const float mvx, const float mvy,
	       const float cropx, const float cropy,
	       const int rotate, const float depthscale) {
	printprolog(out);
	fprintf(out, "module myobject() {\n");
	printobject(out, ol, file, layer, dpi, fx, fy, mvx, mvy, depthscale);
	fprintf(out, "}\n");
	fprintf(out, "union() {\n");
	if ((cropx == fx) && (cropy == fy)) {
		fprintf(out, "myobject();\n");
	} else {
		fprintf(out, "intersection() {\n");
		fprintf(out, "myobject();\n");
		fprintf(out, "translate (v=[0, -%3.1f * myinch, 0]) { cube([%3.1f * myinch, %3.1f * myinch, %d]); }\n", cropy, cropx, cropy, 33);
		fprintf(out, "}\n");
	}
	printolbase(out, ol, file, dpi, cropx, cropy, rotate);
	fprintf(out, "}\n"); // union
}

/* cut a 4x4 EA piece in two Y triangle */
void printolYbase(FILE* out, const char* ol, const char* file, 
		  const int dpi,
		  const float cropx, const float cropy,
		  const int rotate) { // rotate should be 0 or 45
	fprintf(out, "translate(v=[%3.1f*myinch,-%3.1f*myinch,0]) {\n", cropx, cropy);
	fprintf(out, "\trotate(%d+45/2,v=[0,0,1]) {\n", rotate);
	fprintf(out, "\t\timport(\"%s\");\n", ol);
        fprintf(out, "\t}\n");
	fprintf(out, "}\n");
}
/* cut a 4x4 EA piece in two OA triangle */
void printolOAbase(FILE* out, const char* ol, const char* file,
		   const int dpi,
		   const float cropx, const float cropy,
		   const int rotate) { // rotate should be 0 or 90
	if (!rotate) {
		fprintf(out, "translate(v=[4*myinch,0,0]) { rotate(180, v=[0,0,1]) {\n");
		fprintf(out, "import(\"%s\");\n", ol);
		fprintf(out, "}\n");
		fprintf(out, "}\n");
		
	} else {
		fprintf(out, "translate(v=[0,-4*myinch,0]) { rotate(0, v=[0,0,1]) {\n");
		fprintf(out, "import(\"%s\");\n", ol);
		fprintf(out, "}\n");
		fprintf(out, "}\n");
	}
}
/* trim a 4x4 EA piece to a V quartercircle */
void printolVbase(FILE* out, const char* ol, const char* file) {
	fprintf(out, "translate(v=[4*myinch,-4*myinch,0]) {\n");
	fprintf(out, "\trotate(180, v=[0,0,1]) {\n");
	fprintf(out, "\t\timport(\"%s\");\n", ol);
	fprintf(out, "\t}\n");
	fprintf(out, "}\n");
}

void printYscad(FILE* out, const char* ol, const char* file, 
	   const int layer, const int dpi,
	     const float fx, const float fy, 
	     const float cropx, const float cropy,
	     const int rotate, const float depthscale) { // rotate should be 0 or 45
	printprolog(out);
	fprintf(out, "module myobject() {\n");
	printobject(out, ol, file, layer, dpi, fx, fy, 0, 0, depthscale);
	fprintf(out, "}\n");
	fprintf(out, "union() {\n");
	fprintf(out, "intersection() {\n");
	fprintf(out, "myobject();\n");
	fprintf(out, "translate(v=[4*myinch,-4*myinch,0]) {\n");
        fprintf(out, "\trotate(%d,v=[0,0,1]) {\n", rotate);
	fprintf(out, "\t\tlinear_extrude(height=50) {\n");
        fprintf(out, "\t\t\tpolygon(points=[[0,0],[0,4*myinch],[-4*sin(45)*myinch, 4*cos(45)*myinch]]    );\n");
        fprintf(out, "\t\t}\n");
	fprintf(out, "\t}\n"); // rotate
	fprintf(out, "}\n"); // translate
	fprintf(out, "}\n"); // intersection
	printolYbase(out, ol, file, dpi, cropx, cropy, rotate);
	fprintf(out, "}\n"); // union

}

void printOAscad(FILE* out, const char* ol, const char* file,
	    const int layer, const int dpi,
	     const float fx, const float fy, 
	     const float cropx, const float cropy,
	    const int rotate, const float depthscale) { // rotate should be 0 or 90
	printprolog(out);
	fprintf(out, "module myobject() {\n");
	printobject(out, ol, file, layer, dpi, fx, fy, 0, 0, depthscale);
	fprintf(out, "}\n");
	fprintf(out, "union() {\n");
	fprintf(out, "intersection() {\n");
	fprintf(out, "myobject();\n");
	if (!rotate) {
		fprintf(out, "translate(v=[4*myinch,-4*myinch,0]) {\n");
	} else {
		fprintf(out, "\trotate(180,v=[0,0,1]) {\n");
	}
	fprintf(out, "\tlinear_extrude(height=50) {\n");
        fprintf(out, "\t\tpolygon(points=[[0,0],[0,4*myinch],[-4*myinch, 4*myinch]]    );\n");
        fprintf(out, "\t}\n");
	fprintf(out, "}\n"); // rotate || translate 
	fprintf(out, "}\n"); // intersection
	printolOAbase(out, ol, file, dpi, cropx, cropy, rotate);
	fprintf(out, "}\n"); // union
}

void printVscad(FILE* out, const char* ol, const char* file,
            const int layer, const int dpi,
             const float fx, const float fy,
             const float cropx, const float cropy,
	const int rotate, const float depthscale) {
	printprolog(out);
        fprintf(out, "module myobject() {\n");
        printobject(out, ol, file, layer, dpi, fx, fy, 0, 0, depthscale);
        fprintf(out, "}\n");
        fprintf(out, "union() {\n");
        fprintf(out, "intersection() {\n");
        fprintf(out, "myobject();\n");
fprintf(out, "translate(v=[4*myinch,-4*myinch,0]) {\n");
fprintf(out, "cylinder(h = 50, r1 = 4*myinch, r2 = 4*myinch);\n");
fprintf(out, "}\n");
        fprintf(out, "}\n"); // intersection
        printolVbase(out, ol, file);
        fprintf(out, "}\n"); // union
}

void addturretbasescad(FILE *out, int layer, const int x, const int y) {
	fprintf(out, "translate(v=[-2+%d*myinch,-15+(2-%d)*myinch,7+%d*myinch/4]) {scale(v=[2/3,2/3,2/3]) { import(\"death_star_assembly_1.1.stl\");}}\n", x, y, layer);
}

void addpolesscad(FILE *out) {
fprintf(out, "module mypole() {\n");
fprintf(out, "\tcylinder (r1=myinch/8,r2=myinch/8,myinch/8);\n");
fprintf(out, "\tcylinder (r1=myinch/16,r2=myinch/16-0.2,3/2*myinch);\n");
fprintf(out, "}\n");
fprintf(out, "translate(v=[myinch/4,-myinch/4,7]) { mypole();}\n");
fprintf(out, "translate(v=[myinch/4,-11*myinch/4,7]) { mypole();}\n");
}

void addwallscad(FILE *out, const int wall[4], const int layer, const float fx, const float fy) {
	fprintf(out, "include <Wall.scad>\n");
	if (layer > 0) {
		fprintf(out, "translate(v=[0,0,%d*myinch/4]) { // layer translate\n", layer);
	}
	if (wall[0]) {
		fprintf(out, "mywall(walllength=myinch*%f);\n", fx);
	}
	if (wall[1]) {
		fprintf(out, "translate(v=[1,0,0]) {\n");
		fprintf(out, "\trotate(-90,v=[0,0,1]) {\n");
		fprintf(out, "\t\ttranslate(v=[0,1+myinch/3,0]){\n");
		fprintf(out, "\t\t\tmywall(walllength=myinch*%f);\n",fy);
		fprintf(out, "}}}\n");
	}
	if (wall[2]) {
		fprintf(out, "translate(v=[0,-myinch*%f+(2+myinch/3)]) {\n", fy);
		fprintf(out, "mywall(walllength=myinch*%f);\n", fx);
		fprintf(out, "}\n");
	}
	if (wall[3]) {
		fprintf(out, "translate(v=[1+myinch*%f-(2+myinch/3),0,0]) {\n",fx);
		fprintf(out, "\trotate(-90,v=[0,0,1]) {\n");
		fprintf(out, "\t\ttranslate(v=[0,1+myinch/3,0]){\n");
		fprintf(out, "\t\t\tmywall(walllength=myinch*%f);\n",fy);
		fprintf(out, "}}}\n");
	}
	if (layer > 0) {
		fprintf(out, "} // layer translate\n");
	}
}

int findsizes(float *fx, float *fy, const char *file) {
	int r = sscanf(file, "%fx%f", fx, fy);
	/* 	printf("%s: %d (%d, %d)\n", file, r, *fx, *fy); */
	if (r == 2)
		return 1;
	return 0;
}

int main(int argc, char **argv) {
	char c;
	extern int optind, optopt;
	const char **files = malloc(sizeof(const char*) * 1);
	int nfiles = 0;
	int dpi = 120;
	files[0] = NULL;
	int i;
	float cropx = -1.;
	float cropy = -1.;
	float movx = 0., movy = 0.;
	int Ytriangle = 0;
	int OAtriangle = 0;
	int Vqcircle = 0;
	int layer = 0; // 1/4" each
	int namelayer = -1;
	float depthscale = .1;
	int turret = 0;
	int pturret[2];
	int poles = 0;
	int wall[4] = {0, 0, 0, 0};
	int temp;
	
	while ((c = getopt (argc, argv, "d:x:y:X:Y:T:L:E:s:t:P:w:")) != -1) {
		switch (c)
		{
		case 'd':
			dpi = atoi(optarg);
			if ((dpi < 90) || (dpi > 300)) {
				fprintf(stderr, "DPI of %d doesn't make sense to me\n", dpi);
				exit(-1);
			}
			break;
		case 'x':
			cropx = atof(optarg);
			if ((cropx < 0.) || (cropx > 10.)) {
				fprintf(stderr, "Crop X of %3.1f doesn't make sense to me\n", cropx);
				exit(-1);
			}
			break;
		case 'y':
			cropy = atof(optarg);
			if ((cropy < 0.) || (cropy > 10.)) {
				fprintf(stderr, "Crop Y of %3.1f doesn't make sense to me\n", cropy);
				exit(-1);
			}
			break;
		case 'X':
			movx = atof(optarg);
			if ((movx < 0.) || (movx > 10.)) {
				fprintf(stderr, "Mov X of %3.1f doesn't make sense to me\n", movx);
				exit(-1);
			}
			break;
		case 'Y':
			movy = atof(optarg);
			if ((movy < 0.) || (movy > 10.)) {
				fprintf(stderr, "Mov Y of %3.1f doesn't make sense to me\n", movy);
				exit(-1);
			}
			break;
		case 'T':
			if (strncmp("OA", optarg, 2) == 0) {
				OAtriangle = 1;
			} else if (strncmp("Y", optarg, 1) == 0) {
				Ytriangle = 1;
			} else if (strncmp("V", optarg, 1) == 0) {
                                Vqcircle = 1;
                        } else {
				fprintf(stderr, "Cutting to '%s' doesn't make sense to me\n", optarg);
                                exit(-1);
			}
			break;
		case 'L':
			layer = atoi(optarg);
			if ((layer < 0) || (layer > 10)) {
				fprintf(stderr, "Layer of %d doesn't make sense to me\n", layer);
				exit(-1);
			}
			break;
                case 'E':
                        namelayer = atoi(optarg);
                        if ((namelayer < 0) || (namelayer > 10)) {
                                fprintf(stderr, "Namelayer of %d doesn't make sense to me\n", namelayer);
                                exit(-1);
                        }
                        break;
		case 's':
			depthscale = atof(optarg);
                        if ((depthscale < 0.05) || (depthscale > 1.)) {
                                fprintf(stderr, "Depthscale of %f doesn't make sense to me\n", depthscale);
                                exit(-1);
                        }
			break;
		case 't':
			turret = sscanf(optarg, "%dx%d", &pturret[0], &pturret[1]);
			if ((turret == 2) && (pturret[0]>=0) && (pturret[0]<10) && (pturret[1]>=0) && (pturret[1]<10)) {
				turret = 1;
			} else {
				fprintf(stderr, "Turret position of (%dx%d [%d]) doesn't make sense to me\n", pturret[0], pturret[1], turret);
				exit(-1);
			}
			break;
		case 'P':
			poles = !poles;
			break;
		case 'w':
			temp = strtol(optarg, NULL, 0);
			for (i = 0 ; i < 4 ; i++)
				wall[i] = temp & 1<<i;
			break;
		default:
			return -1;
		}
	}
        if (namelayer == -1)
		namelayer = layer;
	for ( ; optind < argc; optind++) {
		if ((nfiles > 0) &&
		    ((cropx != -1.) || (cropy != -1.) ||
		     (movx != 0.) || (movy != 0.) ||
		     (Ytriangle != 0) || (OAtriangle != 0) || (Vqcircle !=0) || turret || poles)) {
			fprintf(stderr, "More than one file and (moving or cropping or triangle or turret or poles), dunno how to do that\n");
			exit(-2);
		}
		files[nfiles] = strndup(argv[optind], 4096);
		char* suffix = strstr(files[nfiles], ".png");
		if (!suffix) {
			fprintf(stderr, "File '%s' is not a PNG file.\n", files[nfiles]);
			exit(-4);
		}
		printf("Dealing with '%s'\n", files[nfiles]);
		suffix[0] = '\0'; // drop suffix
		nfiles ++;
		files = realloc(files, sizeof(const char*) * (nfiles + 1));
		files[nfiles] = NULL;
	}
	
	for (i = 0 ; i < nfiles ; i++) {
		float fx, fy;
		int r = findsizes(&fx, &fy, files[i]);
		float rcropx, rcropy;
		if (cropx == -1.)
			rcropx = fx;
		else
			rcropx = cropx;
		if (cropy == -1.)
			rcropy = fy;
		else
			rcropy = cropy;
		if ((poles) && ((fy != 3.) || Ytriangle || OAtriangle || Vqcircle)) {
			fprintf(stderr, "Poles only supported on 3\" wide rectangular pieces at the moment\n");
			exit(-5);
		}
		if (r && Ytriangle) {
			if (fx != 4.|| fy != 4.) {
				fprintf(stderr, "I only know how to triangularize 4x4 pieces.\n");
				exit(-3);
			}
			fprintf(stderr, "Triangularizing '%s' on Y pieces. BEWARE! Some of the original piece will disappear! Check the result!\n", files[i]);
			const char* ol = "Y-TRP-v7.0.stl";
			printf("Found '%s' for '%s'\n", ol, files[i]);
			char outname[4096];
			snprintf(outname, 4096, "%s_auto_%dY1.scad", files[i], namelayer);
			FILE* out = fopen(outname, "w");
			printYscad(out, ol, files[i], layer, dpi, fx, fy, 4, 4, 0, depthscale);
			fclose(out);
			snprintf(outname, 4096, "%s_auto_%dY2.scad", files[i], namelayer);
			out = fopen(outname, "w");
			printYscad(out, ol, files[i], layer, dpi, fx, fy, 4, 4, 45, depthscale);
			fclose(out);
		} else if (r && OAtriangle) {
			if (fx != 4 || fy != 4) {
				fprintf(stderr, "I only know how to triangularize 4x4 pieces.\n");
				exit(-3);
			}
			const char* ol = "OA-TRP-v7.0.stl";
			printf("Found '%s' for '%s'\n", ol, files[i]);
			char outname[4096];
			snprintf(outname, 4096, "%s_auto_%dOA1.scad", files[i], namelayer);
			FILE* out = fopen(outname, "w");
			printOAscad(out, ol, files[i], layer, dpi, fx, fy, 4, 4, 0, depthscale);
			fclose(out);
			snprintf(outname, 4096, "%s_auto_%dOA2.scad", files[i], namelayer);
			out = fopen(outname, "w");
			printOAscad(out, ol, files[i], layer, dpi, fx, fy, 4, 4, 90, depthscale);
			fclose(out);
		} else if (r && Vqcircle) {
                        if (fx != 4 || fy != 4) {
                                fprintf(stderr, "I only know how to triangularize 4x4 pieces.\n");
                                exit(-3);
                        }
			fprintf(stderr, "Triming '%s' to V piece. BEWARE! Some of the original piece will disappear! Check the result!\n", files[i]);
                        const char* ol = "V-TRP-v7.0.stl";
                        printf("Found '%s' for '%s'\n", ol, files[i]);
                        char outname[4096];
                        snprintf(outname, 4096, "%s_auto_%dV.scad", files[i], namelayer);
                        FILE* out = fopen(outname, "w");
                        printVscad(out, ol, files[i], layer, dpi, fx, fy, 4, 4, 0, depthscale);
                        fclose(out);
		} else
		if (r) {
			int rotate = 0;
			const char* ol = findopenlock(rcropx, rcropy, &rotate);
			if (ol != NULL) {
				printf("Found '%s' for '%s'\n", ol, files[i]);
				char outname[4096];
				char cropxname[128];
				char cropyname[128];
				char movxname[128];
				char movyname[128];
				char turretname[128];
				char polesname[128];
				if (cropx != -1.) {
					snprintf(cropxname, 128, "cx%3.1f", cropx);
				} else cropxname[0] = '\0';
				if (cropy != -1.) {
					snprintf(cropyname, 128, "cy%3.1f", cropy);
				} else cropyname[0] = '\0';
				if (movx != 0.) {
					snprintf(movxname, 128, "mx%3.1f", movx);
				} else movxname[0] = '\0';
				if (movy != 0.) {
					snprintf(movyname, 128, "my%3.1f", movy);
				} else movyname[0] = '\0';
				snprintf(turretname, 128, "_turret%dx%d", pturret[0], pturret[1]);
				snprintf(polesname, 128, "_poles");
				snprintf(outname, 4096, "%s%s%s%s%s%s%s_auto_%d%s%s%s%s.scad", files[i],
					 turret ? turretname : "",
					 poles ? polesname : "",
					 wall[0] ? "_wall1" : "",
					 wall[1] ? "_wall2" : "",
					 wall[2] ? "_wall3" : "",
					 wall[3] ? "_wall4" : "",
					 namelayer,
					 cropxname, cropyname,
					 movxname, movyname);
				FILE* out = fopen(outname, "w");
				printf("Cropping to %3.1f %3.1f \n", rcropx, rcropy);
				printscad(out, ol, files[i], layer, dpi, fx, fy, -movx, movy, rcropx, rcropy, rotate, depthscale);
				if (turret) {
					printf("Adding turret in %dx%d\n", pturret[0], pturret[1]);
					addturretbasescad(out, layer, pturret[0], pturret[1]);
				}
				if (poles) {
					printf("Adding poles\n");
					addpolesscad(out);
				}
				if (wall[0] || wall[1] || wall[2] || wall[3]) {
					addwallscad(out, wall, layer, fx, fy);
				}
				fclose(out);
			} else {
				fprintf(stderr, "Coudn't find an OpenLock base for '%s'\n", files[i]);
			}
		} else {
			fprintf(stderr, "Couldn't find the size of '%s'\n", files[i]);
		}
	}

	free(files); // FIXME: we leak all the duplicated filenames
	
	return 0;
}
