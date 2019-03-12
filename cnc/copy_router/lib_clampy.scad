// TODO tilting table

module ClampyProfile() {
  difference() {
    square([gTableHigh,230]);
    TabsToLeft([gTableHigh,230]) EdgeTabM(gBitSize, gMaterialThick, gBaseLongEdgeTabs);
    translate([gTableHigh-100,0]) EdgeTabM(gBitSize, gMaterialThick, gClampyFrontTabs);
    TabsToRight([gTableHigh, 230]) EdgeTabM(gBitSize, gMaterialThick, gBaseLongEdgeTabs);
  }
}

module ClampyFrontProfile() {
  difference() {
    square([300,100]);
    TabsToLeft([300, 100]) EdgeTabF(gBitSize, gMaterialThick, gClampyFrontTabs);
    TabsToRight([300, 100]) EdgeTabF(gBitSize, gMaterialThick, gClampyFrontTabs);
    hull() for(x=[60,110]) translate([x,40]) circle(d=35,$fn=128);
    hull() for(x=[300-60,300-110]) translate([x,40]) circle(d=35,$fn=128);
    hull() for(x=[10+gMaterialThick, 300-10-gMaterialThick]) translate([x,0]) circle(r=10,$fn=128);

    TabsToTop([300, 100]) EdgeTabM(gBitSize, gMaterialThick, gBaseShortEdgeTabs);
  }
}

module ClampyTop() {
  difference() {
    square([340,260]);
    translate([20, 30]) MiddleSlots(gBitSize, gMaterialThick, gBaseShortEdgeTabs);
    translate([20, 30]) TabsToLeft([300, 230]) MiddleSlots(gBitSize, gMaterialThick, gBaseLongEdgeTabs);
    translate([20, 30]) TabsToRight([300, 230]) MiddleSlots(gBitSize, gMaterialThick, gBaseLongEdgeTabs);
  }
}

module ClampyDemo() {
  for(x_scale=[1,-1]) scale([x_scale,1])
    translate([150,540-230,0]) rotate([0,-90,0])
    linear_extrude(height=gMaterialThick) ClampyProfile();
  translate([-150,540-230+gMaterialThick,gTableHigh-100]) rotate([90,0,0])
    linear_extrude(height=gMaterialThick) ClampyFrontProfile();
  translate([-170,540-230-30,gTableHigh-10]) linear_extrude(height=gMaterialThick) ClampyTop();
}
