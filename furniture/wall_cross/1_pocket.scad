include <cross_lib.scad>;

difference() {
  offset(delta=10) hull() Pocket();
  Pocket();
}
