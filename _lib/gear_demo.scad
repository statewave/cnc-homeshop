include <gear.scad>;

Rack(20, 25, 10, 300);
translate([100,PitchDia(20, 10)[1]/2]) Gear(20, 25, 10, 10);
