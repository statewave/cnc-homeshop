include <tracks_lib.scad>;

difference() {
  square([120,50]);
  translate([gFootWidth/2,5]) MountProfileHoles(gLinkSpacing);
}
