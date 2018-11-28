gMaterialThick = 19;
gCutDepth = -(gMaterialThick+0.4);
gBitSize = 4;

gHoleDia = 16;
gKnobDia = 55;
gNumDetents = 2;
gDetentDia = 8;
gDetentInset = 0;
gRoundoverRad = 3;

module Outline() {
  offset(r=gRoundoverRad,$fn=32) offset(delta=-gRoundoverRad)
  difference() {
    circle(d=gKnobDia, $fn=256);
    for(i=[0:gNumDetents-1]) rotate([0,0,360/gNumDetents*i])
      hull() for(x=[0,20]) translate([gKnobDia/2-gDetentInset+x,0])
      circle(d=gDetentDia,$fn=32);
  }
}

module Hole() {
  circle(d=gHoleDia,$fn=64);
}
