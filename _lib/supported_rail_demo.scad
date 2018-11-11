include <supported_rail.scad>;

module FullRail() {
  difference() {
    RailDemo(SBR16, 500);
    #linear_extrude(height=10) RailHoles(SBR16, 500);
  }
}

module Base() {
  difference() {
    translate([0,0,-8]) linear_extrude(height=12,convexity=12) difference() {
      translate([-30, -10]) square([60,520]);
      RailHoles(SBR16, 500);
    }
    linear_extrude(height=12) RailPocket(SBR16, 500, 4.1);
  }
}

color([0,0.5,0,0.8]) Base();
FullRail();
