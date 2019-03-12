module BaseHoles() {
  translate(gRail1Pos) RailHoles(SBR16, 300);
  translate(gRail2Pos) RailHoles(SBR16, 500);
}

module BasePocket() {
  translate(gRail1Pos) RailPocket(SBR16, 300, gBitSize);
  translate(gRail2Pos) RailPocket(SBR16, 500, gBitSize);
}

module BaseDemo(slide_pos=0) {
  difference() {
    linear_extrude(height=gMaterialThick,convexity=6) difference() {
      BaseProfile();
      BaseHoles();
    }
    translate([0,0,gMaterialThick-gPocketDepth]) linear_extrude(height=16,convexity=8) {
      BasePocket();
    }
  }
  translate([0,0,gMaterialThick-gPocketDepth]) color([0,0.6,0,0.5]) {
    translate(gRail1Pos) RailDemo(SBR16, 300);
    translate(gRail2Pos) RailDemo(SBR16, 500);
  }
  translate([0,0,gMaterialThick-gPocketDepth]) color([0,0,0.6,0.5]) {
    translate(gRail1Pos) for(y=gRail1Blocks)
      RailBlockDemo(SBR16, y+slide_pos);
    translate(gRail2Pos) for(y=gRail2Blocks)
      RailBlockDemo(SBR16, y+slide_pos);
  }
}

module BaseProfile() {
  difference() {
    translate([-150,0]) square([300,540]);
    for(x_scale=[1,-1]) scale([x_scale, 1])
      translate([-150,540-230]) TabsToRight([300, 540]) EdgeTabF(gBitSize, gMaterialThick, gBaseLongEdgeTabs);
  }
}


