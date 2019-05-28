gJigThick = 18.0;
gBlockThick = 12.0;
gBlockWidth = 12.0;
gBlockLength = 40.0;
gSlotWidth = 7.0;
gBitSize = 6.35;

gCutDepth = -gJigThick - 0.2;
gPocketDepth = -gBlockThick - 0.5;
gBlockDepth = -gBlockThick - 0.5;

gJigWidth = 32;
gJigLength = 400;
gFlushTrimBearingDia = 0.5*25.4;
gMargin = 8;

module Outline() {
  offset(r=2,$fn=32) offset(delta=-2) difference() {
    hull() {
      square([gJigWidth,1]);
      translate([gJigWidth/2,gJigLength-gJigWidth/2]) circle(d=gJigWidth,$fn=256);
    }
    hull()
      for(y=[gFlushTrimBearingDia*0.75,-gFlushTrimBearingDia])
      translate([gJigWidth/2,y]) 
      circle(d=gFlushTrimBearingDia,$fn=128);
    hull() for(y=[45,gJigLength-30])
      translate([gJigWidth/2,y]) circle(d=gSlotWidth,$fn=32);
  }
}

module Slot() {
  hull() for(y=[30,gJigLength-15])
    translate([gJigWidth/2,y]) circle(d=gBlockWidth,$fn=32);
}

module BlockOutline() {
  hull() {
    circle(d=gBlockWidth,$fn=256);
    translate([0,gBlockLength-gBlockWidth]) circle(d=gBlockWidth,$fn=256);
  }
}
