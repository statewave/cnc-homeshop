include <dust_gate_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}
module M() {
  for(i=[0:8-1]) translate([0, 45*i]) HandleHoles();
}

