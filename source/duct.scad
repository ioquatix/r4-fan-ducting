
$fn = 128;

use <bolts.scad>;
use <fan.scad>;
use <zcube.scad>;

depth = 70 - 25 - 2;

size = 140;
space = 2;

height = 2;

inset = 2;

grill = [145, 185, 0];
gpu = [40, 240, 200, 230];

module bracket() {
	render()
	translate(grill)
	difference() {
		rcube([size, size, height], d=10, f=-1);
		mirror([0, 0, 1]) fan_holes(z=0) hole(5, height);
		translate([0, 0, -3]) cylinder(d=size-inset*2, h=4);
	}
}

module duct_tube(offset = 0) {
	render()
	hull() {
		translate([gpu[0] + (gpu[1] - gpu[0])/2, gpu[2] + (gpu[3] - gpu[2])/2, -depth])
		rcube([gpu[1] - gpu[0] + offset, gpu[3] - gpu[2] + offset, 2], d=10, f=-1);
		
		translate(grill)
		mirror([0, 0, 1]) cylinder(d=size-inset*2+offset, h=2);
	}
}

render()
union() {
	difference() {
		bracket();
		duct_tube();
	}
	
	difference() {
		minkowski() {
			duct_tube();
			sphere(d=1.0);
		}
		
		duct_tube(-2);
		
		translate(grill)
		zcube([size*2, size*2, 1], f=1);
		
		translate([grill.x, grill.y, -depth - 2])
		zcube([size*2, size*2, 1], f=-1);
	}
	
	/* intersection() {
		duct_tube();
		
		translate(grill)
		zcube([0.8, size, size], f=-1);
	} */
}
