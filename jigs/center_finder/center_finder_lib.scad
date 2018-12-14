include <../../_lib/fillets.scad>;
include <../../_lib/bezier.scad>;
include <../../_lib/trig.scad>;

gRealBitSize = 4.0;
gMaterialThick = 12;
gCutDepth = -(gMaterialThick+0.2);
gBitSize = 4.1;
gLength = 280;
gSide = 130;
gBulk = 30;
gRound = 10;
gHole = 4.1;
gThroughHole = 4.2;
gHoleLocs = [0.15, 0.55, 0.95];

gPoints = [[20, 20], [75,30], [120, 20], [160,-10]];
gStartDia = 40;
gEndDia = 20;
gOff = gEndDia/2-gPoints[len(gPoints)-1][1];

module Corner() {
  translate([gOff,gOff]) CornerInner();
}

module CornerInner() {
  pts_r = bezier_points(gPoints, 0.01);
  pts_l = [for(p=pts_r) [p[1],p[0]]];
  max_dist = Magnitude(Sub(pts_r[len(pts_r)-1], pts_r[0]));
  for(pts=[pts_r,pts_l])
    for(i=[0:len(pts)-2]) hull() {
      x1 = Magnitude(Sub(pts[0], pts[i]));
      x2 = Magnitude(Sub(pts[0], pts[i+1]));
      s1 = (gEndDia-gStartDia)*(x1/max_dist)+gStartDia;
      s2 = (gEndDia-gStartDia)*(x2/max_dist)+gStartDia;

      translate(pts[i]) circle(d=s1, $fn=256);
      translate(pts[i+1]) circle(d=s2, $fn=256);
    }

  //for(p=gPoints) translate(p) circle(d=30);
}

module CornerHoles(d=gHole) {
  for(t=gHoleLocs) {
    p = _bezier_reduce(gPoints, t);
    translate([gOff,gOff]) translate([p[1],p[0]]) circle(d=d,$fn=32);
  }
}


module Outline() {
  translate([0,50]) rotate([0,0,-10]) Corner();
  translate([190,0]) rotate([0,0,45]) Top();
}

module Holes() {
  translate([0,50]) rotate([0,0,-10]) CornerHoles();
  translate([190,0]) rotate([0,0,45]) CornerHoles();
}

module Top() {
  pts_r = bezier_points(gPoints, 0.01);
  pts_l = [for(p=pts_r) [p[1],p[0]]];
  max_dist = Magnitude(Sub(pts_r[len(pts_r)-1], pts_r[0]));
  difference() {
    union() {
      // clean up back side
      Corner();
      translate([gOff,gOff]) for(i=[0:len(pts_l)-1]) hull() {
        x1 = Magnitude(Sub(pts_l[0], pts_l[i]));
        s1 = (gEndDia-gStartDia)*(x1/max_dist)+gStartDia;
        hull() {
          translate(pts_l[i]) circle(d=s1, $fn=256);
          rotate([0,0,45]) translate([gLength,0]) circle(r=gRound,$fn=32);
        }
      }
    }
    translate([gOff,gOff]) rotate([0,0,-45]) square([1000,1000]);
  }
}

module TopHoles() {
  CornerHoles(gThroughHole);
}

module Demo() {
  linear_extrude(height=gMaterialThick) difference() {
    Corner();
    CornerHoles();
  }
  translate([0,0,gMaterialThick+1]) linear_extrude(height=gMaterialThick)
    difference() {
    Top();
    TopHoles();
  }
}

module SingleOutline(s=1.0) {
  scale([s,s]) Corner();
  scale([s,s]) Top();
}

module TopDiff(s=1.0) {
  difference() {
    offset(r=gBitSize/2)
      scale([s,s]) difference() {
      offset(delta=-1) render() Top();
      render() Corner();
    }
    scale([s,s]) render() Corner();
  }
}
