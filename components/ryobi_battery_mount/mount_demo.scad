include <mount_lib.scad>;

difference() {
  linear_extrude(height=18, convexity=4) Layer1();
  translate([0,0,18-Layer1Pocket1Depth])
    linear_extrude(height=18) Layer1Pocket1();
  translate([0,0,18-Layer1Pocket2Depth])
    linear_extrude(height=18) Layer1Pocket2();
}

translate([100,0]) linear_extrude(height=18) Layer2();
