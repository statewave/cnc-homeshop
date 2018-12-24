include <outside_caliper_lib.scad>;

difference() {
  offset(delta=10) hull() Repeat() Hole();
  Repeat() Hole();
}
