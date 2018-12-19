include <fence_lib.scad>;

difference() {
  offset(delta=10) hull() Rabbets();
  Rabbets();
}

module Rabbets() {
  SideRabbets(gMaterialThick, gRabbetPositions);
  translate([gSledA+8,0]) BottomRabbets(gMaterialThick, gRabbetPositions);
}
