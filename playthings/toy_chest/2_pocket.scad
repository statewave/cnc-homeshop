include <toy_chest_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}
module M() {
  for(y=[0,H+gBitSize*3]) translate([0,y]) SidePocket();
  translate([W+gBitSize*3, 0]) BackPocket();
  translate([W+gBitSize*3, H+gBitSize*3]) BackPocket();
}



