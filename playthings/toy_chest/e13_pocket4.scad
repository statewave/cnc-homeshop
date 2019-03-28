include <production_lib.scad>;

difference() {
  offset(delta=10) hull() SidePocketPlate(3);
  SidePocketPlate(3);
}
