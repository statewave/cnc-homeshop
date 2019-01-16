include <port_lib.scad>;

difference() {
  offset(delta=10) hull() Holes();
  Holes();
}
