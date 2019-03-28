gMaterialHeight = 12;
gCutDepth = -gMaterialHeight-0.2;
gPocketDepth = 4;
gBitSize = 6.35;

gBucketID = 285;
gBucketOD = 300;
gFrameOD = 320;
gStickoutWidth = 100;
gCenterPipeDia = 59.5;
gCenterPipeDia2 = 58;

gOffset = [gFrameOD/2,gFrameOD/2];

module Outline(bottom=false) {
  difference() {
    union() {
      circle(d=gFrameOD,$fn=1024);
      // TODO stickout part
      translate([gFrameOD/2-gStickoutWidth,-gFrameOD/2])
        square([gStickoutWidth,gFrameOD/2]);
    }
    if(bottom) {
      for(t=[40:2:290]) hull() {
        rotate([0,0,t])
          translate([120,0]) circle(d=30,$fn=32);
        rotate([0,0,t+2])
          translate([120,0]) circle(d=30,$fn=32);
      }
      circle(d=gCenterPipeDia2,$fn=1024);
    } else {
      circle(d=gCenterPipeDia,$fn=1024);
    }
  }
}

module BottomGroove() {
  difference() {
    circle(d=gBucketOD,$fn=1024);
    circle(d=gBucketID,$fn=1024);
  }
}

module StickoutPlate() {
  difference() {
    square([gStickoutWidth,gStickoutWidth+gMaterialHeight*2]);
    translate([gStickoutWidth/2,gStickoutWidth/2+gMaterialHeight])
      circle(d=gCenterPipeDia2,$fn=1024);
  }
}

module StickoutPlatePocket() {
  translate([-gBitSize/2,-1]) square([gStickoutWidth+gBitSize,gMaterialHeight+1]);
  translate([-gBitSize/2,gStickoutWidth+gMaterialHeight]) square([gStickoutWidth+gBitSize,gMaterialHeight+1]);
}
