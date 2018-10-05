gFlangeExtra = 3;
gFlangeThick = 3;
gRamp = 1;
e = 0.01;

module Grommet(cable_od, hole_id) {
  $fn=256;
  difference() {
    union() {
      cylinder(d=hole_id+gFlangeExtra*2, h=gFlangeThick);
      translate([0,0,gFlangeThick-e]) cylinder(d1=hole_id,d2=hole_id+gRamp, h=2);
      translate([0,0,gFlangeThick-e+2]) cylinder(d1=hole_id+gRamp, d2=hole_id, h=2);
    }
    translate([0,0,-1]) cylinder(d=cable_od,h=100);
  }
}

module Mask() {
  polygon(points=[[0, -1], [0,gFlangeThick], [2, gFlangeThick+2], [0, gFlangeThick+4.01], [100, gFlangeThick+4.01], [100, -1]]);

}

module Halves(cable_od, hole_id, spacing, cutout) {
  intersection() {
    Grommet(14, 20);
    rotate([90,0,0]) translate([cutout/2,0,-100]) linear_extrude(convexity=6, height=200) Mask();
  }

  translate([-spacing,0,0]) difference() {
    Grommet(14, 20);
    rotate([90,0,0]) translate([-cutout/2,0,-100]) linear_extrude(convexity=6, height=200) Mask();
  }
}

Halves(14, 20, 2, 1);
