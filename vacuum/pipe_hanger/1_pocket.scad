include <pipe_hanger_lib.scad>;

translate([0,-bottom_pos[1]+bottom_r]) difference() {
  offset(delta=5) Pocket();
  Pocket();
}

translate([270,0]) rotate([0,0,180]) difference() {
  offset(delta=5) Pocket();
  Pocket();
}
