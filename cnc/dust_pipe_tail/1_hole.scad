include <dust_pipe_tail_lib.scad>;

translate([15,20]) difference() {
  offset(r=2) hull() DogBones() DogBoneHoles();
  DogBones() DogBoneHoles();
}
