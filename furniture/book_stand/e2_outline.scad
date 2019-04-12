include <book_stand_lib.scad>;

h = gPaverHeight+gMaterialThick*2;

translate([h,0,0]) rotate([0,0,90]) SideOutline();
translate([h*2+gBitSize*3,0,0]) rotate([0,0,90]) SideOutline();
translate([h*3+gBitSize*6,0,0]) rotate([0,0,90]) BackOutline();
translate([h*4+gBitSize*9,0,0]) rotate([0,0,90]) BackOutline();
