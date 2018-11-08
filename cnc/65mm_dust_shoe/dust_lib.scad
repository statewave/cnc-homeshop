dia_1 = 65.0;
dia_2 = 48.0;
dia_hose = 31.0;
meat = 10;
back_cut = 6;
angle = 68;
hose_dist = 90;
through_hole_dia = 4.5;
grab_hole_dia = 3.3;


$fn=256;

module SpindleHolePattern(d=grab_hole_dia) {
  $fn=32;
  rotate([0,0,angle]) {
    translate([(dia_1+meat)/2,0]) circle(d=d);
    translate([-(dia_1+meat)/2,0]) circle(d=d);
  }
}

module HoseHolePattern(d=grab_hole_dia, include_big_hole=true) {
  $fn=32;
  translate([hose_dist,0]) union() {
    translate([0, (dia_hose+meat)/2]) circle(d=d);
    translate([0, -(dia_hose+meat)/2]) circle(d=d);
    translate([(dia_hose+meat)/2, 0]) circle(d=d);
    if(include_big_hole) circle(d=dia_hose,$fn=256);
  }
}

module MainTrim() {
  rotate([0,0,angle]) translate([-50,dia_1/2+back_cut]) square([100,100]);
}

module Layer0() {
  difference() {
    circle(d=dia_1+meat*2);
    circle(d=dia_1);
    SpindleHolePattern();
    MainTrim();
  }
}

module Layer0_Hose() {
  difference() {
    translate([hose_dist,0]) circle(d=dia_hose+meat*2);
    HoseHolePattern();
  }
}

module Layer1() {
  difference() {
    hull() {
      circle(d=dia_1+meat*2);
      translate([hose_dist,0]) circle(d=dia_hose+meat*2);
    }
    circle(d=dia_1);
    translate([hose_dist,0]) circle(d=dia_hose);
    SpindleHolePattern(through_hole_dia);
    HoseHolePattern(through_hole_dia);
    MainTrim();
  }
}

module Layer2() {
  difference() {
    hull() {
      circle(d=dia_1+meat*2);
      translate([hose_dist,0]) circle(d=dia_hose+meat*2);
    }
    hull() {
      circle(d=dia_2);
      translate([hose_dist,0]) circle(d=dia_hose);
    }
    SpindleHolePattern(through_hole_dia);
    HoseHolePattern(through_hole_dia);
    MainTrim();
  }
}

module LayerN() {
  difference() {
    hull() {
      circle(d=dia_1+meat*2);
      translate([hose_dist,0]) circle(d=dia_hose+meat*2);
    }
    circle(d=30);
    SpindleHolePattern(through_hole_dia);
    HoseHolePattern(through_hole_dia, false);
    MainTrim();
  }
}


module Demo() {
  translate([0,0,3]) linear_extrude(height=12) Layer0();
  translate([0,0,3]) linear_extrude(height=12) Layer0_Hose();
  color([1,1,1,0.5]) linear_extrude(height=3) Layer1();
  translate([0,0,-12]) linear_extrude(height=12) Layer2();
  translate([0,0,-24]) linear_extrude(height=12) Layer2();
  color([1,1,1,0.5]) translate([0,0,-27]) linear_extrude(height=3) LayerN();
}

module ThickCutPlan() {
  translate([43,204]) Layer0();
  translate([30,190]) Layer0_Hose();
  translate([114,114]) rotate([0,0,-11+180]) Layer2();
  translate([dia_1/2+meat,dia_1/2+meat]) rotate([0,0,-11]) Layer2();
}

module ThinCutPlan() {
  translate([114,114]) rotate([0,0,-11+180]) Layer1();
  translate([dia_1/2+meat,dia_1/2+meat]) rotate([0,0,-11]) LayerN();
}
