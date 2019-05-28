include <circle_jig_lib.scad>;

for(i=[0:6])
  translate([gBlockWidth/2+(gBlockWidth+gBitSize*3)*i,gBlockWidth/2])
    BlockOutline();
