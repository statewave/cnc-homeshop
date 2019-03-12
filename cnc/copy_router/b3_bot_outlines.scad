include <copy_router_lib.scad>;

translate([150,0]) BaseProfile();
translate([320,0]) ClampyTop();
translate([320,280]) ClampyProfile();
translate([320+190,280]) ClampyProfile();

translate([780,0]) rotate([0,0,90]) ClampyFrontProfile();
