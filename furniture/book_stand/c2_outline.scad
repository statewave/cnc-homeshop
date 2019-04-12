include <book_stand_lib.scad>;
include <../../_lib/repeat.scad>;

PatternY(4, 270)
  DiagonalFit(gV1aCutBox)
    translate(gV1aCutOffset) V1aSlice();

