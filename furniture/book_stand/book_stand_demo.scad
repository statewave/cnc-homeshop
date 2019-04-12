include <book_stand_lib.scad>;

explode = 0;

translate([0,0,gPaverHeight+gMaterialThick]) BaseDemo();
translate([0,0,gMaterialThick]) scale([1,1,-1]) BaseDemo();

translate([0,100,0]) rotate([90,0,0]) difference() {
  linear_extrude(height=gMaterialThick) V1();
  translate([0,0,-6]) linear_extrude(height=gMaterialThick) V1Pocket();
}
for(i=[1:12-1])
  translate([0,100+i*gMaterialThick,0])
  rotate([90,0,0]) linear_extrude(height=gMaterialThick) difference() {
    V1aSlice();
    V1aHoles();
  }

for(i=[1:12-1])
  translate([0,100+i*gMaterialThick,0])
  rotate([90,0,0]) linear_extrude(height=gMaterialThick) difference() {
    V1bSlice();
    V1bHoles();
  }

translate([x_total/2+gColumnWide/2-gMaterialThick+explode,100-gMaterialThick,gBotHeight]) rotate([0,0,90]) rotate([90,0,0]) difference() {
  linear_extrude(height=gMaterialThick,convexity=12) V2();
  translate([0,0,6]) linear_extrude(height=gMaterialThick) for(i=[0,1]) V2FakePocketDemo(i);
}

translate([0,-100,0]) SideDemo();
