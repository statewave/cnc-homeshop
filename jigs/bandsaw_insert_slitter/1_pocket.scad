include <bandsaw_insert_slitter_lib.scad>;

difference() {
  offset(delta=10) Pocket();
  Pocket();
}
