include <toolmax_insert_plate_lib.scad>;

difference() {
  offset(delta=10) hull() SawPlateRabbet();
  SawPlateRabbet();
}
