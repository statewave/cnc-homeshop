include <dust_gate_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  // a little slop
  offset(delta=0.5) M();
}

module M() {
  difference() {
    SliderProfile();
    SliderHoles();
  }
}
