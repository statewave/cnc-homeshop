gMaterialThick = 12.0;
gBitSize = 4.0;
gPocketDepth = -6.35;
gCutDepth = -gMaterialThick-0.4;

TO_MM = 25.4;

// This is the swoop shape with a small top fillet.  Parameter `h` is the entire
// opening at the tip.  You only need to move it up in Y.
module S1(h) {
  intersection() {
    hull() for(x=[0,0.5], y=[2.5,10]) translate([x*TO_MM, y*TO_MM])
      circle(d=5*TO_MM,$fn=64);
    hull() for(x=[0,2.75], y=[0,h-0.25]) translate([x*TO_MM, y*TO_MM])
      circle(r=0.25*TO_MM,$fn=64);
  }
}

module ASide() {
  difference() {
    square([13.5*TO_MM, 12.75*TO_MM]);
    translate([0,3.75*TO_MM]) S1(5);
    translate([0,10*TO_MM]) S1(4);
  }
}

// y is the bottom of the shelf, measured from the bottom of the side.
module ASideRabbet() {
  for(y=[9])
    translate([-gBitSize/2,y*TO_MM]) square([13.5*TO_MM+gBitSize,0.25*TO_MM]);
}

module BSide() {
  difference() {
    square([13.5*TO_MM, 12.75*TO_MM]);
    translate([0,1*TO_MM]) S1(4.75);
    translate([0,7.25*TO_MM]) S1(6);
  }
}

// y is the bottom of the shelf, measured from the bottom of the side.
module BSideRabbet() {
  for(y=[6])
    translate([-gBitSize/2,y*TO_MM]) square([13.5*TO_MM+gBitSize,0.25*TO_MM]);
}

module CSide() {
  difference() {
    square([13.5*TO_MM, 12.75*TO_MM]);
    translate([0,1*TO_MM]) S1(3);
    translate([0,5.5*TO_MM]) S1(2.75);
    translate([0,9.75*TO_MM]) S1(4);
  }
}

// y is the bottom of the shelf, measured from the bottom of the side.
module CSideRabbet() {
  for(y=[4.25,8.5])
    translate([-gBitSize/2,y*TO_MM]) square([13.5*TO_MM+gBitSize,0.25*TO_MM]);
}


module Demo() {
  difference() {
    linear_extrude(height=gMaterialThick) CSide();
    #translate([0,0,gMaterialThick+gPocketDepth])
      linear_extrude(height=gMaterialThick)
        offset(r=gBitSize/2,$fn=32) offset(delta=-gBitSize/2)
        CSideRabbet();
  }
}
