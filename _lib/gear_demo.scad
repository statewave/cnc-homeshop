include <gear.scad>;

demo_teeth = 10;
demo_rot = 0;

Rack(20, 25, 10, 300);
translate([demo_rot/360*3.14159*PitchRadius(20, demo_teeth)*2,0])
  translate([100,PitchRadius(20, demo_teeth)])
  rotate([0,0,-demo_rot])
  Gear(20, 25, 10, demo_teeth);
