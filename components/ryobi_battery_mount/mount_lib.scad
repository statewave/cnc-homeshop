gMaterialThick = 18.0;
gCutDepth = -gMaterialThick-0.5;
gBitSize = 4.0;

gPanelDims = [100, 106];
gPanelOff = 23;


// This is the boss at the battery that has a 4th terminal (temp sensing?)
gBossDims = [65, 60];
gBossOff = 0;

gPegDims = [28, 33];
gPegOff = 0;

gSpringDims = [34.5, 8];
gSpringOff = -16.5;

module Layer1() {
  difference() {
    offset(r=6,$fn=256) offset(delta=-6)
      translate([-gPanelDims[0]/2,-gPanelDims[1]+gPanelOff])
      square(gPanelDims);
    PegProfile(false);
  }
}

module PegProfile(include_springs=true) {
  union() {
    translate([-gPegDims[0]/2,-gPegDims[1]+gPegOff]) {
      square([gPegDims[0], gPegDims[1]-gPegDims[0]/2]);
      translate([gPegDims[0]/2, gPegDims[1]-gPegDims[0]/2])
        circle(d=gPegDims[0],$fn=256);
    }
    if(include_springs) {
      translate([-gSpringDims[0]/2,-gSpringDims[1]+gSpringOff])
        square(gSpringDims);
    }
  }
}

module Layer2() {
  difference() {
    t = 12;
    u = 5;
    offset(r=-u,$fn=256) offset(r=t+u, $fn=256) PegProfile();
    PegProfile();
  }
}


Layer1Pocket1Depth = 3.0;
module Layer1Pocket1() {
  translate([-42/2,-72]) square([42, 15]);
}
Layer1Pocket2Depth = 9.0;
module Layer1Pocket2() {
  translate([-gBossDims[0]/2,-gBossDims[1]+gBossOff])
    square(gBossDims);
}

