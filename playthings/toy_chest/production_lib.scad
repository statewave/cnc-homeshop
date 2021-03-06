include <toy_chest_lib.scad>;

N_FRONT = 1;
N_REST = 7;
PITCH = 280;
SLAT_SPACING = 5;

module Slats(type) {
  spacing = SLAT_SPACING;
  y_base = (gLidFrontWidth+spacing)*N_FRONT;
  for(i=[0:N_FRONT-1]) translate([0,(gLidFrontWidth+spacing)*i]) {
    if(type==0) { LidFrontPocket(); }
    else { LidFrontOutline(); }
  }
  for(i=[0:N_REST-1]) translate([0,(gSlatWidth+spacing)*i+y_base]) {
    if(type==0) { SlatPocket(); }
    else { SlatOutline(); }
  }
}

module FrontSlats(type) {
  spacing = SLAT_SPACING;
  for(i=[0:N_FRONT-1]) translate([0,(gLidFrontWidth+spacing)*i]) {
    if(type==0) { LidFrontPocket(); }
    else { LidFrontOutline(); }
  }
}

module Sides(type) {
  translate([L+gBitSize*3,0]) {
    for(y=[0,H+gBitSize*3]) translate([0,y]) {
      if(type==0) { SidePocket(); }
      else { Side(); }
    }
    translate([W+gBitSize*3,0])
    if(type==0) { BackPocket(); }
    else { Back(); }

    translate([W+gBitSize*3,H+gBitSize*3])
    if(type==0) { BackPocket(); }
    else { Front(); }
  }
}

module OutlinePlate(n, type) {
  translate([0,n*PITCH]) {
    if(type == 0) { Slats(1); }
    else if(type == 1) {
      Sides(1);
      translate([L*2+W*2+gBitSize*8,0]) rotate([0,0,90]) Bottom();
    } else {
      LidSides(2);
    }
  }
}

module SidePocketPlate(n, type=1) {
  translate([0,n*PITCH]) {
    Slats(0);
    if(type==1) Sides(0);
  }
}

module BottomFakePocketDemo(n) {
  difference() {
    offset(delta=gBitSize) FirstFakePocket(n);
    FirstFakePocket(n);
  }
  difference() {
    offset(delta=gBitSize) SecondFakePocket(n);
    SecondFakePocket(n);
  }
}

module LidSides(type) {
  for(yi=[0,1,2]) translate([L*2+W*2+gBitSize*8,yi*W*0.4])
    if(type==0) { LidSide(false); }
    else if(type==1) { offset(delta=gBitSize*0.8) LidSide(false); }
    else { LidSide(true, yi); }
}

module FirstFakePocket(n) {
  translate([0,n*PITCH]) {
    LidSides(0);
    translate([L*2+W*2+gBitSize*8,0]) rotate([0,0,90]) Bottom2();
  }
}
module SecondFakePocket(n) {
  translate([0,n*PITCH]) {
    LidSides(1);
    offset(delta=gBitSize*0.8) translate([L*2+W*2+gBitSize*8,0]) rotate([0,0,90]) Bottom2();
  }
}

module ProdDemo() {
  for(n=[0:3]) {
    difference() {
      linear_extrude(height=gMaterialThick, convexity=6) {
        for(j=[0:2]) OutlinePlate(n, j);
      }
      translate([0,0,gMaterialThick-gSidePocketDepth]) linear_extrude(height=gMaterialThick, convexity=6) SidePocketPlate(n);
      translate([0,0,gBotPocketDepth]) linear_extrude(height=gMaterialThick, convexity=6) BottomFakePocketDemo(n);
    }
  }
}

module ProdDemoFlat() {
  for(n=[0,1,2,3]) {
    for(j=[0,1,2]) {
      OutlinePlate(n, j);
    }
  }
}
