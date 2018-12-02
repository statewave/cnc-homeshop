include <gear.scad>;

demo_teeth = 10;

Rack(20, 25, 10, 300);
translate([100,PitchRadius(20, demo_teeth)]) Gear(20, 25, 10, demo_teeth);
