include <dust_pipe_tail_lib.scad>;

module Part1() {
  difference() {
    linear_extrude(height=gMaterialThick, convexity=6) difference() {
      DogBone();
      DogBoneHoles();
    }
    translate([0,0,gMaterialThick-gPocketDepth])
      linear_extrude(height=gMaterialThick, convexity=4) DogBonePocket();
  }
}

module Part2(h) {
  translate([gVerticalOffset,gMaterialThick/2,0]) rotate([90,0,0]) linear_extrude(height=gMaterialThick) Vertical(h);
}

remaining_after_pocket = gMaterialThick-gPocketDepth;

module Part12(h) {
  translate([0,0,-remaining_after_pocket]) Part1();
  translate([0,0,h+gPocketDepth]) rotate([180,0,0]) Part1();
  Part2(h);
}

Part12(150);
translate([gJointLength,0,gReduce/2]) rotate([0,0,20]) {
  Part12(150-gReduce);
  translate([gJointLength,0,gReduce/2]) rotate([0,0,20]) Part12(150-gReduce*2);
}



