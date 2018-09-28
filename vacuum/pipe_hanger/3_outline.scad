include <pipe_hanger_lib.scad>;

Many() Outline();
translate([75,h+gBitSize]) Mounts();
translate([pair_bounding_box[0],pitch+h+gBitSize]) rotate([0,0,180])
  translate([75,0]) Mounts();
