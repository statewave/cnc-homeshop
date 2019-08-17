include <tape_rack_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}

module M() {
  for(i=[1,2])
    translate([0,(gHeight+20)*i]) FrontPocket();
}
