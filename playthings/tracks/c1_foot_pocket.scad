include <tracks_lib.scad>;

difference() {
  offset(delta=10) hull() M();
  M();
}

module M() {
  for(i=[0:3]) {
    translate([0,i*gLinkSpacing])
      FootPocket(i);
  }
}
