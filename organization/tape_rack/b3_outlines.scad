include <tape_rack_lib.scad>;

translate([gDepth+5,0]) for(x_scale=[1,-1]) scale([x_scale,1])
  translate([5,0]) Side();

for(i=[1,2])
  translate([0,(gHeight+20)*i]) Front();
