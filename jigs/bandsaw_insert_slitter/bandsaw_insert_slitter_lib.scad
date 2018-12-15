gMaterialThick = 12.0;
gCutDepth = -(gMaterialThick + 0.2);
gRealBitSize = 4.0;
gBitSize = gRealBitSize;

gInsertDia = 2.5 * 25.4;
gPocketDepth = 2.0;

gHoleSpacing = gInsertDia;
gHoleSize = 4.5;

gHolderWidth = 100;
gHolderLength = 150;
gInset = 20;

module Outline() {
  offset(r=5,$fn=64) offset(r=-10,$fn=64) offset(delta=5) difference() {
    union() {
      translate([-gHolderWidth/2,-gInset]) square([gHolderWidth,gHolderLength]);
      circle(d=gInsertDia-0.1,$fn=256);
    }
    for(x_scale=[1,-1]) scale([x_scale,1])
      translate([gHolderWidth/2+2,gHolderLength*0.65]) circle(d=20,$fn=256);
  }
}

module Pocket() {
  offset(r=-1,$fn=32) offset(delta=1) {
    circle(d=gInsertDia,$fn=256);
    translate([0,-gBitSize/2]) intersection() {
      circle(d=gInsertDia,$fn=256);
      square([52,100], center=true);
    }
    hull()
      for(x_scale=[1,-1]) scale([x_scale,1])
        translate([gHoleSpacing/2,0]) circle(d=gHoleSize,$fn=32);
  }
}

module Demo() {
  difference() {
    linear_extrude(height=gMaterialThick,convexity=4) Outline();
    translate([0,0,gMaterialThick-gPocketDepth]) linear_extrude(height=gPocketDepth+0.1,convexity=6) Pocket();
  }
}
