include <volleyball_pole_rack.scad>;
translate([-5,-back_width/2-5]) square([0.1,0,1]);
rotate([0,0,-90]) difference() {
  translate([-(back_width+10)/2,-5]) square([back_width+10,h+10]);
  Rabbets();
}
