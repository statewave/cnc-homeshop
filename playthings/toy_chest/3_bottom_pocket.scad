include <toy_chest_lib.scad>;

translate([0,H*2+gBitSize*6])
difference() {
  offset(delta=gBotPocketDepth+gBitSize/2) hull() Bottom2();
  Bottom2();
}


