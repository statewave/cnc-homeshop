include <../../_lib/fillets.scad>;

gMaterialThick = 12.2;
gCutDepth = -(gMaterialThick+0.2);
gBitSize = 3.175;
gRealBitSize = gBitSize;

// 500 250 100
gSledLength = 500;
gSledA = 150;
gSledB = 120;
// 100 400
gRabbetPositions = [50, gSledLength/2, gSledLength-50];
gPocketDepth = 6;

module Angle(r=5, inset=5) {
  $fn=32;
  hull() {
    for(p=[[r,r],[r,gSledA-r],[gSledB-r-inset,r]])
      translate(p) circle(r=r);
    for(p=[[0,0],[0,gSledA-1],[gSledB-1-inset,0]])
      translate(p) square([1,1]);
  }

}

module Side() {
  square([gSledA,gSledLength]);
}

module SideRabbets(rabbet_width, rabbet_positions) {
  for(p=rabbet_positions)
    translate([-gBitSize,p-rabbet_width/2])
    SpikeBox([gSledA+gBitSize*2,rabbet_width],gBitSize);
}

module Bottom() {
  square([gSledB+gMaterialThick-gPocketDepth,gSledLength]);
}

module BottomRabbets(rabbet_width, rabbet_positions) {
  for(p=rabbet_positions)
    translate([gMaterialThick-gPocketDepth,p-rabbet_width/2])
    SpikeBox([gSledB-5,rabbet_width],gBitSize);
  translate([-1,-gBitSize/2]) square([rabbet_width+1,gSledLength+gBitSize]);
}
