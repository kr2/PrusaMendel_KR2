// Gregs PRUSA Mendel  
// X-carriage
// Used for sliding on X axis
// GNU GPL v2
// Greg Frost
//https://github.com/GregFrost/PrusaMendel

include <gregs-lm8uu-holder.scad>

y_axis_holder ();

screw_hole_r=4/2;

module y_axis_holder()
{
	difference()
	{
		render()
		lm8uu_bearing_holder();
		for (hole=[-1,1])
		{
			translate([lm8uu_holder_width/2,
				lm8uu_holder_length/2+
				hole*(lm8uu_support_thickness+lm8uu_holder_gap/2),0])
			{
				cylinder(r1=screw_hole_r,	
					r2=screw_hole_r+(lm8uu_support_thickness+1)/2,
					h=lm8uu_support_thickness+1);
				translate([0,0,-1])
				cylinder(r=screw_hole_r,h=2);
			}
		}
	}
}
