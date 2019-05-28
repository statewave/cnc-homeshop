gBitSize = 6.35;
gMaterialThickness = 14.92;
gCutDepth = -gMaterialThickness -0.3;
gPocketDepth = gMaterialThickness / 2;

W = 25;
L1 = 80;
L2 = 160;

module End() {
  for(x_scale=[1,-1]) scale([x_scale,1])
    translate([W/2,0]) circle(d=10,$fn=32);
}

module V() {
  offset(r=2, $fn=32) offset(delta=-2) difference() {
    translate([-W/2,-L2])
      square([W, L1+L2]);
    translate([0,L1]) End();
    translate([0,-L2]) End();
  }
}

module H() {
  offset(r=2, $fn=32) offset(delta=-2) difference() {
    translate([-W/2,-L1])
      square([W, L1*2]);
    translate([0,L1]) End();
    translate([0,-L1]) End();
  }
}


module NV() {
  t = 8;
  offset(r=-gBitSize/2, $fn=64)
    offset(r=gBitSize,$fn=64)
    offset(delta=-gBitSize/2)
  for(x_scale=[1,-1]) scale([x_scale,1]) {
    polygon(points=[[t,t], [W/2, W/2], [W/2, -W/2], [t, -t]]);
    translate([W/2,-20]) square([7,40]);
  }
}

module P1() {
  difference() {
    V();
    NV();
  }
}

module P2() {
  difference() {
    H();
    NV();
  }
}

module P2N() {
  difference() {
    square([34,34], center=true);
    NV();
  }
}

module Demo() {
  difference() {
    linear_extrude(height=gMaterialThickness, convexity=6) P1();
    rotate([0,0,90]) translate([0,0,gMaterialThickness/2]) linear_extrude(height=gMaterialThickness) P2N();
  }
  translate([0,0,gMaterialThickness+0.2]) scale([1,1,-1]) linear_extrude(height=gMaterialThickness) rotate([0,0,90]) P2();
}

module Pocket() {
  translate([W/2,L1]) rotate([0,0,90]) P2N();
  translate([W/2+40,L1]) rotate([0,0,90]) P2N();
}

module Outline() {
  translate([W/2,L1]) rotate([0,0,180]) P1();
  translate([W/2+40,L1]) P2();
}
