include <dust_pipe_tail_lib.scad>;

translate(gMountPlateZero) difference() {
  offset(r=2) hull() MountPlatePocket();
  MountPlatePocket();
}
