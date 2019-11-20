include <dust_gate_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}
pitch = gTopSizeX + 10;
module M() {
  for(i=[0:5-1]) translate([i*pitch,gSliderPlateOffset]) SliderHoles();
}

