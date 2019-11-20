include <dust_gate_lib.scad>;

TopDemo(true);
translate([0,0,-5]) StationaryDemo();
color([0.5,1.0,0.5]) translate([0,0,-5]) SliderDemo();
color([0.5,0.5,1.0]) HandleDemo(true);
