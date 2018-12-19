include <fence_lib.scad>;

for(y=gRabbetPositions) translate([(gMaterialThick-gPocketDepth),y+gMaterialThick/2,0])
  rotate([90,0,0]) linear_extrude(height=12) Angle();
// TODO translate for rabbet
//translate([gPocketDepth-1,0,0])
rotate([0,-90,0]) difference() {
  linear_extrude(height=12) Side();
  translate([0,0,-gPocketDepth])
    linear_extrude(height=12) SideRabbets(gMaterialThick, gRabbetPositions);
}

translate([0,0,-20])
difference() {
  linear_extrude(height=12) Bottom();
  translate([0,0,gMaterialThick-gPocketDepth])
    linear_extrude(height=12) BottomRabbets(gMaterialThick, gRabbetPositions);
}
