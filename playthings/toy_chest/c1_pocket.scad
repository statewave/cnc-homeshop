include <toy_chest_lib.scad>;

LidSide(false);
translate([W,0]) LidSide(false);
translate([W*1.5,W*0.5+20]) rotate([0,0,180]) LidSide(false);

