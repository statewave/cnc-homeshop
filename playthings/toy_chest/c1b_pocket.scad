include <production_lib.scad>;

for(i=[0:5])
  translate([W*i,0]) translate([-(L*2+W*2+gBitSize*8),0]) LidSides(1);
