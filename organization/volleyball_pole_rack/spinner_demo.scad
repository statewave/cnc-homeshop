include <volleyball_pole_rack.scad>;

difference() {
  linear_extrude(height=18) Spinner();
  #translate([0,0,18-3]) linear_extrude(height=10,convexity=10) offset(r=2,$fn=32) offset(delta=-2) SpinnerPocket();
}
