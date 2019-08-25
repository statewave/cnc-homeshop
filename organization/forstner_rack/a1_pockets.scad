include <forstner_rack_lib.scad>;

difference() {
  hull() offset(delta=10) PlatePockets();
  PlatePockets();
}
