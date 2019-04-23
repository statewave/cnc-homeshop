include <plumb_hammer_face_lib.scad>;

difference() {
  offset(delta=10) hull() AlignmentPegs();
  AlignmentPegs();
}
