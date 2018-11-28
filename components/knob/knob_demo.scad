include <knob_lib.scad>;

difference() {
  linear_extrude(height=10, convexity=10) difference() {
    KnobOutline();
    KnobHole();
  }
  translate([0,0,gMaterialThick-gPocketDepth])
    linear_extrude(height=10, convexity=4) KnobPocket();
}

