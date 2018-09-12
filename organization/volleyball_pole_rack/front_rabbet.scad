include <volleyball_pole_rack.scad>;

difference() {
  translate([-inner_height/2-5,-5]) square([inner_height+10,pole_spacing+10]);
  FrontRabbets();
}
