include <cabinet_tray_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}

module M() {
  translate([0,gTrayWidth/2]) rotate([0,0,-90]) EndPocket();
  translate([100,gTrayWidth/2]) rotate([0,0,-90]) EndPocket();
}
