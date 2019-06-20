include <../../_lib/fillets.scad>;
include <../../_lib/edge_tabs.scad>;

gBitSize = 6.35;
gMaterialThick = 12.2;
gCutDepth = -gMaterialThick - 0.2;
// My angle aluminum is 1.62mm thick, but this lines up with one of the plywood
// layers and causes splintering.  This can be a little deeper...
gPocketDepth = 2.2;
gPocketWidth = 19.3-1.62;

gSquare = 60;
gPocketStart = 25;

// Cammill doesn't support a lead-out, and tends to end at the lower-left; this
// puts the radius at the upper-right so we don't need tabs and it breaks free
// on a non-critical corner.
module Outline(r) {
  hull() {
    translate([gSquare-r,gSquare-r]) circle(r=r,$fn=256);
    difference() {
      square([gSquare,gSquare]);
      translate([gSquare-r,gSquare-r]) square([r,r]);
    }
  }
}

module Pocket() {
  TabsToTop([gSquare,gSquare]) OnePocket();
  TabsToRight([gSquare,gSquare]) OnePocket();
}

module OnePocket() {
  x = gPocketStart;
  w = gSquare - gPocketStart;
  translate([-gBitSize,-gBitSize]) SpikeBox([w+gBitSize,gPocketWidth+gBitSize], gBitSize);
}

module Demo(r=25.4/2) {
  difference() {
    linear_extrude(height=gMaterialThick) Outline(r);
    translate([0,0,gMaterialThick-gPocketDepth])
      linear_extrude(height=gMaterialThick) Pocket();
  }
}
