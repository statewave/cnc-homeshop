include <tracks_lib.scad>;

FeetDemo(10);

translate([54,0,140]) rotate([0,90,0]) linear_extrude(height=gMaterialThick) Sprocket(gLinkSpacing, 12);
