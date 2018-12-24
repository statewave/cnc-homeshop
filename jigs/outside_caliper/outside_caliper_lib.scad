include <../../_lib/bezier.scad>;

gMaterialThick = 12;
gCutDepth = -12.2;
gPocketDepth = 6;
gBitSize = 4;
gRealBitSize = 4;

// for 24in
//gPoints = [[10,600], [100, 600], [300, 400], [25, 25]];
//gStartDia = 20;
//gEndDia = 50;
gStartDia = 20;
gEndDia = 50;
gPoints = [[10,300], [60, 300], [150, 200], [gEndDia/2, gEndDia/2]];
gBoltDia = 8.0;
gXOff = 65;

module Leg() {
  pts = bezier_points(gPoints, 0.01);
  max_dist = Magnitude(Sub(pts[len(pts)-1], pts[0]));
  for(i=[0:len(pts)-2]) hull() {
    x1 = Magnitude(Sub(pts[0], pts[i]));
    x2 = Magnitude(Sub(pts[0], pts[i+1]));
    s1 = (gEndDia-gStartDia)*(x1/max_dist)+gStartDia;
    s2 = (gEndDia-gStartDia)*(x2/max_dist)+gStartDia;

    translate(pts[i]) circle(d=s1, $fn=256);
    translate(pts[i+1]) circle(d=s2, $fn=256);
  }
}

module Hole() {
  translate([gEndDia/2,gEndDia/2]) circle(d=gBoltDia,$fn=32);
}

module Pocket() {
  offset(delta=1) intersection() {
    hull() {
      translate([0,gEndDia]) circle(d=gEndDia+1,$fn=256);
      translate([gEndDia/2,gEndDia/2]) circle(d=gEndDia+1,$fn=256);
    }
    Leg();
  }
}

module Repeat(n=4) {
  for(x=[0:n-1]) translate([gXOff*x,0]) render() children();
}
