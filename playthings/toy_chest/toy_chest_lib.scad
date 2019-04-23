include <../../_lib/edge_tabs.scad>;
size = 2;

gMaterialThick = 12.2;
gCutDepth = -gMaterialThick - 1.0;
gBitSize = 4.0;
L = 400 * (size == 1 ? 1 : 0.6);
W = 300 * (size == 1 ? 1 : 0.6);
H = 200 * (size == 1 ? 1 : 0.6);

// depth into sides (length of tabs on Bottom and LidSide)
gSidePocketDepth = 6;
// thickness of tabs on Bottom and LidSide
gBotTabWidth = 6;
gBotPocketDepth = gMaterialThick - gBotTabWidth;
gBotToFloor = size == 1 ? 2 : 75;

topI = size == 1 ? 20 : 10;
topJ = size == 1 ? 9 : 4.9;

gVertTab = [
  [LEFT_EDGE, 0],
  //[CTAB, 40, 30],
  //[CTAB, 100, 30],
  //[CTAB, 160, 30],
  [TAB, 25, 25],
  [TAB, 70, 25],
  [RIGHT_EDGE, H],
];

gBotTabSize = size == 1 ? 50 : 30;

gBotSideTab = [
  [LEFT_EDGE, 0],
  //[CTAB, W/2-90, gBotTabSize],
  //[CTAB, W/2, gBotTabSize],
  //[CTAB, W/2+90, gBotTabSize],
  [CTAB, W*0.2, gBotTabSize],
  [CTAB, W*0.5, gBotTabSize],
  [CTAB, W*0.8, gBotTabSize],
  [RIGHT_EDGE, W],
];

gBotFrontOffset = size == 1 ? 75 : 40;
gBotFrontTab = [
  [LEFT_EDGE, 0],
  [CTAB, gBotFrontOffset, gBotTabSize],
  [CTAB, L/2, gBotTabSize],
  [CTAB, L-gBotFrontOffset, gBotTabSize],
  [RIGHT_EDGE, L],
];

gSlatWidth = size == 1 ? 32 : 29;
gLidSlatTab = [
  [LEFT_EDGE, -gSlatWidth/2-10],
  [CTAB, 0, gSlatWidth*0.6],
  [RIGHT_EDGE, gSlatWidth/2+10],
];

gLidFrontWidth = size == 1 ? 40 : 26;
gLidFrontTab = [
  [LEFT_EDGE, 0],
  [CTAB, gLidFrontWidth/2, , gLidFrontWidth*0.6],
  [RIGHT_EDGE, gLidFrontWidth+10],
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
  x = gMaterialThick - gSidePocketDepth + 1;
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

  translate([gMaterialThick-expl,0,H+expl])
    rotate([0,-90,0]) rotate([0,0,-90]) difference() {
    linear_extrude(height=gMaterialThick, convexity=12) LidSide(true);
    translate([0,0,6]) linear_extrude(height=gMaterialThick, convexity=12) difference() {
      offset(delta=10) LidSide(false);
      LidSide(false);
    }
  }
  translate([L+expl,0,H+expl]) rotate([0,-90,0]) rotate([0,0,-90]) difference() {
    linear_extrude(height=gMaterialThick, convexity=12) LidSide();
  }

  // TODO: 0.32 is not the right thing to use here
  translate([0,-W/2,H+expl+W*0.32]) SlatsDemo(gAngles, expl);
  translate([0,expl,H+expl]) rotate([90,0,0]) LidFrontDemo();
}

module Flip(box) {
  translate(box) rotate([0,0,180]) children();
}

module LidDemo() {
  rotate([0,-90,0]) linear_extrude(height=gMaterialThick) LidSide();
}

module LidFacet(rotations, i=0, tabs=true) {
  if(i==0) translate([-1,0]) square([2,10]);
  rotate([0,0,rotations[i]]) {
    SlatTab(tabs);
    if(i < len(rotations)-1) {
      translate([gSlatWidth,0]) LidFacet(rotations, i+1, tabs);
    }
  }
}

module SlatTab(tabs) {
  // This offsets so the max depth middle point is at 0,0, which makes rotations
  // work ok.
  //#square([gSlatWidth,gSidePocketDepth]);
  translate([gSlatWidth/2, gSidePocketDepth-1]) {
    if(tabs) {
      intersection() {
        TabsToTop([0,0]) EdgeTabM(gBitSize, gSidePocketDepth-1, gLidSlatTab);
        // Fixup the corners, especially convex ones
        hull() {
          translate([-gSlatWidth/2,-gSidePocketDepth+1]) square([gSlatWidth,1]);
          translate([-gSlatWidth/2-3,10]) square([gSlatWidth+6,40]);
          translate([-gSlatWidth/2+2,-gSidePocketDepth-3]) square([gSlatWidth-4,40]);
        }
      }
    } else {
      translate([-gSlatWidth/2,-gSidePocketDepth+1]) square([gSlatWidth,100]);
      translate([-gSlatWidth/2, 0]) polygon(points=[[0,-gSidePocketDepth+1], [8, 10], [-8, 10]]);
    }
    // subtract off the top
    hull() {
      translate([-gSlatWidth/2,0]) square([gSlatWidth,200]);
      translate([-gSlatWidth/2-25,50]) square([gSlatWidth+50,200]);
    }
    //polygon(points=[[gSlatWidth/2,-gSidePocketDepth+2], [gSlatWidth/2+5, 10], [gSlatWidth/2-5, 10]]);
    //translate([gSlatWidth/2,0]) circle(r=gSidePocketDepth-2,$fn=32);

    // TODO: Why is this circle slightly offset?
    //translate([-gSlatWidth/2,0]) circle(r=gSidePocketDepth-1,$fn=32);
  }
}

t = size == 1 ? 16 : 15;
gAngles = size == 1 ? [-t/2, -t, -t, t, t/2] : [-t/2,-t,-t];

module LidSide(tabs=false, n=0) {
  th = W*0.35;
  render() difference() {
    square([W, th]);
    translate([W/2,th-gSidePocketDepth+1])
      for(x_scale=[1,-1]) scale([x_scale,1])
      LidFacet(gAngles, 0, tabs);

    if(tabs) {
      // Becuase these aren't full-depth, we need to trim
      TabsToRight([W, th]) EdgeTabM(gBitSize, gMaterialThick, gLidFrontTab);
      translate([W-gMaterialThick+gSidePocketDepth-1,0]) square([100,100]);
      TabsToLeft([W, th]) EdgeTabM(gBitSize, gMaterialThick, gLidFrontTab);
      translate([-100+gMaterialThick-gSidePocketDepth+1,0]) square([100,100]);
    } else {
      translate([W-gMaterialThick, -1]) square([100,100]);
      translate([-100+gMaterialThick,-1]) square([100,100]);
    }

    if(n==2) {
      translate([W/2,-W*0.3])circle(r=W*0.48,$fn=256);
    }
  }
}

module SlatDemo() {
  difference() {
    linear_extrude(height=gMaterialThick) SlatOutline();
    translate([0,0,gMaterialThick-gSidePocketDepth]) linear_extrude(height=gMaterialThick) SlatPocket();
  }
}

module SlatOutline() {
  square([L,gSlatWidth]);
}

module SlatPocket() {
  rem = gMaterialThick - gBotTabWidth;
  // left
  translate([rem, gSlatWidth/2]) TabsToLeft([L, gSlatWidth]) MiddleSlots(gBitSize, gBotTabWidth, gLidSlatTab);
  // right
  translate([L,0]) scale([-1,1]) translate([rem, gSlatWidth/2]) TabsToLeft([L, gSlatWidth]) MiddleSlots(gBitSize, gBotTabWidth, gLidSlatTab);
  // approx middle
  translate([L/2-gMaterialThick/2,0]) translate([rem, gSlatWidth/2]) TabsToLeft([L, gSlatWidth]) MiddleSlots(gBitSize, gBotTabWidth, gLidSlatTab);
}

module SlatsDemo(rotations, expl=0, i=0) {
  rotate([rotations[i], 0, 0]) {
    translate([0,0,gMaterialThick+expl]) scale([1,1,-1]) SlatDemo();
    if(i < len(rotations)-1) {
      translate([0,gSlatWidth,0]) SlatsDemo(rotations, expl, i+1);
    }
  }
}

module LidFrontDemo() {
  rem = gMaterialThick - gBotTabWidth;
  difference() {
    linear_extrude(height=gMaterialThick) LidFrontOutline();
    translate([0,0,rem]) linear_extrude(height=gMaterialThick) LidFrontPocket();
  }
}

module LidFrontOutline() {
  square([L,gLidFrontWidth]);
}

module LidFrontPocket() {
  rem = gMaterialThick - gBotTabWidth;
  // left
  translate([rem, 0]) TabsToLeft([L, gLidFrontWidth]) MiddleSlots(gBitSize, gBotTabWidth, gLidFrontTab);
  // right
  translate([L,0]) scale([-1,1])
    translate([rem, 0])
    TabsToLeft([L, gLidFrontWidth]) MiddleSlots(gBitSize, gBotTabWidth, gLidFrontTab);
  // approx middle
  translate([L/2-gMaterialThick/2,0]) translate([rem, 0]) TabsToLeft([L, gLidFrontWidth]) MiddleSlots(gBitSize, gBotTabWidth, gLidFrontTab);
}

module LidSidePattern(I, J) {
  for (i=[0:I])
    translate([i*W,0]) children();
  for (i=[0:J])
    translate([W*1.5+i*W,W*0.5+25]) rotate([0,0,180]) children();
  for (i=[0:I])
    translate([i*W,W*0.7+8]) children();
}

