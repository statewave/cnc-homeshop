include <dust_pipe_tail_lib.scad>;

translate(gMountPlateZero) MountPlate();
translate([22,25]) MountPivot();
translate([gMountPlateZero[0]*2-22,25]) MountPivot();
