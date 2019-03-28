include <production_lib.scad>;

difference() {
  offset(delta=10) hull() SidePocketPlate(1);
  SidePocketPlate(1);
}
