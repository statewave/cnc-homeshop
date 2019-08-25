include <tracks_lib.scad>;

for(i=[0:3])
  translate([0,i*gLinkSpacing]) Foot();
