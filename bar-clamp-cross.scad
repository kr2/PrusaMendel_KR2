// PRUSA Mendel  
// Bar clamp
// Used for joining 8mm rods
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>
use <teardrop.scad>


module barclampCross(a=45) {
	genWallThickness = 3.3;
	outer_radius=m8_diameter/2+genWallThickness;
	clamp_width = outer_radius*2;
	clamp_length=25;
	clamp_height=3*outer_radius;
	axe_dist = 5;
	slot_width=5;
 
 	steps = 15;

 	translate([0, 0, clamp_height/2]) 
 	
 	intersection() {
 		translate([clamp_length/4, 0, 0]) 
 			sphere(r=clamp_length*7/10);

 		intersection() {
	 		union() {
	 			for (i=[0:steps]) {
	 				translate([i*(clamp_length-outer_radius)/steps, 0, 0])
	 					cylinder(h=clamp_height,r=outer_radius+i*0.3,center=true);
	 			}
	 			
	 		}

	 		difference() {
		 		union(){
		 			for (i=[0:steps]) {
						translate([i*(clamp_length-outer_radius)/steps, 0, 0]) rotate(a=-i*a/steps,v=[1,0,0]) 
							cylinder(h=clamp_height*10,r=outer_radius,center=true);
					}
		 			
		 		}
		 		union() {
			 		for (i=[0:steps]) {
						translate([i*clamp_length/steps, 0, 0]) rotate(a=-i*a/steps,v=[1,0,0]) 
							cylinder(r=slot_width/2, h=clamp_height*2, center=true);
					}


					#cylinder(h=clamp_height*2,r=m8_diameter/2,$fn=18,center=true);

					translate([axe_dist+m8_diameter,0,0]) rotate([a,0,0]) 
					#cylinder(h=(clamp_width/cos(a)),r=m8_diameter/2,$fn=20,center=true);
			 	}
		 	}
	 	}
 	}
 	
 	
 	
 	
}
barclampCross(a=45);