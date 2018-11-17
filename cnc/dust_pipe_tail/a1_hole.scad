include <dust_pipe_tail_lib.scad>;

translate([gEndDia/2,gEndDia/2]) difference() {
  offset(r=2) hull() DogBones() DogBoneHoles();
  DogBones() DogBoneHoles();
}
