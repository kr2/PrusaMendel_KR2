/* set2
 * Copyright (c) 2012 by Krallinger Sebastian [s.krallinger+cc@gmail.com]
 * Licensed under 
 * GPL v2 or later [http://www.gnu.org/licenses/].
 */

use <gregs-new-x-carriage_mashup.scad>
use <x-end-idler.scad>
use <x-end-motor.scad>

use <y-belt-clamp.scad>

use <RapSwitch.scad>



%cube(size=[150, 150, 1], center=true);

translate([38, -32, 0]) rotate(a=0,v=[0,0,1]) 
xendidler(closed_end=false,curved_sides=true);


translate([41, 36, 0]) 
rotate(a=180,v=[0,0,1]) 
xendmotor(endstop_mount=true,curved_sides=true,closed_end=true,luu_version=false,adjustable_z_stop=true);

translate([-36, -35, 0]) 
gregs_x_carriage_print();


translate([-20, 25, 0]) 
rotate(a=90,v=[0,0,1]) 
y_clamp_print();

translate([35, -5, 0]) 
y_clamp_print();

translate([-40, 67, 0]) rotate(a=-40,v=[0,0,1]) 
rapSwitchPair();

translate([-60, 23, 0]) 
for (i=[0:1]) {
	translate([ -i%2*11, 25*i,0]) 
	rapSwitchPair();
}

module rapSwitchPair() {
	translate([30, 7, 0]) 
	rotate(a=180,v=[0,0,1])
		rapSwitch();
	rapSwitch();
}

