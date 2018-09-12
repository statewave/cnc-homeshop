include <volleyball_pole_rack.scad>;

difference() {
  linear_extrude(height=18) Back();
  #translate([0,0,17-6]) linear_extrude(height=10,convexity=10) offset(r=2) offset(delta=-2) BackRabbets();
}
