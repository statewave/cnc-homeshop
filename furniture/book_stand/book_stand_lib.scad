include <../../_lib/bezier.scad>;
include <../../_lib/edge_tabs.scad>;

gMaterialThick = 12.2;
gCutDepth = -gMaterialThick-1;
gBitSize = 4.0;

gColumnWide = 120;
gColumnDeep = 130+gMaterialThick*2;
gColumnTall = 42 * 25.4;

gPaverSize = 305;
gPaverHeight = 50;

gTabStickout = 7;
gPocketDepth = -gTabStickout - 1;  // for cam
gTabLeft = gMaterialThick - gTabStickout;

gEdgeTabLeft = 6;
gEdgeTabPocketDepth = -(gMaterialThick-gEdgeTabLeft);

_w = gPaverSize + gMaterialThick * 2;
gBaseTabs = [
  [LEFT_EDGE, 0],
  [CTAB, _w * 0.25, 60],
  [CTAB, _w * 0.5, 60],
  [CTAB, _w * 0.75, 60],
  [RIGHT_EDGE, _w * 2],
];

x_total = gPaverSize + gMaterialThick * 2;

module BaseOutline() {
  t = gPaverSize + gTabStickout * 2;
  difference() {
    translate([gTabLeft,gTabLeft]) square([t,t]);
    EdgeTabM(gBitSize, gMaterialThick, gBaseTabs);
    TabsToTop([x_total, x_total]) EdgeTabM(gBitSize, gMaterialThick, gBaseTabs);
    TabsToLeft([x_total,x_total]) EdgeTabM(gBitSize, gMaterialThick, gBaseTabs);
    TabsToRight([x_total,x_total]) EdgeTabM(gBitSize, gMaterialThick, gBaseTabs);
  }
}

module BaseHoles() {
  translate([x_total/2, x_total/2]) for(x_scale=[1,-1], x=[55,55+70], y=[35,-35])
    translate([x*x_scale,y]) circle(d=10,$fn=32);
}

module BaseFakePocket(n) {
  offset(delta=gBitSize*0.8*n)
    translate([gMaterialThick, gMaterialThick]) square([gPaverSize, gPaverSize]);
}

module BaseFakePocketDemo(n=0) {
  difference() {
    offset(delta=gBitSize) BaseFakePocket(n);
    BaseFakePocket(n);
  }
}

module BaseDemo() {
  difference() {
    linear_extrude(height=gMaterialThick, convexity=10) BaseOutline();
    translate([0,0,gMaterialThick+gEdgeTabPocketDepth]) linear_extrude(height=gMaterialThick)
      for(i=[0,1]) BaseFakePocketDemo(i);
  }
}

gSideDims = [x_total, gPaverHeight+gMaterialThick*2];

module BackOutline() {
  square(gSideDims);
}

module SideOutline() {
  difference() {
    square(gSideDims);
    square([gTabLeft,1000]);
    translate([gSideDims[0]-gTabLeft,0]) square([1000,1000]);
    TabsToLeft(gSideDims)
      EdgeTabM(gBitSize, gMaterialThick, gCornerTabs);
    TabsToRight(gSideDims)
      EdgeTabM(gBitSize, gMaterialThick, gCornerTabs);
  }
}

gCornerTabs = [
  [LEFT_EDGE, 0],
  [CTAB, (gPaverHeight+gMaterialThick*2)/2, 40],
  [RIGHT_EDGE, gPaverHeight+gMaterialThick*2],
];

module BackPockets() {
  translate([0,-gEdgeTabPocketDepth]) MiddleSlots(gBitSize, gEdgeTabLeft, gBaseTabs);
  TabsToTop(gSideDims)
    translate([0,-gEdgeTabPocketDepth]) MiddleSlots(gBitSize, gEdgeTabLeft, gBaseTabs);
  TabsToLeft(gSideDims)
    translate([0,-gEdgeTabPocketDepth]) MiddleSlots(gBitSize, gEdgeTabLeft, gCornerTabs);
  TabsToRight(gSideDims)
    translate([0,-gEdgeTabPocketDepth]) MiddleSlots(gBitSize, gEdgeTabLeft, gCornerTabs);
}

module SidePockets() {
  translate([0,-gEdgeTabPocketDepth]) MiddleSlots(gBitSize, gEdgeTabLeft, gBaseTabs);
  TabsToTop(gSideDims)
    translate([0,-gEdgeTabPocketDepth]) MiddleSlots(gBitSize, gEdgeTabLeft, gBaseTabs);
}

module SideDemo() {
  difference() {
    linear_extrude(height=gMaterialThick) SideOutline();
    translate([0,0,6]) linear_extrude(height=gMaterialThick) SidePockets();
  }
}

module BackDemo() {
  difference() {
    linear_extrude(height=gMaterialThick) BackOutline();
    translate([0,0,6]) linear_extrude(height=gMaterialThick) BackPockets();
  }
}

gBotHeight = 300;
gTopHeight = 400;
gTopWidth = 22 * 25.4;

gV1Tabs = [
  [LEFT_EDGE, 0],
  [CTAB, gBotHeight+70, 50],
  [CTAB, ((gColumnTall-gTopHeight-70)+(gBotHeight+70))/2, 50],
  [CTAB, gColumnTall-gTopHeight-70, 50],
  [RIGHT_EDGE, gColumnTall],
];

module V1Pocket() {
  translate([x_total/2,0])
  for(x_scale=[1,-1]) scale([x_scale,1])
    translate([-gColumnWide/2-gEdgeTabPocketDepth,0]) TabsToLeft([gColumnWide, gColumnTall])
    MiddleSlots(gBitSize, gEdgeTabLeft, gV1Tabs);
}

module V1() {
  h = gBotHeight;
  cl = (x_total-gColumnWide) / 2;
  // This is tricky to reason about because zero is in a strange place.
  p1 = concat(
    bezier_points([[-35,0], [-35, 200], [cl,h/2], [cl,h]], 0.1),
    [[x_total/2,h], [x_total/2,0]]
  );

  dx = -50;
  dy = -200;
  p2 = concat(
    bezier_points([[gTopWidth/2,80], [gTopWidth/2-25.4-dx/3,-dy/3], [gTopWidth/2-25.4,0]], 0.1),
    bezier_points([[gTopWidth/2-25.4,0], [gTopWidth/2-25.4+dx,dy], [gColumnWide/2,-100], [gColumnWide/2, -gTopHeight]], 0.1),
    [[0,-gTopHeight], [0,80]]
  );

  difference() {
    union() {
      polygon(points=p1);
      translate([x_total,0]) scale([-1,1])
        polygon(points=p1);
      translate([x_total/2-gColumnWide/2,0]) square([gColumnWide,gColumnTall]);

      translate([x_total/2,gColumnTall]) for(x_scale=[1,-1]) scale([x_scale,1]) polygon(points=p2);
    }
    hull() for(t=[0,100]) translate([x_total/2,gColumnTall+t]) circle(d=300, $fn=256);
    translate([0,-1]) square([x_total, gPaverHeight+gMaterialThick*2+1]);
  }
}

module V1aSlice() {
  intersection() {
    V1();
    difference() {
      translate([x_total/2+20,0]) square([1000, gBotHeight+25]);
      translate([x_total/2+gColumnWide/2-gMaterialThick,gBotHeight]) SpikeBox([100,100], gBitSize);
    }
  }
}

module V1aHoles() {
gV1bCutBox = [x_total/2+70,350];
  translate([x_total*0.9,gPaverHeight+gMaterialThick+50]) circle(d=6.1,$fn=32);
  translate([x_total*0.62,gPaverHeight+gMaterialThick+210]) circle(d=6.1,$fn=32);
}

module V1bSlice() {
  intersection() {
    V1();
    difference() {
      translate([x_total/2+30,gColumnTall-gTopHeight-25]) square([1000, 1000]);
      translate([x_total/2+gColumnWide/2-gMaterialThick,gColumnTall-gTopHeight-35]) SpikeBox([1000,35], gBitSize);
    }
  }
}

module V1bHoles() {
  // this first one needs to clear the mitered part if it's going to be metal!
  translate([x_total*1.02,gColumnTall-100]) circle(d=6.1,$fn=32);
  translate([x_total*0.66,gColumnTall-250]) circle(d=6.1,$fn=32);

}

module V2() {
  t = gTabLeft;
  difference() {
    translate([t,0]) square([gColumnDeep-t*2,gColumnTall-gTopHeight-gBotHeight]);
    translate([0,-gBotHeight]) TabsToLeft([gColumnDeep,gColumnTall]) EdgeTabM(gBitSize, gMaterialThick, gV1Tabs);
    translate([0,-gBotHeight]) TabsToRight([gColumnDeep,gColumnTall]) EdgeTabM(gBitSize, gMaterialThick, gV1Tabs);
  }
}

module V2FakePocket(n) {
  offset(delta=gBitSize*0.8*n)
    translate([gMaterialThick,0]) square([gColumnDeep-gMaterialThick*2,gColumnTall-gTopHeight-gBotHeight]);
}

module V2FakePocketDemo(n=0) {
  difference() {
    offset(delta=gBitSize) V2FakePocket(n);
    V2FakePocket(n);
  }
}

gV1CutOffset = [90,0];

gV1aCutOffset = [-x_total/2-20,0];
gV1aCutBox = [x_total/2+80,327];

gV1bCutOffset = [-x_total/2-30,-gColumnTall+gTopHeight+25];
gV1bCutBox = [x_total/2+120,505];
