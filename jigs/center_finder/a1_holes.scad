include <center_finder_lib.scad>;

difference() {
  offset(delta=10) hull() Holes();
  Holes();
}
