// Gregs PRUSA Mendel  
// X-carriage
// Used for sliding on X axis
// GNU GPL v2
// Greg Frost
//https://github.com/GregFrost/PrusaMendel

include <gregs-lm8uu-holder.scad>

holder_separation=18;

fan_hole_separation=32; // check
fan_support_block=8;
fan_trap_width=3;
fan_support_thickness=8;
fan_diameter=33;
fan_hole_height=4;

belt_clamp_thickness=2; 
belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;
belt_clamp_hole_separation=10;
belt_clamp_height=m3_diameter+2*belt_clamp_thickness;
belt_clamp_length=belt_clamp_hole_separation+m3_diameter+2*belt_clamp_thickness;

belt_width=6;
belt_thickness=1.5; 
tooth_height=1;
tooth_spacing=2;

key_w=4;
key_l=6;
key_d=2;
belt_allowance=1;

belt_clamp_channel_height=belt_thickness+tooth_height+belt_clamp_thickness*2;

echo ("belt_clamp_width+0.75",belt_clamp_width+0.75);

rotate(45)
for (i=[-1,1])
translate([-5+((i==1)?0:-4),i*(belt_clamp_width/2+4),0])
belt_clamp(i);

translate([10,3,0])
rotate(-45)
belt_clamp_channel();

%cube([120,80,1],true);

gregs_x_carriage();

translate([0,17,0])
ram();

module gregs_x_carriage(with_fanmount=true) 
{
	difference()
	{
		union ()
		{
			if (with_fanmount) 
			translate([0,holder_separation/2+lm8uu_holder_length-fan_support_block,0])
			translate([0,fan_support_block/2,0])
			fan_mount();

			for(i=[-1,1])
			{
				translate([50/2-lm8uu_holder_width/2,
					i*(lm8uu_holder_length+holder_separation)/2-
					lm8uu_holder_length/2,0])
				render()
				lm8uu_bearing_holder();

                                       translate([-50/2-lm8uu_holder_width/2,
					i*(lm8uu_holder_length+holder_separation)/2-
					lm8uu_holder_length/2,0])
					render()
					lm8uu_bearing_holder();
			}

			linear_extrude(height=lm8uu_support_thickness)
			translate([0,0,0])
			{
			barbell (
				[25,holder_separation/2],
				[25,-holder_separation/2],
				lm8uu_holder_width/2,lm8uu_holder_width/2,12,12);
		
			square([40,50],true);				

			translate([-25,-holder_separation/2])
			circle(r=lm8uu_holder_width/2);
                              translate([-25,holder_separation/2])
			circle(r=lm8uu_holder_width/2);

			barbell (
				[25-lm8uu_holder_width/2,
				-holder_separation/2-lm8uu_holder_length+lm8uu_holder_width/2],
				[-25+lm8uu_holder_width/2,
				-holder_separation/2-lm8uu_holder_length+lm8uu_holder_width/2],
				lm8uu_holder_width/2,lm8uu_holder_width/2,12,12);
			}

			translate([25+13.5+1,(lm8uu_holder_length*0.7+holder_separation/2)])
			belt_clamp_socket (version=1);

			mirror([0,1,0])
			translate([25+13.5+1,(lm8uu_holder_length*0.7+holder_separation/2)])
			belt_clamp_socket (version=0);

			// Thicker bit around the big hole.

difference() 
{
cylinder(r=25+m4_diameter,h=6);


translate([holder_separation-4,-lm8uu_holder_length+3.5,-1])
cube([lm8uu_holder_width,lm8uu_holder_length/2,8]);

translate([-holder_separation-18,-lm8uu_holder_length+3.5,-1])
cube([lm8uu_holder_width,lm8uu_holder_length/2,8]);

translate([holder_separation-4,lm8uu_holder_length-19,-1])
cube([lm8uu_holder_width,lm8uu_holder_length/2,8]);

translate([-holder_separation-18,lm8uu_holder_length-19,-1])
cube([lm8uu_holder_width,lm8uu_holder_length/2,8]);

*translate([-holder_separation-lm8uu_holder_width/2,-lm8uu_holder_length/2,-1])
cube([lm8uu_holder_width,lm8uu_holder_length,8]);
}
		}

		translate([25+13.5+1,(lm8uu_holder_length*0.7+holder_separation/2)])
		belt_clamp_holes(1);

		mirror([0,1,0])
		translate([25+13.5+1,(lm8uu_holder_length*0.7+holder_separation/2)])
		belt_clamp_holes(1);

		// The big hole.
/*
		rotate(45)
		translate([0,0,lm8uu_holder_height/2])
		assign(ehole=35,ehole_r=2)
		{
			cube([ehole-2*ehole_r,ehole,lm8uu_holder_height+2],center=true);
			cube([ehole,ehole-2*ehole_r,lm8uu_holder_height+2],center=true);
			for(i=[-1,1])
			for(j=[-1,1])
			translate([i*(ehole/2-ehole_r),j*(ehole/2-ehole_r),0])
			cylinder(r=ehole_r,h=lm8uu_holder_height+2,center=true,$fn=16);
		}
*/
                    cylinder(r=21,h=lm8uu_holder_height+2,center=true,$fn=16);

		// The extruder mounting holes.
for (i=[0:1]) 
rotate(180*i)
for (hole=[-1:1])
rotate(hole*22)
translate([0,25,-1])
cylinder(r=m4_diameter/2,h=lm8uu_support_thickness*2+2,$fs=1);

		translate([0,holder_separation/2+lm8uu_holder_length-fan_support_block,0])
		translate([0,fan_support_block/2,0])
		fan_mount_holes();

		cable_tie_holes();


		for(i=[-1,1])
		translate([38,i*18.4,-1])
		cube([10,5,15],true);
	}
}

module cable_tie_holes ()
{
	// Cable tie holes.
	for (i=[-1,1])
	translate([25-lm8uu_holder_width/2+1,(holder_separation/2+lm8uu_holder_length*0.7)*i,5])
	rotate([0,-30,0])
	{
	cube([2,4,20],center=true);
	translate([0,-lm8uu_holder_length*0.4*i,0])
	cube([2,4,20],center=true);
	}

          for (i=[-1,1])
	translate([-25+lm8uu_holder_width/2-1,-(holder_separation/2+lm8uu_holder_length*0.7)*i,5])
	rotate([0,30,0])
	{
	cube([2,4,20],center=true);
	translate([0,lm8uu_holder_length*0.4*i,0])
	cube([2,4,20],center=true);
	}
}

module belt_clamp_socket(version=0)
{
	difference()
	{
		translate([0,0,belt_clamp_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_height],
				center=true);
			for(i=[-1,1])
			translate([belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_height,center=true);
			if (version==1)
			translate([belt_clamp_hole_separation/2,0,0])
			{
			difference()
			{
				translate([0,0,belt_thickness/2])
				cylinder(r=belt_clamp_width/2,h=belt_clamp_height+belt_thickness,center=true);
				translate([-belt_clamp_width/2,-belt_clamp_width/2-1,-belt_clamp_height/2-1])
				cube([belt_clamp_width/2+2,belt_clamp_width+2,belt_clamp_height+belt_thickness+2]);
			}
			}
		}
	}
}

module belt_clamp_channel()
{
	difference()
	{
		translate([0,0,belt_clamp_channel_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,
				belt_clamp_width,belt_clamp_channel_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_channel_height,center=true);

			translate([-belt_clamp_hole_separation/2,0,
				(belt_clamp_channel_height+key_d)/2-belt_clamp_channel_height/2])
			cube([key_w-0.5,key_l-0.5,belt_clamp_channel_height+key_d],true);
		}

		translate([belt_clamp_hole_separation/2,0,-1])
		rotate(360/16)
		cylinder(r=m3_diameter/2,h=belt_clamp_channel_height+2,$fn=8);


		translate([-belt_width/2,-belt_clamp_width/2-1,
			belt_clamp_channel_height-belt_thickness-tooth_height])
		cube([belt_width,belt_clamp_width+2,belt_thickness+tooth_height+1]);
	}
}

module belt_clamp_holes(version)
{
	translate([0,0,belt_clamp_height/2])
	{
		translate([belt_clamp_hole_separation/2,0,0])
		cylinder(r=m3_diameter/2,h=belt_clamp_height+2,center=true,$fn=8);

		translate([-belt_clamp_hole_separation/2,0,3/2-1-belt_clamp_height/2])
		cube([key_w,key_l,3],center=true);
	
		if(version==1)
		{
			rotate([90,0,0])
			rotate(360/16)
			cylinder(r=m3_diameter/2 ,h=belt_clamp_width+2,
				center=true,$fn=8);
	
			rotate([90,0,0]) 
			translate([0,0,belt_clamp_width/2])
			cylinder(r=m3_nut_diameter/2,h=3.4,center=true,$fn=6);

			for(i=[-2:2])
			translate([-belt_width/2,-tooth_spacing/4+i*tooth_spacing,
				belt_clamp_height-tooth_height-belt_clamp_height/2])
			cube([belt_width,tooth_spacing/2,tooth_height+1]);	
		}
		else
		{
			translate([belt_clamp_hole_separation/2,0,
				belt_clamp_height-belt_clamp_height/2-2])
			cylinder(r=m3_nut_diameter/2,h=3,$fn=6);
		}
	}
}

belt_clamp_clamp_height=tooth_height+belt_clamp_thickness*2;


module belt_clamp(version)
{
	difference()
	{
		translate([0,0,belt_clamp_clamp_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,
				belt_clamp_clamp_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_clamp_height,center=true);

			

			if (version==1)
			translate([-belt_clamp_hole_separation/2,0,
				(belt_clamp_clamp_height+key_d+belt_allowance)/2-
				belt_clamp_clamp_height/2])
			cube([key_w-0.5,key_l-0.5,belt_clamp_clamp_height+key_d+belt_allowance],
				true);
			
			if(version==1)
			translate([belt_clamp_hole_separation/2,0,-belt_clamp_clamp_height/2])
			difference()
			{
				cylinder(r=belt_clamp_width/2,h=belt_clamp_clamp_height+belt_thickness);
				translate([-belt_clamp_width-1,-belt_clamp_width/2-1,-1])
				cube([belt_clamp_width+2,belt_clamp_width+2,belt_clamp_clamp_height+belt_thickness+2]);
			}			
		}

		
		translate([belt_clamp_hole_separation/2,0,-1])
		rotate(360/16)
		cylinder(r=m3_diameter/2,h=belt_clamp_clamp_height+belt_thickness+2,$fn=8);

		if(version==1)
		{
			for(i=[-2:2])
			translate([-belt_width/2,-tooth_spacing/4+i*tooth_spacing,
				belt_clamp_clamp_height-tooth_height])
			cube([belt_width,tooth_spacing/2,tooth_height+1]);	
		}
		else
		{
			translate([-belt_clamp_width-belt_width/2-0.5,lm8uu_holder_gap/2-0.25,-1])
			cube([belt_clamp_width,belt_clamp_width,belt_clamp_clamp_height+2]);

			translate([-belt_clamp_width-belt_width/2-0.5,
				-lm8uu_holder_gap/2+0.25-belt_clamp_width,-1])
			cube([belt_clamp_width,belt_clamp_width,belt_clamp_clamp_height+2]);

			translate([-belt_clamp_width-belt_width/2-0.5-3.5,-belt_clamp_width/2,-1])
			cube([belt_clamp_width,belt_clamp_width,belt_clamp_clamp_height+2]);

			translate([belt_clamp_hole_separation/2,0,belt_clamp_clamp_height-2])
			cylinder(r=m3_nut_diameter/2,h=3,$fn=6);
		}
	}
}

module barbell (x1,x2,r1,r2,r3,r4) 
{
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	render()
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

module fan_mount() 
{
	difference()
	{
		union ()
		{
			translate([0,0,fan_support_block/4])
#			cube([fan_hole_separation+fan_support_block,fan_support_thickness,
				fan_support_block/2],center=true);
			
			for (i=[-1,1])
			translate([i*fan_hole_separation/2,0,fan_support_block/2])
			rotate([90,0,0])
			cylinder(r=fan_support_block/2,h=fan_support_block,center=true,$fn=20);
			
			translate([0,0,fan_support_block/2])
			cube([fan_hole_separation,fan_support_thickness,fan_support_block],
				center=true);
			translate([0,-6,lm8uu_support_thickness/2])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness+12,
				lm8uu_support_thickness],center=true);
		}

		translate([fan_support_block/2+25+1-lm8uu_holder_width/2,0,fan_support_block/2])
		cube([fan_support_block,fan_support_block+2,fan_support_block+2],true);
		fan_mount_holes();
	}
}

module fan_mount_holes()
{
	for(i=[-1,1])
	{
		translate([i*fan_hole_separation/2,0,fan_hole_height])
		{
			rotate([90,0,0])
			rotate(180/8)
			cylinder(r=m3_diameter/2,h=fan_support_thickness+2,
				center=true,$fn=8);
			translate([0,0,0])
			rotate([90,0,0])
			rotate([0,0,180/6])
			cylinder(r=(m3_nut_diameter-0.5)/2,h=fan_trap_width,
				center=true,$fn=6);

			translate([0,0,-(fan_hole_height+1)/2])
			cube([(m3_nut_diameter-0.5)*cos(30),fan_trap_width,
				fan_hole_height+1],center=true);

			translate([0,0,-fan_hole_height])
			cube([(m3_nut_diameter-0.5)*cos(30)+1,fan_trap_width+1,
				0.8],center=true);
		}
	}


	render()
	intersection()
	{
		translate([0,0,fan_hole_separation/2+fan_hole_height])
		rotate([-90,0,0])
		cylinder(r=fan_diameter/2,h=fan_support_thickness+2,center=true);

		color([1,0,0])
		translate([0,0,fan_support_block/2])
		cube([fan_hole_separation+fan_support_block+2,fan_support_thickness+2,
			fan_support_block+2],center=true);
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

ram_height=belt_width;
ram_length=1.5;
ram_lip=0.5;

module ram() 
{ 
	ram_radius=(belt_clamp_height-tooth_height)/2;
	difference()
	{
		union()
		{
			cylinder(r1=ram_radius+ram_lip,r2=ram_radius-ram_lip,h=2*ram_lip,$fn=32);

			translate([0,0,ram_height])
			cylinder(r1=ram_radius-ram_lip,r2=ram_radius+ram_lip,h=2*ram_lip,$fn=32);

			translate([0,0,ram_lip])
			cylinder(r=ram_radius,h=ram_height,$fn=32);
			translate([0,-m3_nut_diameter/2,0])
			cube([ram_length+0.1,m3_nut_diameter,ram_height+2*ram_lip]);
		}
		translate([ram_length,-(ram_radius+ram_lip+1),-1])
		cube([ram_radius*2+2*ram_lip+2,ram_radius*2+2*ram_lip+2,ram_height+2+2*ram_lip]);
		translate([-0.5,0,ram_height/2+ram_lip])
		rotate([0,90,0])
		rotate([0,0,180/8])
		cylinder(r=m3_diameter/2,h=2+ram_length,$fn=8);
	}
}
