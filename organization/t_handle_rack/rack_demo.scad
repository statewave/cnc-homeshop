include <rack_lib.scad>;

difference() {
  linear_extrude(height=gMaterialThick,convexity=2) RackOutline(TorxSet, 6);
  translate([0,0,3])
    linear_extrude(height=gMaterialThick,convexity=20) RackHoles(TorxSet, 6);
}
