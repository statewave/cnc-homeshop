include <production_lib.scad>;

difference() {
  offset(delta=10) hull() SidePocketPlate(0);
  SidePocketPlate(0);
}
