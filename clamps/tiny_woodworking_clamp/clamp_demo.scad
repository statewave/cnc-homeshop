include <clamp_lib.scad>;

difference() {
  linear_extrude(height=12,convexity=12) difference() {
    ClampSide();
    ClampSideThroughHole();
  }
  translate([0,0,6]) linear_extrude(height=6.1,convexity=4)
    offset(r=2,$fn=32) offset(delta=-2)
    ClampSidePocket();
}
