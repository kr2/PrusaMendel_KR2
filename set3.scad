/* set3
 * Copyright (c) 2012 by Krallinger Sebastian [s.krallinger+cc@gmail.com]
 * Licensed under 
 * GPL v2 or later [http://www.gnu.org/licenses/].
 */

use <z-motor-mount.scad>

use <rod-clamp.scad>
use <bar-clamp.scad>

use <gregs-y-axis-holder.scad>


%cube(size=[150, 150, 1], center=true);

translate([-43, -48, 0]) 
for (i=[0:3]) {
	translate([0+i%2*22, 28*i, 0]) rotate(a=90,v=[0,0,1]) 
	y_axis_holder();
}




translate([47, -72, 0]) 
for (i=[0:7]) {
	translate([0, i*18, 0])
	barclamp();
}

translate([-25.5, -72, 0]) 
for (i=[0:4]) {
	translate([i*17.75,0 , 0])
	rotate(a=90,v=[0,0,1]) 
	barclamp();
}
translate([-55, 45, 0]) rotate(a=90,v=[0,0,1]) 
barclamp();


translate([8, -17, 0]) 
for (i=[0:1])
translate([0, i*58, 0]) 
rotate(a=90,v=[0,0,1]) {
	zmotormount();
	
	translate([6.5, -33, 0]) 
	rotate(a=-90,v=[0,0,1]) 
	rodclamp();
}
