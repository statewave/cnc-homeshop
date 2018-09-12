gHolePos = [24,24+45];
gHoleDia = 10.5;
gWidth = 24;
gLength = 130;
gTipSize = 4;
gTipRotate = 55;
gBitSize = 4.1;

gPlatePitch = gWidth + gBitSize;
gRepeat = 4;

module ClampSide() {
  offset(r=1,$fn=32) offset(delta=-1) difference() {
    translate([0,-gWidth/2]) square([gLength,gWidth]);
    translate([gLength,-gWidth/2+gTipSize]) rotate([0,0,gTipRotate]) square([100,100]);
  }
}

module ClampSidePocket() {
  for(x=gHolePos) translate([x,0]) difference() {
    square([24,gWidth+8], center=true);
    for(x_scale=[1,-1]) scale([x_scale,1]) hull() {
      translate([11.5,0]) circle(d=12,$fn=128);
      for(y_scale=[1,-1]) scale([1,y_scale]) {
        translate([12-2,gWidth/2-2]) circle(d=4,$fn=32);
        translate([12,gWidth/2-2]) circle(d=4,$fn=32);
      }
    }
  }
}

module ClampSidePocketSimple() {
  for(x=gHolePos) translate([x,0]) square([20,gWidth+4], center=true);
}

module ClampSideThroughHole() {
  for(x=gHolePos) translate([x,0]) circle(d=gHoleDia,$fn=32);
}

module Lots() {
  for(i=[0:gRepeat-1])
    translate([0,i*gPlatePitch]) if (i % 2) {
      children();
    } else {
      scale([1,-1]) children();
    }
  
  for(i=[0:gRepeat-1])
    translate([gLength*2-15,i*gPlatePitch]) if (i % 2 == 0) {
      scale([-1,1]) children();
    } else {
      scale([-1,-1]) children();
    }
}
