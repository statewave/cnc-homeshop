include <domo_lib.scad>;

translate([L/2,0]) Front();
translate([L/2+L+16,0]) Back();

translate([L/2,H+16]) Side();
translate([L/2+L+16,H+16]) Side();
