
use <bolts.scad>;
use <fan.scad>;
use <zcube.scad>;

size = 140;

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
		render()
		translate([0, 0, 0.2]) union() {
			for (x = [-size/2:2.5:size/2]) {
				translate([x, 0, 0]) zcube([0.4*2, size, 0.2*3]);
			}
			
			for (y = [-size/2:2.5:size/2]) {
				translate([0, y, 0]) zcube([size, 0.4*2, 0.2*3]);
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
