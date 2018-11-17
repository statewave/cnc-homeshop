include <dust_pipe_tail_lib.scad>;

module X() {
  translate([22,25]) MountPivotHole();
  translate([gMountPlateZero[0]*2-22,25]) MountPivotHole();
}

difference() {
  offset(delta=10) hull() X();
  X();
}
