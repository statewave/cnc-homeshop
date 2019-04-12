include <book_stand_lib.scad>;

difference() {
  offset(delta=10) hull() BaseHoles();
  BaseHoles();
}
