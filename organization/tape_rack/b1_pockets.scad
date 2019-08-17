include <tape_rack_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}

module M() {
  translate([gDepth+5,0]) for(x_scale=[1,-1]) scale([x_scale,1])
    translate([5,0]) SidePocket();
}
