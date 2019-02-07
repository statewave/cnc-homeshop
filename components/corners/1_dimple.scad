include <corners_lib.scad>;

difference() {
  offset(delta=10) hull() Pair() Holes();
  Pair() Holes();
}
