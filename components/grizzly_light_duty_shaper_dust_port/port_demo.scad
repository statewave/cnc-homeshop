include <port_lib.scad>;

difference(){ 
  linear_extrude(height=gMaterialThick,convexity=8) difference() {
    Outline();
    Holes();
    Port();
  }
  translate([0,0,gMaterialThick-gPocketDepth])
    linear_extrude(height=gMaterialThick, convexity=4) InsetRabbet();
}
