include <../../_lib/fillets.scad>;
include <shield.scad>;

gMaterialThick = 12;
gCutDepth = gMaterialThick+0.2;
gBitSize = 6.35;
gPocketDepth = 4;

gPinDia = 8;
gEndDia = 30;
// Pin-to-pin
gJointLength = 500;
// Whether this performs as intended is very dependent on the accuracy of
// gPocketDepth in reality -- that is, how well your z is zeroed.
gWasherThickness = 2;
gStartVerticalHeight = 180;
gNumVerticals = 3;
gReduce = gWasherThickness * 2 + gMaterialThick * 2;

// TODO: Angle-limiting
module DogBone() {
  offset(r=-10,$fn=64) offset(delta=10) {
    $fn = 128;
    translate([-12.5,0]) square([25,gJointLength]);
    for(y=[0,gJointLength]) translate([0,y]) circle(d=30);
  }
}

module DogBoneHoles() {
  $fn = 32;
  for(y=[0,gJointLength]) translate([0,y]) circle(d=gPinDia);
}

gVerticalOffset = gEndDia/2+5;
gVerticalLength = gJointLength-gVerticalOffset*2;

module DogBonePocket() {
  // slight fillet on SpikeBox
  offset(r=-1,$fn=32) offset(delta=1)
    translate([-gMaterialThick/2,gVerticalOffset])
    SpikeBox([gMaterialThick,gVerticalLength], gBitSize*1.1);
}

module Vertical(h) {
  intersection() {
    translate([-50,0]) square([gVerticalLength+100,h]);
    offset(r=10) offset(r=-20) offset(r=10) {
      translate([0,-50]) square([gVerticalLength,h+100]);
      translate([-10,30]) square([gVerticalLength+20,h-60]);
    }
  }
}

function vh(i) = gStartVerticalHeight - gReduce * i;
function vo(i) = i == 0 ? 0 : vh(i-1) + vo(i-1) + gBitSize*1.1;

module Verticals() {
  for(i=[0:gNumVerticals-1]) {
    translate([vo(i)+vh(i),10]) rotate([0,0,90]) Vertical(vh(i));
  }
}

module DogBones() {
  t1 = 25;
  t2 = 35;
  pitch = 70;
  for(i=[0:gNumVerticals-1]) {
    translate([i*pitch,0]) children();
    translate([i*pitch+t2,t1]) children();
  }
}

module MountPivot() {
  hull() {
    circle(d=gEndDia,$fn=256);
    translate([0,-gEndDia/2-gPocketDepth-4])
      square([gEndDia*1.5,gPocketDepth], center=true);
  }
}

// TODO not entirely sure these are right, and certainly
// aren't if using a different thickness for the mount
// vs rest of tail.
gMountPivotPositions = [
  -gMaterialThick*2+gPocketDepth-gWasherThickness,
  gStartVerticalHeight-gMaterialThick*2
];

module MountPivotHole() {
  circle(d=gPinDia,$fn=32);
}

gMountPlateZero = [105,61];

module MountPlate() {
  translate([0,35]) scale([1.2,1.2]) Shield();
}
module MountPlatePocket() {
  for(y=gMountPivotPositions) translate([0,y+gMaterialThick/2])
    SpikeBox([gEndDia*1.5,gMaterialThick], gBitSize*1.1, center=true);
}


module MountPlateDemo() {
  difference() {
    linear_extrude(height=gMaterialThick,convexity=4)
    difference() {
      MountPlate();
      //MountPlateHoles();
    }
    translate([0,0,gMaterialThick-gPocketDepth])
      linear_extrude(height=gMaterialThick,convexity=8)
      MountPlatePocket();
  }
}

module MountDemo() {
  for(y=gMountPivotPositions) translate([0,0,y])
    rotate([0,0,-90]) linear_extrude(height=gMaterialThick,convexity=4) difference() {
    MountPivot();
    MountPivotHole();
  }
  translate([-50,0,0]) rotate([90,0,90]) MountPlateDemo();
}
