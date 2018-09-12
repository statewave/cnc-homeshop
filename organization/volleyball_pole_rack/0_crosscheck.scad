include <volleyball_pole_rack.scad>;

difference() {
    linear_extrude(height=18) import("out/2_outline.dxf", convexity=99);

translate([0,0,18-back_rabbet]) linear_extrude(height=10) 
  offset(r=2,$fn=32) offset(delta=-2) difference() {
      square([400,600]);
      import("out/1_pocket.dxf", convexity=99);
  }
  }