include <circle_jig_lib.scad>;

difference() {
  offset(delta=10) Slot();
  Slot();
}
