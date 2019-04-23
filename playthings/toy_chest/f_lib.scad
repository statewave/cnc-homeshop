// This is the alignment jig for putting together the lid.
include <toy_chest_lib.scad>;

LX = L - gMaterialThick * 2;
WX = W - gMaterialThick * 2;

module Total() {
  square([L, W]);
}

module Rabbet() {
  difference() {
    translate([gMaterialThick,gMaterialThick]) square([LX, WX]);
    translate([L/2-gMaterialThick/2,-1]) square([gMaterialThick, W+2]);
  }
}

module Path() {
  difference() {
    offset(delta=gBitSize) children();
    children();
  }
}

module Demo() {
  difference() {
    linear_extrude(height=gMaterialThick) Total();
    translate([0,0,6]) linear_extrude(height=gMaterialThick) {
      Path() Rabbet();
      Path() offset(delta=gBitSize*0.8) Rabbet();
      Path() offset(delta=gBitSize*0.8*2) Rabbet();
      Path() offset(delta=gBitSize*0.8*3) Rabbet();
      Path() offset(delta=gBitSize*0.8*4) Rabbet();
    }
  }
}
