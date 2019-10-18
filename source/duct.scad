
$fn = 128;

use <bolts.scad>;
use <fan.scad>;
use <zcube.scad>;

grill = [145, 185, 0];
gpu = [40, 240, 200, 225];

module bracket() {
	translate(grill)
	difference() {
		rcube([140, 140, 2], d=10, f=-1);
		fan_holes(z=0) hole(5, 35);
		translate([0, 0, -1]) cylinder(d=140-0.1, h=4);
	}
}

module duct_tube(offset = 0) {
	hull() {
		translate([gpu[0] + (gpu[1] - gpu[0])/2, gpu[2] + (gpu[3] - gpu[2])/2, -40])
		rcube([gpu[1] - gpu[0] + offset, gpu[3] - gpu[2] + offset, 2], d=10, f=-1);
		
		translate(grill)
		mirror([0, 0, 1]) cylinder(d=140-0.1+offset, h=2);
	}
}

module duct() {
	difference() {
		duct_tube();
		duct_tube(-2);
	}
}

union() {
	difference() {
		bracket();
		duct_tube();
	}
	
	intersection() {
		duct_tube();
		
		translate(grill)
		zcube([1, 140, 140], f=-1);
	}
	
	color("orange")
	render() duct();
}
