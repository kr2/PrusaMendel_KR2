// Gregs PRUSA Mendel  
// X-carriage
// Used for sliding on X axis
// GNU GPL v2
// Greg Frost
//https://github.com/GregFrost/PrusaMendel

include <gregs-lm8uu-holder.scad>
include <configuration.scad>

OS = 0.01;

cabelTie_height = 2.5;
minDist = 0.5;
genWallThicknes = 1;

//m3_nut_diameter

y_axis_holder ();

// ring with inner radius r and w as witth and h as heigt
module ring(r,w,h,center=false){
	difference() {
		union () {
			cylinder(r=r+w,h=h, center=center);
		}
		union () {
			translate([0, 0, -OS]) 
			cylinder(r=r,h=h+2*OS, center=center);
		}
	}
}
// +(m3_nut_diameter+genWallThicknes)*2 m3_nut_wallDist

module nutFall() {
	translate([-cos(30)*(m3_nut_diameter/2+genWallThicknes*2), 0, 0])  rotate(a=30,v=[0,0,1]) 
	difference() {
		union(){
			cylinder(r=m3_nut_diameter/2+genWallThicknes*2, h=cabelTie_height+lm8uu_support_thickness, center=false,$fn=6);
			rotate(a=-30,v=[0,0,1]) translate([0, -(m3_nut_diameter/2+genWallThicknes*2), 0])
			cube(size=[cos(30)*(m3_nut_diameter/2+genWallThicknes*2),(m3_nut_diameter/2+genWallThicknes*2)*2, cabelTie_height+lm8uu_support_thickness], center=false);
		}

		//nutfall
		translate([0, 0, cabelTie_height+lm8uu_support_thickness-m3_nut_heigth]) 
		cylinder(r=m3_nut_diameter/2, h=m3_nut_heigth+OS, center=false,$fn=6);
		translate([0, 0, -OS]) 
		cylinder(r=m3_diameter/2, h=cabelTie_height+lm8uu_support_thickness+2*OS, center=false,$fn=20);
	}
}
//nutFall();

module y_axis_holder()
{
	difference() {
		union(){
			translate([0, 0, cabelTie_height]) 
			lm8uu_bearing_holder();

			//screwPlate
			translate([0, 0, +OS]) 
			cube(size=[lm8uu_holder_width, lm8uu_holder_length, cabelTie_height], center=false);
			translate([OS, lm8uu_holder_length/2, 0]) 
			nutFall();

			translate([lm8uu_holder_width-OS, lm8uu_holder_length/2, 0]) rotate(a=180,v=[0,0,1]) 
			nutFall();
			
		}
		union(){
			translate([lm8uu_holder_width/2, 2*lm8uu_support_thickness, lm8uu_holder_width/2 +cabelTie_height])
			rotate(a=-90,v=[1,0,0]) 
			 	ring(r=lm8uu_holder_width/2,w=cabelTie_height,h=lm8uu_holder_gap);

			translate([lm8uu_holder_width/2, 4*lm8uu_support_thickness+lm8uu_holder_gap, lm8uu_holder_width/2 +cabelTie_height])
			rotate(a=-90,v=[1,0,0]) 
			 	ring(r=lm8uu_holder_width/2,w=cabelTie_height,h=lm8uu_holder_gap);
			
		}
	}
	

}
