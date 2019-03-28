include <bucket_lib.scad>;

difference() {
  offset(delta=10) hull() P();
  P();
}

module P() {
  StickoutPlatePocket();
}
