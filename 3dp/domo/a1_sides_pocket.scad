include <domo_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}

module M() {
  translate([L/2,0]) FrontPocket();
  translate([L/2+L+16,0]) BackPocket();

  translate([L/2,H+16]) SidePocket();
  translate([L/2+L+16,H+16]) SidePocket();
}
