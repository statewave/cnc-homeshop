include <../../_lib/fillets.scad>;

gMaterialThick = 12.2;
gBitSize = 6.35*1.1;
gPocketDepth = 4;

gPinDia = 8;
gEndDia = 30;
// Pin-to-pin
gJointLength = 305;
gWasherThickness = 3;
gStartVerticalHeight = 180;
gNumVerticals = 6;
gReduce = gWasherThickness * 2 + gMaterialThick * 2;

// TODO: Angle-limiting
module DogBone() {
  offset(r=-10,$fn=64) offset(delta=10) {
    $fn = 128;
    translate([0,-12.5]) square([gJointLength,25]);
    for(x=[0,gJointLength]) translate([x,0]) circle(d=30);
  }
}

module DogBoneHoles() {
  $fn = 32;
  for(x=[0,gJointLength]) translate([x,0]) circle(d=gPinDia);
}

gVerticalOffset = gEndDia/2+5;
gVerticalLength = gJointLength-gVerticalOffset*2;

module DogBonePocket() {
  offset(r=-1,$fn=32) offset(delta=1)
    translate([gVerticalOffset,-gMaterialThick/2])
    SpikeBox([gVerticalLength,gMaterialThick], gBitSize);
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

// TODO: The 50 here might be because of a bug.
function vh(i) = gStartVerticalHeight - gReduce * i;
function vo(i) = i == 0 ? 0 : vh(i-1) + vo(i-1) + gBitSize;

module Verticals() {
  for(i=[0:gNumVerticals-1]) {
    translate([10,vo(i)]) Vertical(vh(i));
  }
}

module DogBones() {
  t1 = 25;
  t2 = 35;
  pitch = 90;
  for(i=[0:gNumVerticals-1]) {
    translate([0,i*pitch]) children();
    translate([t1,i*pitch+t2]) children();
  }
}
