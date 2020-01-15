include <pantry_cans_lib.scad>;

difference() {
  offset(delta=10) hull() BSideRabbet();
  BSideRabbet();
}
