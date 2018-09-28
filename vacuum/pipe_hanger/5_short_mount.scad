include <pipe_hanger_lib.scad>;

square([1,1]);
translate([5,extra/2+4])
  Pattern(x_count=4, y_count=6, x_pitch=25, y_pitch=40)
  ShortMount();
