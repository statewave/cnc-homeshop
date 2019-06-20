include <../../_lib/edge_tabs.scad>;

gMaterialThick = 11.85;
gBitSize = 6.35;

// My cabinets are 21 and 22 inches wide (to clear doors/hinges); subtract
// a smidge and call it 525mm (275 + 250) and 550mm (275 * 2).
//
gTrayWidth = 275;
gTrayDepth = 350;
gTrayHeight = 63;
gHandle = 80;
gHandleR1 = 12;
gHandleR2 = 28;
gBottomRabbet = 7;

module Demo() {
  rotate([0,0,180]) rotate([90,0,0]) EndDemo();
  translate([0,gTrayDepth+20,0]) rotate([90,0,0]) EndDemo();

  translate([gTrayWidth/2-gMaterialThick,0,0]) rotate([0,90,0]) translate([-gTrayHeight,0]) SideDemo();
  translate([-gTrayWidth/2+gMaterialThick,0,0]) scale([-1,1]) rotate([0,90,0]) translate([-gTrayHeight,0]) SideDemo();
}

module EndDemo() {
  difference() {
    linear_extrude(height=gMaterialThick) EndOutline();
    translate([0,0,gMaterialThick-gEdgeTabSpec[3]]) linear_extrude(height=gMaterialThick) EndPocket();
  }
}

module SideDemo() {
  difference() {
    linear_extrude(height=gMaterialThick, convexity=10) SideOutline();
    // TODO 5
    translate([0,0,5]) linear_extrude(height=gMaterialThick) difference() {
      SideTopOutline(2);
      SideTopOutline(0);
    }
  }
}

module SideOutline() {
  X = gMaterialThick - A;
  difference() {
    translate([0,X]) square([gTrayHeight, gTrayDepth-2*X]);
    EdgeTabM(gBitSize, gMaterialThick, gTabs1);
    TabsToTop([gTrayHeight, gTrayDepth]) EdgeTabM(gBitSize, gMaterialThick, gTabs1);
  }
}

module SideTopOutline(n) {
  X = gMaterialThick;
  offset(delta=n*gBitSize*0.8) translate([0,X]) square([gTrayHeight, gTrayDepth-2*X]);
}

// This should be put into a library.
// M stickout, leave, depth; F depth, pocketw, inset;
//  >>gBS means more fake passes
//              >gBS           ^^ because
//                             (   = gMT so mind inset for strength
A = 6;  // male tab length
B = 7.5;  // male tab thickness
gEdgeTabSpec = [A, B, gMaterialThick-B,  A+1, B, gMaterialThick - B];

gCutDepth = -gMaterialThick - 0.2;
gSidePocketDepth = -gEdgeTabSpec[2];
gEndPocketDepth = -gEdgeTabSpec[3];

gTabs1 = [
  [LEFT_EDGE, 0],
  [CTAB, 18, 20],
  [CTAB, gTrayHeight -18 , 20],
  [RIGHT_EDGE, gTrayHeight],
];

module EndPocket() {
  for(x_scale=[1,-1]) scale([x_scale,1])
    translate([-gTrayWidth/2+gEdgeTabSpec[5],0]) TabsToLeft([gTrayWidth,gTrayHeight])
    MiddleSlots(gBitSize, gEdgeTabSpec[4], gTabs1);
  translate([-gTrayWidth/2,0]) SpikeBox(gBitSize,[gTrayWidth,gBottomRabbet+4]);
}

module EndOutline() {
  difference() {
    offset(r=-20,$fn=256) offset(delta=20) {
      translate([-gTrayWidth/2,0]) square([gTrayWidth,gTrayHeight]);
      hull() for(x=[-gHandle/2,gHandle/2])
        translate([x,gTrayHeight]) circle(r=gHandleR2,$fn=256);
    }
    hull() for(x=[-gHandle/2,gHandle/2])
      translate([x,gTrayHeight]) circle(r=gHandleR1,$fn=256);
  }
}


