include <../../_lib/fillets.scad>;

gMaterialThick = 12.2;
gBitSize = 6.35*1.1;
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
    SpikeBox([gMaterialThick,gVerticalLength], gBitSize);
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
function vo(i) = i == 0 ? 0 : vh(i-1) + vo(i-1) + gBitSize;

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
