include <wing_lib.scad>;

for(x=[0,55])
  translate([x,0]) translate(gSideOffset) Side();

