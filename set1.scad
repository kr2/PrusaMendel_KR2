/* set1
 * Copyright (c) 2012 by Krallinger Sebastian [s.krallinger+cc@gmail.com]
 * Licensed under 
 * GPL v2 or later [http://www.gnu.org/licenses/].
 */

use <frame-vertex_top.scad>
use <frame-vertex-bottom.scad>

%cube(size=[150, 150, 1], center=true);

translate([-6.5, -22, 0]) 
rotate(a=145,v=[0,0,1]) 
vertex_top();


translate([-90, 52, 0]) 
rotate(a=-66,v=[0,0,1]) 
vertex_top();

translate([55, 20, 0]) 
rotate(a=90,v=[0,0,1]) 
vertex_bottom();

translate([28, -11, 0]) 
rotate(a=160,v=[0,0,1]) 
vertex_bottom();

translate([38, -16, 0]) 
vertex_bottom_pair();



module vertex_bottom_pair(){
	a=-19;
	b=-14;

	rotate(a=180,v=[0,0,1]) 
	translate([a, b, 0]) 
	vertex_bottom();

	translate([a, b, 0]) 
	vertex_bottom();
}

module vertex_bottom_all() {
	a=30;
	b = 10;
	translate([-a, b, 0]) 
	vertex_bottom_pair();

	translate([a, -b, 0]) 
	vertex_bottom_pair();
}