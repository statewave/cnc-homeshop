include <../../_lib/fillets.scad>;

gMaterialThickness = 18;
gCutDepth = -gMaterialThickness-0.5;
gBitSize = 6.35;
gPocketDepth = 9;

gMountingCircle = 118;
gMountingHole = 5.5;
//gMountingSquare = 98;

gTopSize = [305,27*25.4];
gHeight = 50;

gTopOffset = [gTopSize[0]/2,gTopSize[1]/2];
gSideOffset = [0,gTopSize[1]/2];
gSideTabs = [-2,-1,0,1,2];
gShortSideOffset = [-gTopSize[0]/2,0];
gShortSideTabs = [-1,0,1];
gStiffenerOffset = [-gTopSize[0]/2,0];
gStiffenerTabs = [-0.5,0.5];

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
}

gYTabSpacing = 120;
gXTabSpacing = 105;
gTabWidth = 40;

module TopPocket() {
  // Long side
  for(x_scale=[1,-1]) scale([x_scale,1])
    for(i=gSideTabs)
    translate([-gTopSize[0]/2+gMaterialThickness/2-2,gYTabSpacing*i])
      SpikeBox([gMaterialThickness+4,gTabWidth], gBitSize, center=true);
  // Short side
  for(y_scale=[1,-1]) scale([1,y_scale])
    for(i=gShortSideTabs)
    translate([gXTabSpacing*i,-gTopSize[1]/2+gMaterialThickness/2-2])
      SpikeBox([gTabWidth,gMaterialThickness+4], gBitSize, center=true);
  // Stiffeners
  for(y_scale=[1,-1]) scale([1,y_scale])
    for(i=gStiffenerTabs)
    translate([gXTabSpacing*i,-gYTabSpacing*1.5])
      SpikeBox([gTabWidth,gMaterialThickness], gBitSize, center=true);
}

module TopDemo() {
  difference() {
    linear_extrude(height=gMaterialThickness,convexity=6) difference() {
      Top();
      TopHoles();
    }
    translate([0,0,gMaterialThickness-gPocketDepth])
      linear_extrude(height=gMaterialThickness,convexity=12) TopPocket();
  }
}

module Side() {
  difference() {
    translate([0,-gTopSize[1]/2])
      square([gHeight-gMaterialThickness+gPocketDepth-1, gTopSize[1]]);
    for(i=[-1.5,-0.5,0.5,1.5])
      translate([gPocketDepth/2-2,gYTabSpacing*i])
        SpikeBox([gPocketDepth+4, gYTabSpacing-gTabWidth], gBitSize, center=true);
    xcenter = (gHeight-gMaterialThickness)/2+gPocketDepth-1;
    lasttabstart = gYTabSpacing*2+gTabWidth/2;
    //translate([0,-lasttabstart]) circle(d=10);
    //echo(lasttabstart);
    for(y_scale=[1,-1]) scale([1,y_scale]) {
      translate([gPocketDepth/2-2, (gTopSize[1]/2+lasttabstart+6)/2])
        SpikeBox([gPocketDepth+4, gTopSize[1]/2-lasttabstart+6], gBitSize, center=true);
      translate([gPocketDepth+12/2-3,-gTopSize[1]/2+gMaterialThickness/2-2])
        SpikeBox([12+6,gMaterialThickness+4], gBitSize, center=true);
      translate([gPocketDepth+12/2-3,-gYTabSpacing*1.5])
        SpikeBox([12+6,gMaterialThickness], gBitSize, center=true);
    }
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
    for(i=[-0.5,0.5])
      translate([gXTabSpacing*i, gHeight-gMaterialThickness+gPocketDepth/2+1.5])
        SpikeBox([gXTabSpacing-gTabWidth,gPocketDepth+4], gBitSize, center=true);
    lasttabstart = gXTabSpacing+gTabWidth/2;
    for(x_scale=[1,-1]) scale([x_scale,1]) {
      translate([(gTopSize[0]/2+lasttabstart)/2+3,gHeight-gMaterialThickness+gPocketDepth/2+1.5])
        SpikeBox([gTopSize[0]/2-lasttabstart+6,gPocketDepth+4], gBitSize, center=true);
      // Corner
      translate([gTopSize[0]/2-gMaterialThickness/2+3,(gHeight-gMaterialThickness)/2-12])
        SpikeBox([gMaterialThickness+6,(gHeight-gMaterialThickness)], gBitSize, center=true);
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
    for(i=[0])
      translate([gXTabSpacing*i, gHeight-gMaterialThickness+gPocketDepth/2+1.5])
        SpikeBox([gXTabSpacing-gTabWidth,gPocketDepth+4], gBitSize, center=true);
    lasttabstart = gXTabSpacing*0.5+gTabWidth/2;
    for(x_scale=[1,-1]) scale([x_scale,1]) {
      translate([(gTopSize[0]/2+lasttabstart)/2+3,gHeight-gMaterialThickness+gPocketDepth/2+1.5])
        SpikeBox([gTopSize[0]/2-lasttabstart+6,gPocketDepth+4], gBitSize, center=true);
      // Corner
      translate([gTopSize[0]/2-gMaterialThickness/2+3,(gHeight-gMaterialThickness)/2-12])
        SpikeBox([gMaterialThickness+6,(gHeight-gMaterialThickness)], gBitSize, center=true);
    }
  }
}
