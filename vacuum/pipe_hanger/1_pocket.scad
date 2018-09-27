include <pipe_hanger_lib.scad>;

difference() {
  offset(delta=5) Pocket();
  Pocket();
}
