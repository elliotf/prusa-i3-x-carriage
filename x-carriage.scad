// PRUSA iteration3
// X carriage
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Separación a 30mm los agujeros de montaje

da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;
da12 = 1 / cos(180 / 12) / 2;

include <configuration.scad>
use <bearing.scad>

//separación de los agujeros para extrusor (24mm o 30mm)
disth = 30;
//disth = 24;

//desplazamiento para centrar la correa (de polea de 20mm a una de 12mm son 4mm de diferencia en radio)
desp = -4;

//Movimiento de los agujeros de montaje para pasar por encima de la correa
pos = 11;


module heat_shield() {
  difference() {
    translate([-33/2,15,-6/2]) cube([60,65,6],center=true);
    translate([-16.5+disth/2,24+pos,-10]) cylinder(r=da6*3, h=50, $fn=8);
    translate([-16.5-disth/2,24+pos,-10]) cylinder(r=da6*3, h=50, $fn=8);
  }
}
% heat_shield();

module x_carriage_base(){
 // Small bearing holder
 translate([-33/2,+2,0]) rotate([0,0,90]) horizontal_bearing_base(1);
 //hull(){
     // Long bearing holder
     translate([-33/2,x_rod_distance+2,0]) rotate([0,0,90]) horizontal_bearing_base(2);
     // Belt holder base
     translate([-36-4,20,0]) cube([39+8,16-desp,17]);
   // }
     // Base plate
 translate([-33,-11.5,0]) cube([33,68,7+1.5]);

}

module x_carriage_beltcut(){
 // Cut in the middle for belt
 translate([-2.5-16.5+1,19+desp,8]) cube([4.5,13,15]);

 // Cut clearing space for the belt
 translate([-39,5,7]) cube([50,15,15]);

 // Belt slit
 translate([-50,21.5+10+desp,8]) cube([67,1,15]);

 // Smooth entrance
 //translate([-56,21.5+10+desp,14]) rotate([45,0,0]) cube([67,15,15]);

 // Teeth cuts
 for ( i = [0 : 33] ){
   translate([25.8-i*belt_tooth_distance,21.5+8+desp,6+1.5]) cube([belt_tooth_distance*belt_tooth_ratio,3,15]);
 }
}

module x_carriage_holes(){
 // Small bearing holder holes cutter
  translate([-33/2,2,0]) rotate([0,0,90]) horizontal_bearing_holes(1);
 // Long bearing holder holes cutter
  translate([-33/2,x_rod_distance+2,0]) rotate([0,0,90]) horizontal_bearing_holes(2);
  // Extruder mounting holes
  translate([-16.5+disth/2,24+pos,-1])cylinder(r=1.7, h=20, $fn=32);
  translate([-16.5+disth/2,24+pos,10])cylinder(r=3.3, h=20, $fn=6); 
  translate([-16.5-disth/2,24+pos,-1])cylinder(r=1.7, h=20, $fn=32);
  translate([-16.5-disth/2,24+pos,10])cylinder(r=3.3, h=20, $fn=6); 	
}

module x_carriage_fancy(){
 // Top right corner
 translate([13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,45]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom right corner
 translate([0,5,0]) translate([0,-11.5,-1]) rotate([0,0,-45]) translate([0,-15,0]) cube([30,30,20]);
 // Bottom ĺeft corner
 translate([-33,5,0]) translate([0,-11.5,-1]) rotate([0,0,-135]) translate([0,-15,0]) cube([30,30,20]);
 // Top left corner
 translate([-33-13.5,-5,0]) translate([0,45+11.5,-1]) rotate([0,0,135]) translate([0,-15,0]) cube([30,30,20]);	
}

module x_carriage_slimmed() {
  translate([-2,-20,-1]) cube([20,48.5,20]);
  translate([-2-20-29,-20,-1]) cube([20,48.5,20]);

  translate([12,26.5,0]) rotate([0,0,37]) cube([20,20,40],center=true);
  translate([12-29-28,26.5,0]) rotate([0,0,-37]) cube([20,20,40],center=true);
}

// Final part
module x_carriage(){
 difference(){
  x_carriage_base();
  x_carriage_beltcut();
  x_carriage_holes();
  x_carriage_fancy();
  x_carriage_slimmed();
 }
}

intersection() {
  //translate([-20,25,10]) cube([40,10,8],center=true);
  //x_carriage();
}
x_carriage();
