include <outside_caliper_lib.scad>;

module DemoLeg() {
  rotate([0,0,-10]) translate([-gEndDia/2,-gEndDia/2]) difference() {
    linear_extrude(height=gMaterialThick,convexity=4) Leg();
    translate([0,0,gMaterialThick-gPocketDepth])
      linear_extrude(height=gMaterialThick) Pocket();
    translate([0,0,-1]) linear_extrude(height=gMaterialThick+2) Hole();
  }
}

DemoLeg();
translate([0,0,20]) rotate([0,180,0]) DemoLeg();
