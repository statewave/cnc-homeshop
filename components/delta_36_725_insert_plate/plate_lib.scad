gMaterialThick = 12;

SawPlateSize = [95,397];
SawPlateRadius = SawPlateSize[0]/2;
SawPlateFingerHole = 19;
SawPlateFingerHoleSpacing = 35;

SawPlateStepSize = 5;
SawPlateStepDepth = 3.175;

ScrewLocs = [
  [10,50,180],
  [SawPlateSize[0]-10,50,0],
  [10, SawPlateSize[1]-80,180],
  [SawPlateSize[0]-10, SawPlateSize[1]-80, 0],
  // the odd corner one
  [16, SawPlateSize[1]-20, atan2(16, -20)]
];
ScrewHoleDia = 5;

PrecutSize = [5, 150];
PrecutRightOffset = 36;
PrecutYCenter = 185;

RivingKnifeWidth = 4.5;
RivingKnifeEnd = SawPlateSize[1]-20;
RivingKnifeStart = (PrecutYCenter+PrecutSize[1]/2)-5;
RivingKnifeRightOffset = 36;

module Outline() {
  hull() {
    for(y=[SawPlateRadius, SawPlateSize[1]-SawPlateRadius])
      translate([SawPlateRadius, y]) circle(r=SawPlateRadius,$fn=512);
  }
}

module FingerHole() {
  translate([SawPlateFingerHoleSpacing,SawPlateFingerHoleSpacing])
    circle(d=SawPlateFingerHole,$fn=64);
}

module Holes() {
  for(p=ScrewLocs) translate([p[0],p[1]]) circle(d=ScrewHoleDia,$fn=32);
}

module Inset() {
  offset(r=5,$fn=32) offset(delta=-5) difference() {
    offset(delta=-SawPlateStepDepth) Outline();
    for(p=ScrewLocs) translate([p[0],p[1]]) hull() {
      circle(d=20,$fn=64);
      rotate([0,0,p[2]]) translate([10,0]) circle(d=30,$fn=32);
    }
  }
}

module Precut() {
  translate([SawPlateSize[0]-PrecutSize[0]-PrecutRightOffset,PrecutYCenter-PrecutSize[1]/2])
    square(PrecutSize);
}

module RivingKnifeSlot() {
  translate([SawPlateSize[0]-RivingKnifeWidth-RivingKnifeRightOffset,RivingKnifeStart])
    square([RivingKnifeWidth,RivingKnifeEnd-RivingKnifeStart]);
}


module SawPlateDemo(with_riving_knife=true) {
  difference() {
    union() {
      linear_extrude(height=SawPlateStepDepth,convexity=6) difference() {
        Outline();
        Holes();
      }
      difference() {
        linear_extrude(height=gMaterialThick,convexity=6) Inset();
        translate([0,0,5]) linear_extrude(height=gMaterialThick) Precut();
      }
    }
    translate([0,0,-1]) linear_extrude(height=gMaterialThick+2) FingerHole();
    translate([0,0,-1]) linear_extrude(height=gMaterialThick+2) RivingKnifeSlot();
  }
}
