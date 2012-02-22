// PRUSA Mendel  
// X-end with NEMA 17 motor mount
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>
use <teardrop.scad>
corection = 1.17; 

/**
 * @id x-end-motor
 * @name X end motor
 * @category Printed
 * @using 2 bushing
 * @using 4 m3x10xhex
 * @using 4 m3washer
 * @using 1 m8spring
 * @using 2 m8nut
 */

use <x-end.scad>

xendmotor(endstop_mount=true,curved_sides=true,closed_end=true,luu_version=false,adjustable_z_stop=true);

module xendmotor(endstop_mount=false,curved_sides=false,closed_end=true,luu_version=false,adjustable_z_stop=true)
{
	difference ()
	{
		union ()
		{
			xend(endstop_mount=endstop_mount,
				closed_end=closed_end,
				curved_sides=curved_sides,
				override_height=luu_version?56.5:-1,
				luu_version=luu_version);
//			import_stl("x-end.stl");
		
			positioned_motor_mount();

			if (adjustable_z_stop)
			  z_stop();
		}
		positioned_motor_mount_holes();
		xendcorners(5,0,5,5,0);
	}
}

// GregFrosts stuff
nema17_hole_spacing=1.2*25.4; 
nema17_width=1.7*25.4;
thickness=9;
nema17_support_d=nema17_width-nema17_hole_spacing;
motor_mount_rotation=[0,0,0];
motor_mount_translation=[44-thickness,8,23.5-4.7-12+24.5];

top_corner=motor_mount_translation+[thickness,nema17_width/2,nema17_width/2];
bridge_length=top_corner[0]-9;
bridge_shear=0.48;

module z_stop()
{
	z_stop_width=10;
	z_stop_height=1.8;

	translate([-20,motor_mount_translation[1]+(nema17_width)/2-z_stop_width,0])
	{
		translate([z_stop_width/2,0,0])
		cube([50-z_stop_width/2,z_stop_width,z_stop_height]);

		translate([z_stop_width/2,z_stop_width/2,0])
		difference()
		{
			cylinder(r=z_stop_width/2,h=z_stop_height*2,$fn=32);
		}

		difference()
		{
			union()
			{
				translate([0,-5,8])
				cube([8.75,z_stop_width/2+5,15.8-8]);
				translate([8.75/2,5,2*z_stop_height+0.8])
				cylinder(r=m3_nut_diameter/2+1.28,h=15.8-2*z_stop_height-0.8-7.8-0.8,$fn=6);
				translate([8.75/2,5,0])
				cylinder(r=m3_nut_diameter/2+0.3*2.1,h=15.8-1,$fn=6);
				translate([8.75/2,5,8])
				cylinder(r=m3_nut_diameter/2+1.28,h=7.8,$fn=6);
			}
	
			translate([8.75/2,5,0])
			cylinder(r=m3_diameter/2,h=8,$fn=16);

			translate([8.75/2,5,8+2+0.4])
			cylinder(r=m3_diameter/2,h=10,$fn=16);
	
			translate([8.75/2,5,z_stop_height])
			cylinder(r=m3_nut_diameter/2,h=8+2-z_stop_height,$fn=6);
	
			translate([8.75/2,5,15.8-2])
			cylinder(r=m3_nut_diameter/2,h=3,$fn=6);
		}
	}
}

module positioned_motor_mount()
{
	difference ()
	{
		translate(motor_mount_translation)
		union()
		{
			rotate([0,90,0])
			motor_mount ();
			
			translate(-motor_mount_translation)
			{
				translate(top_corner+
				[-bridge_length,-nema17_support_d-bridge_shear*bridge_length,-2.5])
				multmatrix([[1,0,0],[bridge_shear,1,0],[0,0,1]])
				cube([bridge_length,nema17_support_d,6]);
				#
				render()
				translate(top_corner+[-thickness,-nema17_support_d,-nema17_support_d/2])
				intersection()
				{
					translate([0,-bridge_shear*thickness,0])
					multmatrix([[1,0,0],[bridge_shear,1,0],[0,0,1]])
					cube([thickness,nema17_support_d,nema17_support_d/2]);
					cube([thickness,nema17_support_d,nema17_support_d/2]);
				}
			}
			
			render()
			intersection()
			{
				translate([0,-nema17_width/2+nema17_support_d/2,1])
				rotate([0,90,0])
				translate([3.6*1.5*thickness,0,-thickness])
				multmatrix([[1,0,-3.6],[0,1,0],[0,0,2]])
				{
					rotate(90)
					linear_extrude(height=thickness)
					barbell(nema17_support_d/2,
					nema17_support_d/2,20,60,nema17_hole_spacing);
					translate([-20,-nema17_support_d/2,0])
					cube([20,nema17_width,thickness]);
				}
				
				translate([0,0,-motor_mount_translation[2]+15.8/2])
				cube([thickness*3,nema17_width,15.8],true);
			}
		}

		translate([25,-26,15.8/2])
		rotate(90) 
		teardropcentering(6,42);

		translate([20,-23,-1])
		cube([8.5,36,20]);
	}
}

module positioned_motor_mount_holes()
{
	translate(motor_mount_translation)
	rotate([0,90,0])
	motor_mount_holes ();
}

module motor_mount ()
{
	rotate(motor_mount_rotation)
	{
		for (hole=[1,2])
		rotate([0,0,90*hole])
		linear_extrude(height=thickness)
		translate(-nema17_hole_spacing*[1,1,0]/2)
		barbell (nema17_support_d/2,
		nema17_support_d/2,20,60,nema17_hole_spacing);
		% cube([nema17_width,nema17_width,0.1],true);
	}
}

module motor_mount_holes ()
{
	// Motor mount holes. 
	translate([0,0,1])
	rotate(motor_mount_rotation)
	{
		for (hole=[3:5])
		rotate([0,0,90*hole])
		translate(nema17_hole_spacing*[1,1,0]/2)
		rotate(360/16)
		cylinder(h=thickness+2,r=4.4/2,$fn=8);
		
		for (hole=[3:5])
		rotate([0,0,90*hole])
		translate(nema17_hole_spacing*[1,1,0]/2)
		translate([0,0,-24])
		cylinder(h=25,r=7/2);
	}
	
	translate([-7/2-0.5-(nema17_width/2-nema17_hole_spacing/2),0,0])
	rotate(270)
	translate([0,0,-1])
	cube([nema17_width/2,nema17_width/2,thickness+2]);
}

module barbell (r1,r2,r3,r4,separation) 
{
	x1=[0,0];
	x2=[separation,0];
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	# render()
	difference ()
	{
		union()
		{
			translate(x1)
			circle (r=r1);
			translate(x2)
			circle(r=r2);
			polygon (points=[x1,x3,x2,x4]);
		}
		translate(x3)
		circle(r=r3,$fa=5);
		translate(x4)
		circle(r=r4,$fa=5);
	}
}

function triangulate (point1, point2, length1, length2) = 
point1 + 
length1*rotated(
atan2(point2[1]-point1[1],point2[0]-point1[0])+
angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
(point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b)); 

function rotated(a)=[cos(a),sin(a),0];

