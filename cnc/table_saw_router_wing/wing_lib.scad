include <../../_lib/fillets.scad>;
include <../../_lib/edge_tabs.scad>;
include <../../_lib/bolt_hex.scad>;

gMaterialThickness = 18;
gCutDepth = -gMaterialThickness-0.5;
gBitSize = 6.35;
gSmallBitSize = 3.175;
gPocketDepth = 9;

gMountingCircle = 118;
gMountingHole = 5.5;
gMountingSquare = 98;

gTopSize = [305,27*25.4];
gHeight = 50;

gYTabSpacing = 120;
gXTabSpacing = 105;
gTabWidth = 40;

gTopOffset = [gTopSize[0]/2,gTopSize[1]/2];
gSideOffset = [0,gTopSize[1]/2];
gSideTabs = [
  [LEFT_EDGE, -gTopSize[1]/2],
  [CTAB, -2*gYTabSpacing, gTabWidth],
  [CTAB, -1*gYTabSpacing, gTabWidth],
  [CTAB, 0, gTabWidth],
  [CTAB, 1*gYTabSpacing, gTabWidth],
  [CTAB, 2*gYTabSpacing, gTabWidth],
  [RIGHT_EDGE, gTopSize[1]/2]];
gSideDeepTabs = [
  [CTAB, -gTopSize[1]/2+gMaterialThickness/2-gBitSize/2, gMaterialThickness+gBitSize],
  [CTAB, gYTabSpacing*-1.5, gMaterialThickness],
  [CTAB, gYTabSpacing*1.5, gMaterialThickness],
  [CTAB, gTopSize[1]/2-gMaterialThickness/2+gBitSize/2, gMaterialThickness+gBitSize],
];
gShortSideOffset = [-gTopSize[0]/2,0];
gShortSideTabs = [
  [LEFT_EDGE, -gTopSize[0]/2],
  [CTAB, -1*gXTabSpacing, gTabWidth],
  [CTAB, 0, gTabWidth],
  [CTAB, 1*gXTabSpacing, gTabWidth],
  [RIGHT_EDGE, gTopSize[0]/2]];
gStiffenerOffset = [-gTopSize[0]/2,0];
gStiffenerTabs = [
  [LEFT_EDGE, -gTopSize[0]/2],
  [CTAB, -0.5*gXTabSpacing, gTabWidth],
  [CTAB, 0.5*gXTabSpacing, gTabWidth],
  [RIGHT_EDGE, gTopSize[0]/2]];

gFenceBolt = [100,100];

module PCMountingHoles() {
  for(t=[0,120,-120]) rotate([0,0,t+90])
    translate([gMountingCircle/2,0]) circle(d=gMountingHole,$fn=32);
}

module BoschMountingHoles() {
  for(x_scale=[1,-1], y_scale=[1,-1]) scale([x_scale,y_scale])
    translate([gMountingSquare/2,gMountingSquare/2]) circle(d=gMountingHole,$fn=32);
}

module Top() {
  // mind you, this cuts upside-down
  difference() {
    square(gTopSize, center=true);
    // min d=55 for collet wrench
    circle(d=55,$fn=128);
  }
}

module TopHoles() {
  PCMountingHoles();
  for(y_scale=[1,-1]) scale([1, y_scale])
    translate(gFenceBolt) circle(d=five_sixteenths_inch[0], $fn=32);
}

module TopPocket() {
  // Long side
  for(x_scale=[1,-1]) scale([x_scale,1])
    translate([-gTopSize[0]/2,0])
    TabsToLeft(gTopSize) EdgeTabF(gBitSize, gMaterialThickness, gSideTabs);
  // Short side
  for(y_scale=[1,-1]) scale([1,y_scale])
    translate([0,-gTopSize[1]/2])
    EdgeTabF(gBitSize, gMaterialThickness, gShortSideTabs);
  // Stiffeners
  for(y_scale=[1,-1]) scale([1,y_scale])
    translate([0,gYTabSpacing*1.5-gMaterialThickness/2])
    MiddleSlots(gBitSize, gMaterialThickness, gStiffenerTabs);
}

module TopSmallPocket() {
  // Fence bolts
  for(y_scale=[1,-1]) scale([1,y_scale])
    translate(gFenceBolt) OvercutHex(five_sixteenths_inch[1], gSmallBitSize);
}


module TopDemo() {
  difference() {
    linear_extrude(height=gMaterialThickness,convexity=6) difference() {
      Top();
      TopHoles();
    }
    translate([0,0,gMaterialThickness-gPocketDepth])
      linear_extrude(height=gMaterialThickness,convexity=12) TopPocket();
    translate([0,0,gMaterialThickness-gPocketDepth])
      linear_extrude(height=gMaterialThickness,convexity=12) TopSmallPocket();
  }
}

module Side() {
  local_pocket_depth = gPocketDepth-1;
  difference() {
    translate([0,-gTopSize[1]/2])
      square([gHeight-gMaterialThickness+local_pocket_depth, gTopSize[1]]);
    TabsToLeft(gTopSize) EdgeTabM(gBitSize, local_pocket_depth, gSideTabs, 1);
    TabsToLeft(gTopSize) EdgeTabF(gBitSize, local_pocket_depth+12, gSideDeepTabs);
  }
}

module SideHoles() {}
module SidePocket() {}

module SideDemo() {
  difference() {
    linear_extrude(height=gMaterialThickness,convexity=6) difference() {
      Side();
      SideHoles();
    }
    translate([0,0,gMaterialThickness-gPocketDepth])
      linear_extrude(height=gMaterialThickness,convexity=12) SidePocket();
  }
}

module Demo() {
  TopDemo();
  translate([gTopSize[0]*0.5+12,0]) SideDemo();
  translate([gTopSize[0]*0.5+16+gHeight,0]) SideDemo();
  translate([0,gTopSize[1]*-0.5-50]) ShortEdgeDemo();
  translate([0,gTopSize[1]*-0.5-110]) StiffenerDemo();
}

module ShortEdgeDemo() {
  linear_extrude(height=gMaterialThickness) ShortEdge();
}

module ShortEdge() {
  difference() {
    translate([-gTopSize[0]/2, 0])
      square([gTopSize[0], gHeight-gMaterialThickness+gPocketDepth-1]);
    EdgeTabM(gBitSize, gPocketDepth, gShortSideTabs, 1);
    for(x_scale=[1,-1]) scale([x_scale,1]) {
      // Corner
      translate([gTopSize[0]/2-gMaterialThickness/2+3,(gHeight-gMaterialThickness-12)/2+gPocketDepth+12])
        SpikeBoxT([gMaterialThickness+6,(gHeight-gMaterialThickness-12)], gBitSize, center=true);
    }
  }
}

module StiffenerDemo() {
  linear_extrude(height=gMaterialThickness) Stiffener();
}

module Stiffener() {
  difference() {
    translate([-gTopSize[0]/2, 0])
      square([gTopSize[0], gHeight-gMaterialThickness+gPocketDepth-1]);
    EdgeTabM(gBitSize, gPocketDepth, gStiffenerTabs, 1);
    for(x_scale=[1,-1]) scale([x_scale,1]) {
      // Corner
      translate([gTopSize[0]/2-gMaterialThickness/2+3,(gHeight-gMaterialThickness-12)/2+gPocketDepth+12])
        SpikeBoxT([gMaterialThickness+6,(gHeight-gMaterialThickness-12)], gBitSize, center=true);
    }
  }
}
