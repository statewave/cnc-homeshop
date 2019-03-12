include <wing_lib.scad>;

rotate([0,0,-90]) {
  for(y=[0,110]) translate([0,y])
    translate(gShortSideOffset) ShortEdge();
  for(y=[100, 210]) translate([0,y])
    translate(gStiffenerOffset) rotate([0,0,180]) Stiffener();
}
