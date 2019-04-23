gMaterialThickness = 18;
gCutDepth = -gMaterialThickness-0.2;
gAlignmentPegCutDepth = gCutDepth - 5;
gBitSize = 6.35;

gOuterDia = 38.5;

gCenterPegDia = 6.75; // tap for 5/16-18
gCenterPegDepth = 8;

gTaperDepth = 6.8;
gTaperBotDia = 28.7;

module Demo() {
  difference() {
    union() {
      linear_extrude(height=gMaterialThickness-gTaperDepth) Outline();
      translate([0,0,gMaterialThickness-gTaperDepth])
        linear_extrude(height=gTaperDepth) TaperOutline();
    }
    translate([0,0,gMaterialThickness-gCenterPegDepth])
      linear_extrude(height=gMaterialThickness) CenterPeg();
  }
  AlignmentPegs();
}

module Outline() {
  circle(d=gOuterDia,$fn=256);
}

module CenterPeg() {
  circle(d=gCenterPegDia, $fn=256);
}

module TaperOutline() {
  // Yes, this is not a taper.
  circle(d=gTaperBotDia,$fn=256);
}

module AlignmentPegs() {
  for(t=[25,-25]) translate([t,t]) circle(d=8,$fn=256);
}
