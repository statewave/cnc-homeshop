include <tracks_lib.scad>;

difference() {
  hull() offset(delta=10) M();
  M();
}

module M() {
  for(i=[0:5]) {
    translate([0,i*40]) MountProfileHoles(gLinkSpacing);
  }
}
