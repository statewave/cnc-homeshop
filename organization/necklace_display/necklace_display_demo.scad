include <necklace_display_lib.scad>;

rotate([60,0,0]) linear_extrude(height=12) Holder(8,12);
translate([0,-20,-24]) linear_extrude(height=12) Base(8);
translate([0,-20,-12]) linear_extrude(height=12) Base2(8);
