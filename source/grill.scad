
use <bolts.scad>;
use <fan.scad>;
use <zcube.scad>;

size = 140;
space = 2.5;

module cutout(s = 0) {
	translate([0, 0, -2]) cylinder(d=size+s, h=4);
}

module bracket() {
	render()
	difference() {
		rcube([size, size, 2], d=10, f=1);
		fan_holes(z=0) hole(5, 35);
		cutout(-2);
	}
}

module mesh() {
	intersection() {
		for (i = [1:8]) {
			translate([0, 0, 0.2*i]) rotate([0, 0, (360/12)*i]) union() {
				for (x = [-size/2:space:size/2]) {
					translate([x, 0, 0]) zcube([0.4, size, 0.2]);
				}
			}
		}
		
		cutout();
	}
}

union() {
	color("red")
	mesh();
	bracket();
}
