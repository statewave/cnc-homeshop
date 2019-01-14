include <v_block_lib.scad>;

module Lots(n) {
  f=-(n/2-1)*gMaterialThickness;
  for(i=[0:n-1]) {
    translate([0,gMaterialThickness*i+f,0]) rotate([90,0,0])
      linear_extrude(height=gMaterialThickness-0.2) difference() {
      Outline(i==0);
      Holes();
    }
  }
}
gRep = 5;

Lots(gRep);
translate([0,0,0]) linear_extrude(height=gMaterialThickness) Base(gRep);
