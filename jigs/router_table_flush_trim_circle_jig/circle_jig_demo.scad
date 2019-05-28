include <circle_jig_lib.scad>;

difference() {
  linear_extrude(height=gJigThick, convexity=4) Outline();
  translate([0,0,gJigThick-gBlockThick]) linear_extrude(height=gBlockThick+1, convexity=4) Slot();
}

translate([50,0]) linear_extrude(height=gBlockThick) BlockOutline();


