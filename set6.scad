/* set6
 * Copyright (c) 2012 by Krallinger Sebastian [s.krallinger+cc@gmail.com]
 * Licensed under 
 * GPL v2 or later [http://www.gnu.org/licenses/].
 */

use <gregs-wadebits.scad>
use <gregs-wade-v3.scad>
use <bearing-guide.scad>

%cube(size=[150, 150, 1], center=true);



translate([-20, -50, 0]) 
for (i=[0:3]) {
	translate([0, 35*i, 0]) {
		translate([-35, 0, 0]) 
		bearingguids();
		translate([35, 0, 0]) 
		bearingguids();

	}
	
}

module bearingguids() {
	inner();
	translate([33.5,0,0])
	outer();
}
