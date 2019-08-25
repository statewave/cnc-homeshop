gMaterialThick = 12.2;
gCutDepth = -gMaterialThick-1;
gBitSize = 6.35;
gPocketDepth = 3;

gSizes1 = [
  [15, 8],
  [16, 8],
  [17, 8],
  [18, 8],
  [19, 8],
  [20, 8],
  [21, 8],
  [22, 8],
  [23, 8],
  [24, 8],
  [25, 10],
];

gSizes2 = [
  [26, 10],
  [28, 10],
  [30, 10.8],
  [32, 10.8],
  [35, 10.8],
  [38, 10.8],
  [40, 11],
];

gSpace = 6;

function xPos(i, lst) = i == 0 ? (lst[i][0]/2+gSpace) : xPos(i-1, lst) + lst[i][0] + gSpace;

$fn = 32;

module Demo(lst, d) {
  difference() {
    linear_extrude(height=gMaterialThick, convexity=len(lst)*2) Outline(lst, d);
    translate([0,0,gMaterialThick-gPocketDepth])
      linear_extrude(height=gMaterialThick, convexity=len(lst)*2) Pocket(lst);
  }
}

module PlatePockets() {
  Pocket(gSizes1);
  translate([0,60]) Pocket(gSizes2);
}

module PlateOutlines() {
  Outline(gSizes1, 40);
  translate([0,60]) Outline(gSizes2, 60);
}

module Outline(lst, d) {
  offset(r=2) offset(delta=-2) difference() {
    translate([0,0]) square([300,d]);
    for(i=[0:len(lst)-1]) {
      hull() {
        translate([xPos(i, lst), lst[i][0]/2]) circle(d=lst[i][1]);
        translate([xPos(i, lst), 0]) circle(d=lst[i][1]+2);
      }
    }
  }
}

module Pocket(lst) {
  for(i=[0:len(lst)-1]) {
    translate([xPos(i, lst), lst[i][0]/2]) circle(d=lst[i][0]+1);
  }
}
