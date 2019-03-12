module SlidingTableDemo() {
  linear_extrude(height=gMaterialThick) SlidingTableProfile();
  translate([125,0,20]) rotate([0,-90,0]) linear_extrude(height=gMaterialThick) TowerProfile();
}

module SlidingTableProfile() {
  difference() {
    translate([-125,0]) square([250,300]);
    // TODO: Calculate positions, put in main lib
    translate([0,63]) MiddleSlots(gBitSize, gMaterialThick, gPivotTabs);
    translate([0,182]) MiddleSlots(gBitSize, gMaterialThick, gPivotTabs);

    translate([-125,0]) TabsToLeft([250,300]) EdgeTabF(gBitSize, gMaterialThick, gTowerTabs);
    translate([-125,0]) TabsToRight([250,300]) EdgeTabF(gBitSize, gMaterialThick, gTowerTabs);
  }
}

module TowerProfile() {
  difference() {
    square([300, 100]);
    TabsToLeft([300, 100]) EdgeTabM(gBitSize, gMaterialThick, gTowerTabs);
    hull() for(y=[60,300]) translate([y,100]) circle(d=50,$fn=128);
  }
}
