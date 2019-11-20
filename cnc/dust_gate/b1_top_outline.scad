include <dust_gate_lib.scad>;

for(xi=[0,1], yi=[0, 1])
  translate([(gTopSizeX+25)*xi, (gTopSizeY+8)*yi])
    TopProfile();

