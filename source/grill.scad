
$fn = 128;

use <bolts.scad>;
use <fan.scad>;
use <zcube.scad>;

size = 140;
space = 2;

height = 2;

inset = 2;

// Nozzle width and layer height.
width = 0.4;
thickness = 0.2;

angle = 180 / ((height / thickness) - 2 - 2);

module cutout(inset = 0) {
	translate([0, 0, -height/2]) cylinder(d=size-inset*2, h=height*2);
}

module bracket() {
	render()
	difference() {
		rcube([size, size, height], d=10, f=1);
		fan_holes(size, z=0) hole(5, height);
		cutout(inset);
		mesh(f=width*2, inset=inset/2, t=thickness/10);
	}
}

module mesh(f = 0, t = 0, inset = 0) {
	intersection() {
		for (i = [0:(height/thickness)-3]) {
			translate([0, 0, thickness*(i+1)]) rotate([0, 0, angle*i]) union() {
				color("red")
				for (x = [0:space:size/2 - (inset + space)]) {
					translate([x, 0, 0]) zcube([width + f, size, thickness + t]);
					translate([-x, 0, 0]) zcube([width + f, size, thickness + t]);
				}
			}
		}
		
		cutout(inset);
	}
}

union() {
	mesh();
	bracket();
}
	
/* hull() {
	translate([size/2 - 5, size/2 - 5, 0]) cylinder(d=10, h=height);
	cylinder(d=size, h=height);
} */
