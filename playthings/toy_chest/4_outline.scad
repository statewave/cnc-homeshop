include <toy_chest_lib.scad>;

for(y=[0,H+gBitSize*3]) translate([0,y]) Side();

translate([W+gBitSize*3, 0]) Front();
translate([W+gBitSize*3, H+gBitSize*3]) Back();

translate([0,H*2+gBitSize*6]) Bottom();
