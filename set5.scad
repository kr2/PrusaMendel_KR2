/* set5
 * Copyright (c) 2012 by Krallinger Sebastian [s.krallinger+cc@gmail.com]
 * Licensed under 
 * GPL v2 or later [http://www.gnu.org/licenses/].
 */

use <gregs-wadebits.scad>
use <gregs-wade-v3.scad>
use <bearing-guide.scad>

use <gregs-new-coupling.scad>

%cube(size=[150, 150, 1], center=true);


module couplingPair() {
	coupling();
	translate([-35,0,0])
	coupling_cup ();
}


translate([-15,38, 0]) rotate(a=50,v=[0,0,1]) 
couplingPair();
 
translate([-55, -20, 0]) rotate(a=90,v=[0,0,1]) 
couplingPair();


translate([-5, -63, 0]) 
extruder();
module extruder() {
	wade(hotend_mount=512); //geeksbase_mount=512;

	translate([-15,40,0])
	bearing_washer();

	//color([0.5,0.5,1])
	//import("gregs-wade-v3.stl");

	//translate([-28.5,0,0])
	//import("Toms_guided_greg_v2.stl");

	//Place for printing
	translate([50,56,15.25])
	rotate(180)
	rotate([0,-90,0])

	//Place for assembly.
	wadeidler(); 
}


translate([45, -35, 0]) 
rotate(a=60,v=[0,0,1]) 
gears();
module gears() {
	translate([55,40,0]) 
	WadesL(); //this module call will make the large gear
	translate([15,60,0]) 
	WadesS(); //this module call will make the small gear
}
