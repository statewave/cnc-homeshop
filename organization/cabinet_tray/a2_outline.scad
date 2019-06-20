include <cabinet_tray_lib.scad>;

M();

module M() {
  translate([0,gTrayWidth/2]) rotate([0,0,-90]) EndOutline();
  translate([100,gTrayWidth/2]) rotate([0,0,-90]) EndOutline();
}

