include <../../_lib/fillets.scad>;

gMaterialThickness = 18.0;
gBitSize = 4.0;
gCutDepth = -gMaterialThickness-0.2;

gWidth = 50;
gHeight = 60;
gLegR1 = gMaterialThickness;
gLegR2 = 6;
gPegWidth = 35;
gPinDia = 5.95;
gSlotDia = 10;

gZeroOff = [gWidth/2,0];

module Holes() {
  for(x_scale=[1,-1]) scale([x_scale,1])
    translate([gWidth/2*0.6,gMaterialThickness*1.4]) circle(d=gPinDia,$fn=32);
}

module Outline(leg=false) {
  difference() {
    offset(r=-gLegR2,$fn=32) offset(delta=gLegR2) difference() {
      union() {
        translate([-gWidth/2,0]) square([gWidth, gHeight]);
        if(leg) hull() for(t=[-gWidth/2,gWidth/2])
          translate([t,gLegR1]) circle(r=gLegR1,$fn=128);
      }
      translate([0,gHeight-gWidth/2+5]) rotate([0,0,45]) square([100,100]);
    }
    for(x_scale=[1,-1]) scale([x_scale,1]) {
      translate([gPegWidth/2,-10]) SpikeBox([100,gMaterialThickness+10], gBitSize);
    }
    if(!leg)
      for(x_scale=[1,-1]) scale([x_scale,1]) hull() {
        translate([gWidth/2-2,gMaterialThickness*2]) circle(d=gSlotDia,$fn=32);
        translate([gWidth/2+2,gMaterialThickness*2]) circle(d=gSlotDia,$fn=32);
      }
  }
}

module Base(n) {
  difference() {
    offset(r=30,$fn=128) square([gWidth,gMaterialThickness*n], center=true);
    SpikeBox([gPegWidth,gMaterialThickness*n], gBitSize, center=true);
  }
}
