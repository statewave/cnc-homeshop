include <copy_router_lib.scad>;

gRot = [-20, 30];

/*
rotate([90,0,0]) LinkDemo(gRot[0], gRot[1]);
translate([0,60,0]) scale([1,-1,1]) rotate([90,0,0]) LinkDemo(gRot[0], gRot[1]);
*/


// Approx slide = 200
BaseDemo(0);
translate([0,0,16-4+45]) SlidingTableDemo();

translate([0,162,16-4+45+16+15]) rotate([0,0,180]) {
  rotate([90,0,0]) LinkDemo(gRot[0], gRot[1]);
  translate([0,60,0]) scale([1,-1,1]) rotate([90,0,0]) LinkDemo(gRot[0], gRot[1]);
}

ClampyDemo();
