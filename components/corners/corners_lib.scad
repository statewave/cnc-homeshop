include <../../_lib/repeat.scad>;

gMaterialThickness = 12.0;
gCutDepth = -gMaterialThickness - 0.2;
gPocketDepth = 4;
gBitSize = 6.35;

gSquare = [70,70];
gWidth = 28;
gHoleDia = 4.5;

module Corner() {
  difference() {
    offset(r=10,$fn=128) offset(delta=-10) square(gSquare);
    translate([gWidth,gWidth]) square(gSquare);
  }
}

module Holes() {
  translate([gSquare[0]*0.65,gWidth/2]) circle(d=gHoleDia,$fn=32);
  translate([gWidth/2,gSquare[1]*0.65]) circle(d=gHoleDia,$fn=32);
}

module Pair() {
  DiagonalFit([gSquare[0], gSquare[1] + gBitSize * 1.2 + gWidth])
    children();
}

module Demo() {
  difference() {
    linear_extrude(height=gMaterialThickness, convexity=4)
      Pair() Corner();
    translate([0,0,gMaterialThickness-gPocketDepth])
      linear_extrude(height=gMaterialThickness, convexity=4)
      Pair() Holes();
  }
}
