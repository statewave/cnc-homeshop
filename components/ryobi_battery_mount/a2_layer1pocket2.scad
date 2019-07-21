include <mount_lib.scad>;

difference() {
  offset(delta=10) Layer1Pocket2();
  Layer1Pocket2();
}
