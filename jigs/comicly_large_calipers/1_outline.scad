include <calipers_lib.scad>;

translate([35,140]) FixedJawProfile();
translate([35,70]) FixedProfile(include_path=false,include_flexure=true);
translate([35,0]) FixedProfile(include_path=false);
translate([0,450]) rotate([0,0,-90]) MovableJawProfile();
