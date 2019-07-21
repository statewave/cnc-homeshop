gMaterialThick = 18.0;
gCutDepth = -gMaterialThick-0.5;
gBitSize = 6.35;
gRad = 100;
gPocketDepth = -gMaterialThick + 4;


module Demo() {
  linear_extrude(height=gMaterialThick) Outline();
}

module Outline() {
  scale([1.25,1.25]) difference() {
    offset(r=10,$fn=256) offset(delta=-10) difference() {
      circle(r=gRad,$fn=256);
      translate([0,-112]) circle(r=70,$fn=256);
    }
    offset(r=7,$fn=256) offset(delta=-7) intersection() {
      circle(r=gRad-25,$fn=256);
      union() {
        translate([0,115]) circle(r=gRad,$fn=256);
        translate([-115,-15]) circle(r=60,$fn=256);
        translate([115,-15]) circle(r=60,$fn=256);
      }
    }
  }
}

module Hole() {
  circle(d=18,$fn=256);
}

module SpacerOutline() {
  offset(r=7,$fn=256) offset(delta=-7) square([45,30], center=true);
}
