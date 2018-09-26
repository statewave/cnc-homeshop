include <lobes.scad>;

$fs=0.5;

Lobes(3, 6, 3, 9);
translate([25,0,0])
  Lobes(9, 10, 2, 2);
translate([0,25,0])
  Lobes(9, 10, 1.45, 2);
translate([-25,0,0])
  Lobes(9, 10, 4, 4);
translate([0,-15,0])
  Lobes(2, 6, 4, 5);
translate([0,-35,0])
  Lobes(4, 6, 4, 5);


