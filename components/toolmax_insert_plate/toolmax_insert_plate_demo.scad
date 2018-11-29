include <toolmax_insert_plate_lib.scad>;

difference() {
  linear_extrude(height=gMaterialThick,convexity=4) SawPlate();
  translate([0,0,gMaterialThick-gPocketDepth]) linear_extrude(height=12,convexity=2) SawPlateRabbet();
}
