include <pipe_hanger_lib.scad>;

translate([0,-bottom_pos[1]+bottom_r]) Outline();
translate([270,0]) rotate([0,0,180]) Outline();

