include <../../_lib/fillets.scad>;
// TODO: Make the right-angle chevron shape a bit more rounded using beziers
//include <../../_lib/bezier.scad>;

gRealBitSize = 4.0;
gMaterialThick = 12;
gCutDepth = -(gMaterialThick+0.2);
gBitSize = 4.1;
gLength = 280;
gSide = 130;
gBulk = 30;
gRound = 10;
gHole = 4.1;
gThroughHole = 4.2;
gHoleLocs = [[gBulk/2,(gBulk+gSide)*0.3],
             [gBulk/2,(gBulk+gSide)*0.8]];


module Corner() {
  difference() {
    offset(r=gRound,$fn=64) offset(delta=-gRound) square([gSide+gBulk, gSide+gBulk]);
    translate([gBulk,gBulk]) SpikeBox([gSide+gBulk, gSide+gBulk],gBitSize);
  }
}

module CornerHoles(d=gHole) {
  for(p=gHoleLocs)
    translate(p) circle(d=d,$fn=32);
}


module Outline() {
  Corner();
  translate([gBulk+gBitSize,gBulk+gBitSize])  rotate([0,0,-45]) Top();
}

module Holes() {
  CornerHoles();
  translate([gBulk+gBitSize,gBulk+gBitSize])  rotate([0,0,-45]) CornerHoles();
}

module Top() {
  difference() {
    hull() {
      Corner();
      rotate([0,0,45]) translate([gLength,0]) circle(r=gRound,$fn=32);
    }
    rotate([0,0,-45]) square([1000,1000]);
  }
}
module TopHoles() {
  CornerHoles(gThroughHole);
}

module Demo() {
  linear_extrude(height=gMaterialThick) difference() {
    Corner();
    CornerHoles();
  }
  translate([0,0,gMaterialThick+1]) linear_extrude(height=gMaterialThick)
    difference() {
    Top();
    TopHoles();
  }
}
