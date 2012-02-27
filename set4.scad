/* set4
 * Copyright (c) 2012 by Krallinger Sebastian [s.krallinger+cc@gmail.com]
 * Licensed under 
 * GPL v2 or later [http://www.gnu.org/licenses/].
 */

use <bar-clamp-cross.scad>
use <gregs-ybrac-t.scad>
use <ramps-holder.scad>
use <gregs-endstop-holder.scad>
use <sj-z-rod-stab.scad>

%cube(size=[150, 150, 1], center=true);

translate([-25, 19, 0]) 
for (i=[0:2]) {
	translate([0, i*22, 0])
	barclampCross(a=45);
}

translate([-47,14, 0]) 
for (i=[0:2]) {
	translate([0, i*22, 0]) rotate(a=160,v=[0,0,1]) 
	barclampCross(a=-45);
}

translate([60, 11, 0]) 
rotate(a=80,v=[0,0,1]) 
ybract();




translate([22, -78, 0]) rotate(a=-90,v=[0,0,1]) 
for (i=[0:2])
translate([-64+i*26, 20, 0]) {
	translate([-6, 15, 0]) 
	rotate(a=-90,v=[0,0,1]) 
	endstop();
	rotate(a=90,v=[0,0,1]) 
	endstop();
}


translate([5, -17, 0]) 
rotate(a=0,v=[0,0,1]) {
	ramps_holder(hole_offset=0,endstop_width=10,with_foot=true);
	translate([0,18,0]) rotate(a=10,v=[0,0,1]) 
	ramps_holder(hole_offset=6.35,endstop_width=14);
}

translate([4, -55, 0]) 
rotate(a=-45,v=[0,0,1]) 
	z_rodStab();

translate([-60, -30, 0]) 
rotate(a=100,v=[0,0,1]) 
	z_rodStab();

