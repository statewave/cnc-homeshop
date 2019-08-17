include <../../_lib/fillets.scad>;
include <../../_lib/edge_tabs.scad>;

gMaterialThick = 12;
gCutDepth = -gMaterialThick-0.2;
gBitSize = 6.35;
gPocketDepth = 6;

gHoleDia = 77;

gWidth = 250;
gDepth = 150;
gHeight = 64;

gCrossX = 70;
gCrossY = gCrossX/2+gMaterialThick/2; // same dist from middle

// Intentionally different to make sure I didn't mess up; these should be
// documented with a diagram.
// [0] = 7 = width of pocket
// [1] = 8 = depth of pocket
gTabParams = [7, 8];
gPocket1Depth = -(gMaterialThick-gTabParams[0]);
gPocket2Depth = -gTabParams[1];

// I keep making boxes.  There should be a macro for this.


module Demo() {
  translate([0,-gCrossX/2,0]) {
    DemoCrossX();
    translate([0,gCrossX/2+gMaterialThick/2, 2]) rotate([90,0,0]) DemoCrossY();
  }

  for(y_scale=[1,-1]) scale([1,y_scale,1])
    translate([0,gMaterialThick-gDepth/2,gMaterialThick-gHeight])
      rotate([90,0,0]) DemoFront();

  translate([-25,0,0])
  translate([gMaterialThick,gDepth/2,gMaterialThick-gHeight])
    rotate([0,0,-90]) rotate([90,0,0]) DemoSide();
}

module DemoCrossX() {
  linear_extrude(height=gMaterialThick) CrossX();
}

module DemoCrossY() {
  linear_extrude(height=gMaterialThick) CrossY();
}

gCrossTabs = [
  [LEFT_EDGE, -8],
  [CTAB, 50, 40],
  [CTAB, gWidth/2, 40],
  [CTAB, gWidth-50, 40],
  [RIGHT_EDGE, gWidth+8],
];

module CrossX() {
  difference() {
    translate([-8,0]) square([gWidth + 16, gCrossX]);
    translate([0,-gMaterialThick+8])
      SpikeBox([gMaterialThick,gMaterialThick], gBitSize);
    translate([gWidth-gMaterialThick,-gMaterialThick+8])
      SpikeBox([gMaterialThick,gMaterialThick], gBitSize);
    translate([0,(gCrossX-gMaterialThick)/2])
      MiddleSlots(gBitSize, gMaterialThick, gCrossTabs);
  }
}

module CrossY() {
  difference() {
    translate([-8,0]) square([gWidth + 16, gCrossY]);
    EdgeTabM(gBitSize, gMaterialThick, gCrossTabs);
  }
}

module PlateA() {
  translate([8,0]) CrossX();
  translate([8,gCrossX+16]) CrossY();
}

module DemoFront() {
  difference() {
    linear_extrude(height=gMaterialThick) Front();
    translate([0,0,gMaterialThick-gTabParams[1]]) linear_extrude(height=gMaterialThick) FrontPocket();
  }
}

module Front() {
  square([gWidth, gHeight]);
}

module FrontPocket() {
  TabsToRight([gWidth, gHeight])
    translate([0,gMaterialThick-gTabParams[0]])
    MiddleSlots(gBitSize, gTabParams[0], gSideTab);
  TabsToLeft([gWidth, gHeight])
    translate([0,gMaterialThick-gTabParams[0]])
    MiddleSlots(gBitSize, gTabParams[0], gSideTab);
}

module DemoSide() {
  difference() {
    linear_extrude(height=gMaterialThick, convexity=6) Side();
    translate([0,0,gTabParams[0]])
      linear_extrude(height=gMaterialThick, convexity=6) SidePocket();
  }
}

gSideTab = [
  [LEFT_EDGE, 0],
  [CTAB, gHeight/2, 30],
  [RIGHT_EDGE, gHeight+10],
];

module Side() {
  t = gMaterialThick- gTabParams[1] - 0.5;
  difference() {
    union() {
      translate([t,0]) square([gDepth-t*2, gHeight]);
      offset(r=5,$fn=32) offset(delta=-5)
        translate([gMaterialThick,gHeight-20]) square([gDepth/2-gCrossX/2,30]);
    }
    translate([gDepth/2-gCrossX/2,gHeight-gMaterialThick+0.01])
      SpikeBox([gCrossX-8,gMaterialThick], gBitSize);
    TabsToLeft([gDepth, gHeight])
      EdgeTabM(gBitSize, gMaterialThick, gSideTab);
    TabsToRight([gDepth, gHeight])
      EdgeTabM(gBitSize, gMaterialThick, gSideTab);
  }
}

module SidePocket() {
  square([gMaterialThick, gHeight]);
  translate([gDepth-gMaterialThick,0])
    square([gMaterialThick, gHeight]);
}
