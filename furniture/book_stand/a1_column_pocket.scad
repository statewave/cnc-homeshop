include <book_stand_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}
module M() {
  translate(gV1CutOffset) V1Pocket();
}
