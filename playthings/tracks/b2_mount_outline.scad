include <tracks_lib.scad>;

for(i=[0:5]) {
  translate([0,i*40]) MountProfile(gLinkSpacing);
}
