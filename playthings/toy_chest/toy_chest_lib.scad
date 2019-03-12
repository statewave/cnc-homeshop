include <../../_lib/edge_tabs.scad>;

gMaterialThick = 12.0;
gCutDepth = -gMaterialThick - 0.2;
gBitSize = 4.0;
L=400;
W=300;
H=200;

// depth into sides
gSidePocketDepth = 7;
// height of tabs on bottom
gBotTabWidth = 6.5;
gBotPocketDepth = gMaterialThick - gBotTabWidth;
gBotToFloor = 2;

topI = 20;
topJ = 6;

gVertTab = [
  [LEFT_EDGE, 0],
  [CTAB, 40, 30],
  [CTAB, 100, 30],
  [CTAB, 160, 30],
  [RIGHT_EDGE, H],
];

gBotSideTab = [
  [LEFT_EDGE, 0],
  [CTAB, W/2-90, 50],
  [CTAB, W/2, 50],
  [CTAB, W/2+90, 50],
  [RIGHT_EDGE, W],
];

gBotFrontTab = [
  [LEFT_EDGE, 0],
  [CTAB, 75, 50],
  [CTAB, L/2, 50],
  [CTAB, L-75, 50],
  [RIGHT_EDGE, L],
];


module Side(tabs=true) {
  C = W/2;
  difference() {
    square([W,H]);
    translate([C,H-topJ]) hull() {
      for(x_scale=[1,-1])
      translate([x_scale*W*0.25,0]) circle(d=topI,$fn=128);
    }
    translate([C,H-topJ]) for(x_scale=[1,-1]) scale([x_scale,1])
    translate([-W*0.25-topI/2-topJ,0]) difference() {
      square([20,20]);
      circle(r=topJ,$fn=128);
    }
    if(tabs) {
      TabsToLeft([W,H]) EdgeTabF(gBitSize, gMaterialThick, gVertTab);
      TabsToRight([W,H]) EdgeTabF(gBitSize, gMaterialThick, gVertTab);
    }
  }
}

module SidePocket() {
  translate([0,gBotPocketDepth+gBotToFloor])
    MiddleSlots(gBitSize, gBotTabWidth, gBotSideTab);
}

module Back(tabs=true) {
  difference() {
    square([L,H]);
    if(tabs) {
      TabsToLeft([L,H]) EdgeTabM(gBitSize, gMaterialThick, gVertTab);
      TabsToRight([L,H]) EdgeTabM(gBitSize, gMaterialThick, gVertTab);
    }
  }
}

module BackPocket() {
  translate([0,gBotPocketDepth+gBotToFloor])
    MiddleSlots(gBitSize, gBotTabWidth, gBotFrontTab);
}

module Front(tabs=true) {
  C = L/2;
  t = 0.32;  // TODO inset from edge instead?
  difference() {
    Back(tabs);
    translate([C,H-topJ]) hull() {
      for(x_scale=[1,-1])
      translate([x_scale*L*t,0]) circle(d=topI,$fn=128);
    }
    translate([C,H-topJ]) for(x_scale=[1,-1]) scale([x_scale,1])
    translate([-L*t-topI/2-topJ,0]) difference() {
      square([20,20]);
      circle(r=topJ,$fn=128);
    }
  }
}

module Bottom() {
  x = gMaterialThick - gSidePocketDepth - 1;
  difference() {
    translate([x,x]) square([L-2*x,W-2*x]);

    TabsToLeft([L,W]) EdgeTabM(gBitSize, gMaterialThick, gBotSideTab);
    TabsToRight([L,W]) EdgeTabM(gBitSize, gMaterialThick, gBotSideTab);

    EdgeTabM(gBitSize, gMaterialThick, gBotFrontTab);
    TabsToTop([L,W])
      EdgeTabM(gBitSize, gMaterialThick, gBotFrontTab);
  }
}

module Bottom2() {
  x = gMaterialThick;
  translate([x,x]) square([L-x*2, W-x*2]);
}

module Demo(expl=0) {
  translate([gMaterialThick-expl,0,0]) Flip([-gMaterialThick, -W])
    rotate([0,-90,0]) rotate([0,0,-90]) difference() {
    linear_extrude(height=gMaterialThick, convexity=12) Side();
    translate([0,0,gMaterialThick-gBotPocketDepth])
      linear_extrude(height=gMaterialThick, convexity=8) SidePocket();
  }
  translate([L+expl,0,0]) rotate([0,-90,0]) rotate([0,0,-90]) difference() {
    linear_extrude(height=gMaterialThick, convexity=12) Side();
    translate([0,0,gSidePocketDepth])
      linear_extrude(height=gMaterialThick, convexity=8) SidePocket();
  }

  translate([0,-W+gMaterialThick-expl,0]) Flip([L,-gMaterialThick])
    rotate([90,0,0]) difference() {
    linear_extrude(height=gMaterialThick, convexity=12) Front();
    translate([0,0,gSidePocketDepth])
      linear_extrude(height=gMaterialThick, convexity=8) BackPocket();
  }
  translate([0,expl,0]) rotate([90,0,0]) difference() {
    linear_extrude(height=gMaterialThick, convexity=12) Back();
    translate([0,0,gSidePocketDepth])
      linear_extrude(height=gMaterialThick, convexity=8) BackPocket();
  }

  translate([0,-W,gBotToFloor-expl]) {
    translate([0,0,gBotPocketDepth]) linear_extrude(height=gBotTabWidth) Bottom();
    linear_extrude(height=gMaterialThick) Bottom2();
  }
}

module Flip(box) {
  translate(box) rotate([0,0,180]) children();
}
