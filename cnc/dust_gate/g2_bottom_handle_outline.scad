include <dust_gate_lib.scad>;

for(i=[0:8-1]) translate([0, 45*i])
  HandleProfile(false);
