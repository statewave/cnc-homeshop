include <volleyball_pole_rack.scad>;
difference() {
  translate([-5,-5]) square([400,600]);
  translate([0,170+30]) rotate([0,0,-90]) Rabbets();
  translate([160,170+70+30]) rotate([0,0,90]) Rabbets();
  translate([170,180]) rotate([0,0,-90]) BackRabbets();
  translate([195,370]) FrontRabbets();
}
