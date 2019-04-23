include <production_lib.scad>;

N_FRONT = 16;
N_REST = 1;

difference() {
  offset(delta=10) hull() SidePocketPlate(0, 0);
  SidePocketPlate(0, 0);
}
