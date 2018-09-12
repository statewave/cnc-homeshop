include <volleyball_pole_rack.scad>;

difference() {
  linear_extrude(height=19) Profile();
  translate([0,0,16]) linear_extrude(height=10,convexity=10) offset(r=2) offset(delta=-2) Rabbets();
}

translate([0,150]) Spinner();
