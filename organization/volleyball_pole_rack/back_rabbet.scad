include <volleyball_pole_rack.scad>;

translate([-6,-15*25.4/2]) square([0.1,0.1]);
rotate([0,0,-90]) difference() {
  translate([-back_width/2,-6]) square([back_width,inner_height+12]);
  BackRabbets();
}

