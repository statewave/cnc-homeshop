gBitSize = 6.35;
gMicroswitchPocketDepth = -7.5;
gCornerRadius = 8;

// For most pieces
gMaterialThick = 12;
gCutDepth = -gMaterialThick-0.5;

// For the slider layer
gMaterialThick2 = 4.2;
gCutDepth2 = -gMaterialThick2-0.5;

// For handle top (to be more inviting to grab)
gMaterialThick3 = 19.0;
gCutDepth3 = -gMaterialThick3-0.5;

gPipeSize = 107;
gTopSizeX = 190;
gTopSizeY = 160;

gSliderStationary = 20;
gSliderSlop = 0.5;
gHandleCircleOffset = 180;
gHandleCircleRadius = 225;
gHandleCircleRadius2 = 193;
gSliderPlateOffset = 365;  // TODO: calculate
gPinDia = 9.65;

module TopProfile() {
  difference() {
    offset(r=gCornerRadius,$fn=256) offset(delta=-gCornerRadius) square([gTopSizeX,gTopSizeY]);
    translate([gTopSizeX/2,gTopSizeY/2]) circle(d=gPipeSize,$fn=256);
  }
}

// TODO: add another pocket or something for where the pins stick through...
module TopPocket(){
  // inset 2.5, becuase of the V shape on the lever, so there's more meat for
  // the screws
  translate([gTopSizeX-16-2.5,30-gBitSize/2])
    square([16+gBitSize,40+gBitSize]);
}

module TopDemo(with_microswitch) {
  difference() {
    linear_extrude(height=gMaterialThick) TopProfile();
    if(with_microswitch)
      translate([0,0,gMaterialThick+gMicroswitchPocketDepth])
        linear_extrude(height=gMaterialThick) offset(r=gBitSize/2,$fn=32) offset(delta=-gBitSize/2) TopPocket();
  }
}

module StationaryProfile() {
  // This radius needs to be > bit radius, in order for the slider to fit well
  // at the extremes.
  offset(r=gCornerRadius,$fn=32) offset(delta=-gCornerRadius) square([gSliderStationary,gTopSizeY]);
}

module StationaryDemo() {
  linear_extrude(height=gMaterialThick2) StationaryProfile();
}

module HandleProfile(with_microswitch) {
  offset(r=gCornerRadius,$fn=32) offset(delta=-gCornerRadius) union() {
    difference() {
      intersection() {
        translate([with_microswitch ? -20 : 0,0]) square([gTopSizeX+(with_microswitch ? 20 : 0), 90]);
        translate([gTopSizeX/2,-gHandleCircleOffset]) circle(r=gHandleCircleRadius,$fn=256);
      }
      translate([gTopSizeX/2,-gHandleCircleOffset]) circle(r=gHandleCircleRadius2,$fn=256);
    }
    if(with_microswitch) {
      rotate([0,0,180]) hull() {
        square([20,1]);
        translate([5,62-20]) circle(d=10,$fn=32);
        translate([20-(15/2),62-(15/2)]) circle(d=15,$fn=32);
      }
    }
  }
}

module HandleHoles() {
  translate([gTopSizeX/2,-gHandleCircleOffset])
    for(r=[18,-18]) rotate([0,0,r])
      #translate([0,(gHandleCircleRadius+gHandleCircleRadius2)/2]) circle(d=gPinDia,$fn=32);
}

module HandleDemo(with_microswitch) {
  translate([gTopSizeX,0]) rotate([0,0,180])
    linear_extrude(height=gMaterialThick3)
      difference() {
        HandleProfile(with_microswitch);
        HandleHoles();
      }
}

module SliderHoles() {
  HandleHoles();
  translate([gTopSizeX,-gTopSizeY*2]) rotate([0,0,180]) HandleHoles();
  translate([gTopSizeX/2,gTopSizeY*-1.5]) circle(d=gPipeSize,$fn=256);
}

module SliderProfile() {
  difference() {
    hull() {
      // Handle side
      HandleProfile();
      // Rear stop
      translate([gTopSizeX,-gTopSizeY*2]) rotate([0,0,180]) HandleProfile();
      //translate([0,-gTopSizeY*2-20]) offset(r=4,$fn=32) offset(delta=-4) square([gTopSizeX,20]);
    }

    // One each side, done this way to copy the radius
    hull() {
      for(x=[-10,gSliderSlop/2], y=[-gTopSizeY,-gTopSizeY*2]) translate([x,y]) StationaryProfile();
    }
    translate([gTopSizeX,0]) scale([-1,1]) hull() {
      for(x=[-10,gSliderSlop/2], y=[-gTopSizeY,-gTopSizeY*2]) translate([x,y]) StationaryProfile();
    }
  }
}

module SliderDemo() {
  translate([gTopSizeX,0]) rotate([0,0,180]) linear_extrude(height=gMaterialThick2) difference () {
    SliderProfile();
    SliderHoles();
  }
}

module CornerRoundingOutline() {
  offset(r=20,$fn=32) square([gTopSizeX,40]);
}

module CornerRoundingPocket() {
  difference() {
    offset(delta=4) CornerRoundingOutline();
    HandleProfile(false);
  }
}
module CornerRoundingJigDemo() {
  difference() {
    linear_extrude(height=gMaterialThick3) CornerRoundingOutline();
    translate([0,0,12]) linear_extrude(height=gMaterialThick3, convexity=4) CornerRoundingPocket();
    translate([0,0,-1]) linear_extrude(height=gMaterialThick3+2) HandleHoles();
  }
}
