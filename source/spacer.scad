
$fn = 128;

use <bolts.scad>;
use <fan.scad>;
use <zcube.scad>;

size = 140;
space = 2;

height = 2;
inset = 2;

module cutout(inset = 0) {
	translate([0, 0, -height/2]) cylinder(d=size-inset*2, h=height*2);
}

module bracket() {
	render()
	difference() {
		rcube([size, size, height], d=10, f=1);
		fan_holes(size, z=0) hole(5, height);
		cutout(inset);
	}
}

bracket();
	
/* hull() {
	translate([size/2 - 5, size/2 - 5, 0]) cylinder(d=10, h=height);
	cylinder(d=size, h=height);
} */
