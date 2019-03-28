include <bucket_lib.scad>;

difference() {
  offset(delta=10) hull() P();
  P();
}

module P() {
  translate(gOffset) BottomGroove();
  translate([gFrameOD+10,0]) StickoutPlatePocket();
}
