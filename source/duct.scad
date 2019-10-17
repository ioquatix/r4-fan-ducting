
$fn = 128;

use <bolts.scad>;
use <fan.scad>;
use <zcube.scad>;

grill = [145, 185];
gpu = [40, 240, 200, 220];

module bracket() {
	translate(grill)
	difference() {
		rcube([140, 140, 2], d=10);
		fan_holes(z=0) hole(4, 35);
		translate([0, 0, -1]) cylinder(d=140-0.1, h=4);
	}
}

module duct_shape(offset = 0) {
	hull() {
		translate([gpu[0] + (gpu[1] - gpu[0])/2, gpu[2] + (gpu[3] - gpu[2])/2, -40])
		zcube([gpu[1] - gpu[0] + offset, gpu[3] - gpu[2] + offset, 2]);
		
		translate(grill)
		cylinder(d=140-0.1+offset, h=2);
	}
}

module duct() {
	difference() {
		duct_shape();
		duct_shape(-2);
	}
}

union() {
	difference() {
		bracket();
		duct_shape();
	}
	
	color("orange")
	render() duct();
}
