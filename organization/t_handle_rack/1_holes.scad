include <rack_lib.scad>;

translate(Zero) difference() {
  offset(delta=10) hull() RackHoles(TorxSet, 6);
  RackHoles(TorxSet, 6);
}
