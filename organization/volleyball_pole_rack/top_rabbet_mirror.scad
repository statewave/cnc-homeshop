include <volleyball_pole_rack.scad>;
translate([-5,-w/2-5]) square([0.1,0,1]);
translate([w/2-10,0]) scale([-1,1]) rotate([0,0,-90]) difference() {
  translate([-(w+4)/2,-5]) square([w+4,h+10]);
  Rabbets();
}
