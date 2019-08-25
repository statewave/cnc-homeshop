include <../../_lib/edge_tabs.scad>;

gMaterialThick = 18;
gMountThick = 11.8;
gCutDepth = -gMaterialThick-1;
gBitSize = 4;
gPocketDepth = 4;

gLinkSpacing = 60;
gAddendum = 10;
gPivotDia = 25; // this gives 12.5 or 2.5mm gap after gAddendum?
gPivot2Dia = 4.2;
gPivotY = 20;
gFootSpacing = 8;
gFootWidth = 125;


AttTab = [
  [LEFT_EDGE, -50],
  [CTAB, 0, 40],
  [RIGHT_EDGE, 50],
];

module MountProfile(a) {
  difference() {
    union() {
      hull() for(x=[-a/2,a/2]) {
        translate([x,gPivotDia/2+8]) circle(d=gPivotDia, $fn=256);
      }
      translate([-a/2,0]) square([a,10]);
    }
    EdgeTabM(gBitSize, 8, AttTab);
  }
}

module MountProfileHoles(a) {
  for(x=[-a/2,a/2]) translate([x,gPivotDia/2+8]) circle(d=4.2,$fn=32);
}

module Demo() {
  linear_extrude(height=gMaterialThick) MountProfile(gLinkSpacing);
  // TODO calculate the translation
  //translate([0,130]) linear_extrude(height=gMaterialThick) Sprocket(60, 12);
}


module Foot() {
  difference() {
    FootGen();
    offset(delta=gFootSpacing) translate([0,-gLinkSpacing]) FootGen();
  }
}

module FeetDemo(n=3) {
  for(i=[0:n-1])
    translate([0,i*gLinkSpacing,0])
      FootDemo(i);
}

module FootDemo(parity=0) {
  difference() {
    linear_extrude(height=gMountThick) Foot();
    translate([0,0,gMountThick-8]) linear_extrude(height=gMountThick) FootPocket(parity);
  }

  translate([parity%2 == 0 ? gMountThick/2: -gMountThick/2,0]) {
    for(x=[
      gFootWidth/2+gLeaveForSprocket/2+gMountThick/2,
      gFootWidth/2-gLeaveForSprocket/2-gMountThick*1.5,
    ])
    translate([x,34,gMountThick-8])
    rotate([0,90,0]) rotate([0,0,90])
    linear_extrude(height=gMountThick) MountProfile(gLinkSpacing);
  }
}

module FootGen() {
  hull() {
    square([gFootWidth, gLinkSpacing-20]);
    translate([gFootWidth/2-30,gLinkSpacing-10])
      square([60,10]);
  }
}

gLeaveForSprocket = 20;


module FootPocket(parity) {
  translate([parity%2 == 0 ? gMountThick/2: -gMountThick/2,0]) {
    for(x=[
      gFootWidth/2+gLeaveForSprocket/2+gMountThick/2,
      gFootWidth/2-gLeaveForSprocket/2-gMountThick*1.5,
    ])
      translate([x,34]) TabsToLeft([0,0])
        MiddleSlots(gBitSize, gMountThick, AttTab);
  }
}

function RadiusFromPitch(a, n) = (
  a / (2 * sin(180/n)));

module Sprocket(a, n) {
  r = RadiusFromPitch(a, n);
  echo("r=", r);
  c = PI * r * 2;
  difference() {
    rotate([0,0,360/n]) circle(r=r+gAddendum, $fn=n);
    // See _lib/gear.scad
    for(t=[0:360/n:359]) rotate([0,0,t]) render() {
    //for(t=[0]) {
      h = 360/n;
      delta = 4;  // degrees of sprocket rotation
      Rack(r);
      for(u=[0:delta:h])
        RotatedPinHull(u, u+delta, c, r);
      for(u=[0:-delta:-h])
        RotatedPinHull(u, u+delta, c, r);
      RotatedPinHull(-h*0.8, h*0.8, c, r);
    }
  }
}

// TODO this is too tight, need to ease the entry a bit
module RotatedPinHull(u1, u2, c, r) {
  hull() {
    for(u=[u1, u2]) {
      rotate([0,0,u])
      translate([-u*c/360, 0]) render()
        Rack(r);
    }
  }
}

module Rack(r) {
  hull() {
    translate([0, -r]) circle(d=gPivot2Dia+0.3,$fn=256);
  }
}
