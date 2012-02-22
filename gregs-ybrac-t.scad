// PRUSA Mendel  
// Y motor bracket by Spacexula!!
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>

/**
 *@name Y motor bracket
 *@link y-motor-bracket
 *@category Printed
 *@using 3 m3washer
 *@using 3 m3x10
 */ 

nema17_hole_spacing=1.2*25.4;
nema17_width=1.7*25.4;
thickness=7;
nema17_support_d=nema17_width-nema17_hole_spacing;
standoff=12.5;
full_height=thickness+standoff;
rod_surround_diameter=20;
top_rod_position=[29.4,51.05,0];
rod_centres_gap=sqrt(top_rod_position[0]*top_rod_position[0]+
				top_rod_position[1]*top_rod_position[1]);
motor_mount_position=[38,18,0];
mount_rotation=2;
motor_mount_rotation=[0,0,mount_rotation];

motor_mount1=rotated (-45+mount_rotation)*sqrt(2)*nema17_hole_spacing/2+motor_mount_position;
motor_mount2=rotated (45+mount_rotation)*sqrt(2)*nema17_hole_spacing/2+motor_mount_position;
top_offset=motor_mount2-top_rod_position;

//translate([0,0,1])%import_stl("gregs-ybrac-t.stl");

module ybract()
{
	
	// Motor supports.
	difference()
	{
		union()
		{
			//gap fill.
			translate([12,7,0])
#			cylinder(r=10,h=thickness);
			//gap fill.
			translate([33,40,0])
#			cylinder(r=5,h=thickness);

			rotate(atan2(top_rod_position[1],top_rod_position[0]))
			linear_extrude(height=thickness)
			barbell (rod_surround_diameter/2,rod_surround_diameter/2,52,280,rod_centres_gap);
		
			linear_extrude(height=thickness)
			rotate(atan2(motor_mount1[1],motor_mount1[0]))
			barbell (rod_surround_diameter/2,
				nema17_support_d/2,30,110,
				sqrt(motor_mount1[0]*motor_mount1[0]+motor_mount1[1]*motor_mount1[1]));
			
			linear_extrude(height=thickness)
			translate(top_rod_position)
			rotate(atan2(top_offset[1],top_offset[0]))
			barbell (rod_surround_diameter/2,
				nema17_support_d/2,60,60,
				sqrt(top_offset[0]*top_offset[0]+top_offset[1]*top_offset[1]));
	
			translate(motor_mount_position)
			rotate(motor_mount_rotation)
			{
				for (hole=[0:3])
					rotate([0,0,90*hole])
				linear_extrude(height=(hole>1)?thickness:full_height)
				translate(-nema17_hole_spacing*[1,1,0]/2)
				barbell (nema17_support_d/2,
					nema17_support_d/2,20,110,nema17_hole_spacing);

//				translate(nema17_hole_spacing*[-1,1,0]/2)
//				cylinder(r=nema17_support_d/2,h=full_height);
	
%				cube([nema17_width,nema17_width,0.1],true);
			}
		}

		// Motor mount holes.
		translate([0,0,-1])
		translate(motor_mount_position)
		rotate(motor_mount_rotation)
		{
			for (hole=[2:4])
			rotate([0,0,90*hole])
			translate(nema17_hole_spacing*[1,1,0]/2)
			cylinder(h=full_height+2,r=4.4/2);
		}
		
		// Rod holes.
		translate([29.4,51.05,-1])
		cylinder(h=full_height+2,r=m8_diameter/2);
		cylinder(h=full_height+2,r=m8_diameter/2);	
	}
}
ybract();

module barbell (r1,r2,r3,r4,separation)
{
	x1=[0,0];
	x2=[separation,0];
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	
#	render()
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