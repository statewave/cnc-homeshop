include <pipe_hanger_lib.scad>;

rotate([90,0,0]) linear_extrude(height=12) Outline();
#rotate([90,0,0]) translate([0,0,-100]) linear_extrude(height=200) translate(pipe_pos) circle(r=pipe_r,$fn=256);
