include <clamp_lib.scad>;

translate([0,gWidth/2]) difference() {
  translate([0,-20]) square([300,gRepeat*gPlatePitch+10]);
  Lots() ClampSideThroughHole();
}
