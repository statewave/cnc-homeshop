include <book_stand_lib.scad>;
include <../../_lib/repeat.scad>;

PatternY(1, 520)
  DiagonalFit(gV1bCutBox)
    translate(gV1bCutOffset) V1bSlice();

