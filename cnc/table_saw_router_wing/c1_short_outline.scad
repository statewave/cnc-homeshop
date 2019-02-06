include <wing_lib.scad>;

rotate([0,0,-90]) {
  for(y=[0,100]) translate([0,y])
    translate(gShortSideOffset) ShortEdge();
  for(y=[85, 185]) translate([0,y])
    translate(gStiffenerOffset) rotate([0,0,180]) Stiffener();
}
