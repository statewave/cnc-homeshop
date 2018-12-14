include <center_finder_lib.scad>;

difference() {
  linear_extrude(height=12, convexity=4) SingleOutline();
  #translate([0,0,6]) linear_extrude(height=12, convexity=4) 
    offset(r=gBitSize/2,$fn=32) offset(delta=-gBitSize/2) TopDiff();
}
