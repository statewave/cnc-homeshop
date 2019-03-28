include <production_lib.scad>;

difference() {
  offset(delta=10) hull() SidePocketPlate(2);
  SidePocketPlate(2);
}
