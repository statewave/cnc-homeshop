include <mount_lib.scad>;

difference() {
  offset(delta=10) Layer1Pocket1();
  Layer1Pocket1();
}
