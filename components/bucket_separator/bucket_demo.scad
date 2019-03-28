include <bucket_lib.scad>;

translate(gOffset) difference() {
  linear_extrude(height=gMaterialHeight,convexity=8) Outline(bottom=true);
  translate([0,0,gMaterialHeight-4])
    linear_extrude(height=gMaterialHeight) BottomGroove();
}

translate([gFrameOD+10,0]) difference() {
  linear_extrude(height=gMaterialHeight) StickoutPlate();
  translate([0,0,gMaterialHeight-2])
    linear_extrude(height=gMaterialHeight) StickoutPlatePocket();
}
