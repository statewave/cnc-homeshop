include <book_stand_lib.scad>;
include <../../_lib/repeat.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}
module M() {
  PatternY(1, 520)
    DiagonalFit(gV1bCutBox)
      translate(gV1bCutOffset) V1bHoles();
}
