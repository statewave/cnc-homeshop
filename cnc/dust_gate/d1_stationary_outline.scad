include <dust_gate_lib.scad>;

pitch = gSliderStationary + 10;
for(i=[0:10-1])
  translate([i*pitch,0]) StationaryProfile();
