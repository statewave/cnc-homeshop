include <fence_lib.scad>;
include <../../_lib/repeat.scad>;

translate([gSledB+gSledA+23,0]) DiagonalFit([gSledB, gSledA+40]) Angle();
