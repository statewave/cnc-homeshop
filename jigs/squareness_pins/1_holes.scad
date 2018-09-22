include <squareness_lib.scad>;

difference() {
  offset(delta=10) hull() PinHoles();
  PinHoles();
}
