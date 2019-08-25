include <tracks_lib.scad>;

difference() {
  offset(r=3,$fn=256) offset(delta=-3) Sprocket(gLinkSpacing, 12);
  circle(d=25.4/2,$fn=256);
}
