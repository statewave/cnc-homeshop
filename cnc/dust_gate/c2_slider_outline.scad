include <dust_gate_lib.scad>;

pitch = gTopSizeX + 10;
for(i=[0:4-1]) {
  translate([i*pitch,gSliderPlateOffset]) SliderProfile();
}


