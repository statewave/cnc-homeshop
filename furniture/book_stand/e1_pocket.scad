include <book_stand_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}

module M() {
  h = gPaverHeight+gMaterialThick*2;
  translate([h,0,0]) rotate([0,0,90]) SidePockets();
  translate([h*2+gBitSize*3,0,0]) rotate([0,0,90]) SidePockets();
  translate([h*3+gBitSize*6,0,0]) rotate([0,0,90]) BackPockets();
  translate([h*4+gBitSize*9,0,0]) rotate([0,0,90]) BackPockets();
}
