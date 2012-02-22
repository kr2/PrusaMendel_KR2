// PRUSA Mendel  
// X-end with idler mount
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>
corection = 1.17; 

/**
 * @id x-end-idler
 * @name X end idler
 * @category Printed
 * @using 1 m8spring
 * @using 3 m8nut
 * @using 3 m8washer
 * @using 3 m8washer-big
 * @using 2 m8x30
 */ 
use <x-end.scad>
use <teardrop.scad>

wall_thickness=5;

module xendidler(closed_end=true,curved_sides=true,luu_version=false)
{
	difference()
	{
		union()
		{
			xend(closed_end=closed_end,curved_sides=curved_sides,luu_version=luu_version);
//			import_stl("x-end.stl");

			translate([-25-15.8/2+24.8/2,-21.5,25.3+12.5]) 
			cube([24.8,7,4.4],center=true);

			translate([-25-15.8/2+24/2,12.5,25.3+12.5]) 
			cube([24,5,4.4],center=true);

			difference ()
			{
				translate([-25-15.8/2+wall_thickness/2,-5,15.8/2+(40-15.8/2)/2]) 
				cube([wall_thickness,40,40-15.8+15.8/2],center=true);

				translate([-25,-26,15.8/2])
				rotate(90) 
				teardropcentering(6,42);
			}
		}

		translate([-25-15.8/2+wall_thickness/2, -6, 28-3-4.7+12.5]) rotate([0,90,0]) 
		cylinder(h=wall_thickness+2,r=m8_diameter/2,$fn=9,center=true);

		xendcorners(5,5,5,5,0);

//		if (!closed_end)
//		for (i=[-1,1])
//		translate([15*i,10,15.8/2+0.75]) 
//		{
//			rotate([90,0,0])
//			rotate([0,0,180/6])
//			cylinder(r=m3_diameter/2-0.2,h=20,center=true,$fn=6);
//
//			rotate([90,0,0])
//			rotate([0,0,180/6])
//			cylinder(r=(m3_nut_diameter-0.5)/2,h=3,center=true,$fn=6);
//
//			color([1,0,0])
//			translate([0,0,(10+1)/2])
//			cube([(m3_nut_diameter-0.5)*cos(30),3,10+1],center=true);
//		}
	}
}

xendidler(closed_end=false,curved_sides=true);
