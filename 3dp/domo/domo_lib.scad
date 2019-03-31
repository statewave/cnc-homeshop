include <../../_lib/edge_tabs.scad>;
include <../../_lib/bezier.scad>;

gMaterialThick = 12.2;
gCutDepth = -gMaterialThick-1.0;
gBitSize = 4.0;

// Depth _into_ front
gPocketDepth = 7;
gPocketDepthLeft = gMaterialThick - gPocketDepth;
// Width of front pocket
gPocketWidth = 6;
gPocketWidthLeft = gMaterialThick - gPocketWidth;


L = 240;
W = 240;
H = 400;
PW = W - gPocketWidthLeft * 2;
IW = W - gMaterialThick * 2;
PL = L - gPocketWidthLeft * 2;
IL = L - gMaterialThick * 2;

gFloorTabs = [
  [LEFT_EDGE, -L/2],
  [CTAB, -L/4, 30],
  [CTAB, 0, 30],
  [CTAB, L/4, 30],
  [RIGHT_EDGE, L/2],
];

gSideTabs = [
  [LEFT_EDGE, 0],
  [CTAB, 40, 40],
  [CTAB, 120, 40],
  [CTAB, 200, 40],
  [CTAB, 280, 40],
  [CTAB, 360, 40],
  [RIGHT_EDGE, H],
];

module FootCutout(dim) {
  hull() for(x_scale=[1,-1]) scale([x_scale,1])
    translate([dim/2-40,0]) circle(d=20,$fn=64);
}


module Back() {
  difference() {
    translate([-L/2,0]) square([L,H]);
    FootCutout(L);
  }
}

module BackPocket() {
  FrontPocket();
}

module Front() {
  difference() {
    translate([-L/2,0]) square([L,H]);
    FootCutout(L);

    t = L-80;
    u = 100; // space below for electronics; this should match bed bottom
    v = 50;  // space up top for belts
    offset(r=10,$fn=32) offset(delta=-10) translate([-t/2,u]) square([t,H-u-v]);

  }
}

module FrontPocket() {
  translate([0,60]) MiddleSlots(gBitSize, gPocketWidth, gFloorTabs);
  for(x_scale=[1,-1]) scale([x_scale,1])
    translate([-L/2+gPocketWidthLeft,0])
    TabsToLeft([L,H]) MiddleSlots(gBitSize, gPocketWidth, gSideTabs);
}

module SideProfile() {
  translate([-IW/2,0]) square([IW,H]);
  translate([0,H]) for(x_scale=[1,-1]) scale([x_scale,1])
    polygon(points=concat([[0,-1]], bezier_points([[-100, 0], [-40, 0], [-40, 20], [0, 20]], 0.1)));
}

module Side() {
  difference() {
    union() {
      translate([-PW/2,0]) square([PW,H]);
      translate([0,H]) for(x_scale=[1,-1]) scale([x_scale,1])
        polygon(points=concat([[0,-1]], bezier_points([[-100, 0], [-40, 0], [-40, 20], [0, 20]], 0.1)));
    }
    FootCutout(W);
    for(x_scale=[1,-1]) scale([x_scale,1])
      translate([-W/2,0]) TabsToLeft([W,H])
      EdgeTabM(gBitSize, gMaterialThick, gSideTabs);
    // TODO cut off excess tabs
  }
}

module SidePocket() {
  translate([0,60]) MiddleSlots(gBitSize, gPocketWidth, gFloorTabs);
}

module SideFakePocket1() {
  SideProfile();
}
module SideFakePocket2() {
  offset(delta=gBitSize) SideFakePocket1();
}

module SideFakePocketDemo() {
  difference() {
    offset(r=gBitSize,$fn=32) SideFakePocket1();
    SideFakePocket1();
  }
  difference() {
    offset(r=gBitSize,$fn=32) SideFakePocket2();
    SideFakePocket2();
  }
}

module Floor() {
  translate([-PL/2,0]) difference() {
    square([PL, PW]);
    translate([PL/2,0])
      EdgeTabM(gBitSize, gPocketWidthLeft, gFloorTabs);
    translate([0,PW/2])
      TabsToLeft([PL, PW])
        EdgeTabM(gBitSize, gPocketWidthLeft, gFloorTabs);
    translate([0,PW/2])
      TabsToRight([PL, PW])
        EdgeTabM(gBitSize, gPocketWidthLeft, gFloorTabs);
    translate([PL/2,0])
      TabsToTop([PL, PW])
        EdgeTabM(gBitSize, gPocketWidthLeft, gFloorTabs);
  }
}

module FloorFakePocketDemo() {
  difference() {
    offset(r=gBitSize,$fn=32) FloorFakePocket1();
    FloorFakePocket1();
  }
  difference() {
    offset(r=gBitSize,$fn=32) FloorFakePocket2();
    FloorFakePocket2();
  }
}

module FloorFakePocket1() {
  translate([0,PW/2]) square([IL,IW], center=true);
}

module FloorFakePocket2() {
  offset(delta=gBitSize) FloorFakePocket1();
}


module Demo() {
  // Front
  difference() {
    linear_extrude(height=gMaterialThick, convexity=4) Front();
    translate([0,0,gPocketDepthLeft])
      linear_extrude(height=gMaterialThick) FrontPocket();
  }
  // Back
  translate([L+16,0]) difference() {
    linear_extrude(height=gMaterialThick, convexity=4) Back();
    translate([0,0,gPocketDepthLeft])
      linear_extrude(height=gMaterialThick) BackPocket();
  }
  // Sides
  for(x=[0,L+16])
  translate([x,H+16,0])
    difference() {
      linear_extrude(height=gMaterialThick, convexity=12) Side();
      translate([0,0,gPocketWidthLeft]) linear_extrude(height=gMaterialThick, convexity=4)
        SideFakePocketDemo();
      translate([0,0,gPocketWidthLeft]) linear_extrude(height=gMaterialThick, convexity=8)
        SidePocket();
    }
  translate([-L-8,0]) difference() {
    linear_extrude(height=gMaterialThick,convexity=10) Floor();
    translate([0,0,gPocketWidthLeft])
      linear_extrude(height=gMaterialThick,convexity=10) FloorFakePocketDemo();
  }
}
