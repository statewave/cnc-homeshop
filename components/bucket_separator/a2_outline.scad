include <bucket_lib.scad>;

translate(gOffset) Outline(true);
translate(gOffset) translate([0,gFrameOD+25]) Outline(false);
translate([gFrameOD+10,0]) StickoutPlate();
