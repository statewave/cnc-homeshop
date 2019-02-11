gMaterialThick = 12;
gCutDepth = -gMaterialThick - 0.2;
gPocketDepth = 2;
gBitSize = 3.175;

gSpacingX = 150;
gSpacingY = 65;
gExtraX = 10;
gExtraY = 16.5;
gHoleDia = 4.5;
gPortDia = 63;
gRabbetSize = [138,82];
gOffset = [gSpacingX/2+gExtraX,gSpacingY/2+gExtraY];

module Outline() {
  offset(r=3,$fn=32) offset(delta=-3)
    square([gSpacingX+gExtraX*2,gSpacingY+gExtraY*2], center=true);
}

module Holes() {
  for(x_scale=[1,-1],y_scale=[1,-1]) scale([x_scale,y_scale])
    translate([gSpacingX/2,gSpacingY/2]) circle(d=gHoleDia,$fn=32);
}

module Port() {
  // other side of the adapter this is sized for can't hit the table, and is
  // 106mm dia.
  translate([0,8]) circle(d=gPortDia,$fn=128);
}

module InsetRabbet() {
  difference() {
    offset(delta=2) Outline();
    offset(r=3,$fn=32) offset(delta=-3) square(gRabbetSize, center=true);
  }
}
