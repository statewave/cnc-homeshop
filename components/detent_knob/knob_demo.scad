include <knob_lib.scad>;

linear_extrude(height=gMaterialThick) difference() {
  Outline();
  Hole();
}
