include <outside_caliper_lib.scad>;

difference() {
  offset(delta=10) hull() Repeat() Pocket();
  Repeat() Pocket();
}
