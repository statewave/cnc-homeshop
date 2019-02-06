include <wing_lib.scad>;

difference() {
  offset(delta=10) hull() PCMountingHoles();
  PCMountingHoles();
}
