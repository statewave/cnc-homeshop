include <pipe_hanger_lib.scad>;

rotate([90,0,0]) difference() {
  linear_extrude(height=12) Outline();
  translate([0,0,11]) linear_extrude(height=12, convexity=6)
    offset(r=gBitSize/2) offset(delta=-gBitSize/2) Pocket();
}

#rotate([90,0,0]) translate([0,0,-100]) linear_extrude(height=200) translate(pipe_pos) circle(r=pipe_r,$fn=256);
