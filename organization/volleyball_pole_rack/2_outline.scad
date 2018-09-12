include <volleyball_pole_rack.scad>;

translate([-5,-5]) square([0.1,0.1]);

translate([0,170+30]) rotate([0,0,-90]) Profile();
translate([160,170+70+30]) rotate([0,0,90]) Profile();
translate([170,180]) rotate([0,0,-90]) Back();
translate([195,370]) Front();

translate([55,0]) Vertical(false);
translate([0,430]) Vertical(false);
translate([0,480]) Vertical();
translate([100,480]) Vertical();
