include <corner_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}
module M() {
  Pocket();
  translate([gSquare+20,0]) Pocket();
  translate([0,gSquare+20]) Pocket();
  translate([gSquare+20,gSquare+20]) Pocket();
}
