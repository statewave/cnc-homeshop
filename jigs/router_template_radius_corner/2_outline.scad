include <corner_lib.scad>;

Outline(25.4/2);
translate([gSquare+20,0]) Outline(25.4/4);
translate([0,gSquare+20]) Outline(25.4*5/8);
translate([gSquare+20,gSquare+20]) Outline(25.4*3/8);
