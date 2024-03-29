// PRUSA Mendel  
// Default metric sizes
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

// DONT CHANGE THIS FILE! ALTER VALUES IN CONFIGURATION.SCAD INSTEAD

// RODS

threaded_rod_diameter = 8.2;
threaded_rod_diameter_horizontal = 8.2;
smooth_bar_diameter = 8;
smooth_bar_diameter_horizontal = 8.5;

// Nuts and bolts

m8_diameter = 8.9;
m8_nut_diameter = 15.25;

m4_diameter = 4.5;
m4_nut_diameter = 9;

m3_diameter = 3.6;
m3_nut_diameter = 6.45;
m3_nut_heigth = 2.3;
m3_nut_wallDist = cos(30)*m3_nut_diameter;
m3_nut_diameter_horizontal = 6.1;

// Bushing holder

bushing_core_diameter = smooth_bar_diameter;
bushing_material_thickness = 1;

// Motors

motor_shaft = 5.5;