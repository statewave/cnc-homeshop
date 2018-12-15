include <bandsaw_insert_slitter_lib.scad>;

translate(gZeroOffset) difference() {
  offset(delta=10) Pocket();
  Pocket();
}
