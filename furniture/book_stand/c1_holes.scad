include <book_stand_lib.scad>;
include <../../_lib/repeat.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}
module M() {
  PatternY(4, 270)
    DiagonalFit(gV1aCutBox)
      translate(gV1aCutOffset) V1aHoles();
}
