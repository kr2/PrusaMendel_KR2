// PRUSA Mendel  
// motor/leadscrew coupling
// Used for connecting motor to leadscrew
// GNU GPL v2
// Gregs New Z Coupling.
include <configuration.scad>

/**
 * @name Coupling
 * @category Printed
 */

m8_nut_height=7; 
washer_diameter=19.5;
washer_thickness=1.6;
max_adjustment=1.2;

m8_nut_flat_to_flat=m8_nut_diameter*cos(30);
m8_overlap=m8_nut_diameter-m8_nut_flat_to_flat+0.5;
flange_diameter=(m8_nut_diameter*cos(30)+m8_overlap*2)/cos(30);

surround_thickness=3;
surround_nut_trap=2.2;
surround_nut_height=m3_nut_diameter/2+1.2;
surround_inner_d=(flange_diameter*cos(30)+max_adjustment+2)/cos(30);
surround_outer_d=(surround_inner_d*cos(30)+2*surround_thickness)/cos(15);
surround_height=2*m8_nut_height+surround_thickness;
surround_bevel_radius=surround_thickness*1.2;

cup_base_thickness=3;
cup_clearance=0.25;
cup_walls=2;
cup_inner_diameter=(surround_outer_d*cos(15)+2*cup_clearance)/cos(15);
cup_outer_diameter=(cup_inner_diameter*cos(15)+cup_walls*2)/cos(15);
cup_height=cup_base_thickness+washer_thickness+surround_nut_height+m3_diameter/2+3.5;

coupling();
translate([cup_outer_diameter/2+surround_outer_d/2+2,0,0])
coupling_cup ();

module coupling_cup()
{
	difference()
	{
		rotate(180/12)
		cylinder(r=cup_outer_diameter/2,h=cup_height,$fn=12);
		rotate(180/12)
		translate([0,0,cup_base_thickness])
		cylinder(r=cup_inner_diameter/2,h=cup_height-cup_base_thickness+1,$fn=12);

		for (i=[0:2])
		rotate(i*120)
		rotate([-90,0,0])
		translate([0,-surround_nut_height-cup_base_thickness-washer_thickness,cup_inner_diameter/2*cos(15)-1])
		{
			rotate(180/8)
			cylinder(r=m3_diameter/2,h=cup_walls+2,$fn=8);
		}

		translate([0,0,-1])
		cylinder(r=m8_diameter/2+max_adjustment,h=cup_base_thickness+2,$fn=20);
	}
}

module coupling()
{
	difference ()
	{
		translate([0,0,surround_height])
#		render()
		intersection ()
		{
			translate([0,0,-3])
			union()
			{
				cylinder(h = 15.5, r=7);
				translate(v = [0, 6, 6.25]) cube(size = [14,12,18.5], center = true);
			}
			translate([0,0,-1])
			cylinder(r=11.8,h=32);
		}

		// inside diameter
		translate(v = [0, 0, surround_height])cylinder(h = 16, r=motor_shaft/2-0.1, $fn=16);
		
		// screw holes
		rotate ([0,0,90]) translate(v = [6, 15, 7.5+surround_height]) rotate ([90,0,0]) 
		rotate(360/16)
		cylinder(h = 30, r=m3_diameter/2, $fn=8);
		rotate ([0,0,90]) translate(v = [6, 12-2, 7.5+surround_height]) rotate ([90,0,0]) 
		cylinder(h = 5, r=m3_nut_diameter/2, $fn=6);
		rotate ([0,0,90]) translate(v = [6, 12-14-5+2, 7.5+surround_height]) rotate ([90,0,0]) 
		cylinder(h = 5, r=m3_nut_diameter/2+0.1, $fn=16);

		//main cut
		translate(v = [0, 10, 8+surround_height]) cube(size = [2,20,16], center = true);
		
		//difference cut
		render()intersection ()
		{
			translate(v = [0, 7, surround_height + 0.5])  cube(size = [20,8,1], center = true);
			translate([0,0,surround_height-0.5])
			cylinder(r=11,h=3);
		}
	}

	// The support around the bottom nut.
	
	difference ()
	{
		union ()
		{
			cylinder(r=flange_diameter/2, h=m8_nut_height,$fn=6);		
			for (i=[0:2])
			rotate(120*i)
			{
				translate([-flange_diameter/2*sin(30),flange_diameter*cos(30)/2-m8_overlap/2,0])
				cube([flange_diameter*sin(30),m8_overlap/2,2*m8_nut_height+1]);
			}
		}
		translate([0,0,-1])
		cylinder(r=m8_nut_diameter/2,h=m8_nut_height+2,$fn=6);		


		for (i=[0:2])
		rotate(120*i+60)
		{
			translate([-max_adjustment/2,0,-1])
			cube([max_adjustment,flange_diameter*cos(30)/2+1,m8_nut_height+2]);
		}
	}	

	// The surround.

	difference ()
	{
		rotate(180/12)
		cylinder (r=surround_outer_d/2,h=surround_height,$fn=12);
	
		//bevel the bottom so it fits in the cup without cleanup.

		rotate(180/12)
		render () difference ()
		{
			translate([0,0,-1])
			cylinder (r=surround_outer_d/2+1,h=0.4 + 1,$fn=12);
			translate([0,0,-2])
			cylinder (r=surround_outer_d/2-0.5,h=0.4 + 1 + 2,$fn=12);
		}

		translate([0,0,-1])
		cylinder (r=surround_inner_d/2,h=2*m8_nut_height,$fn=6);

		for (i=[0:2])
		rotate(i*120)
		rotate([-90,0,0])
		translate([0,-surround_nut_height,surround_inner_d/2*cos(30)-1])
		{
			cylinder(r=m3_nut_diameter/2,h=surround_nut_trap+1,$fn=6);
			rotate(180/8)
			cylinder(r=m3_diameter/2,h=surround_thickness+2,$fn=8);
		}

		translate([0,0,surround_height-surround_bevel_radius])
		rotate_extrude ()
		{
			translate([surround_outer_d/2-surround_bevel_radius,0])
			difference()
			{
			square([surround_bevel_radius+1,surround_bevel_radius+1]);
			circle(r=surround_bevel_radius,$fn=20);
			}
		}
	}
}