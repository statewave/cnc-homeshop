gPitch = 20;
gRoundness = 10;

function Width(xCount) = gPitch * (xCount + 1);
function Height(yCount) = gPitch * (yCount + 1);

module Holder(xCount,yCount) {
  w = Width(xCount);
  h = Height(yCount);
  ox = (xCount - 1) / 2 * gPitch;
  difference() {
    translate([-w/2,-gRoundness]) offset(r=gRoundness,$fn=32) offset(delta=-gRoundness) square([w,h+gRoundness]);
    for(i=[0:xCount-1]) translate([i*gPitch-ox,h]) Cutout();
    for(x_scale=[1,-1]) scale([x_scale,1])
      for(i=[0:yCount-1]) translate([-w/2,(i+1)*gPitch]) rotate([0,0,90]) Cutout();
    translate([-100,-20]) square([200,20]);
  }
}

module Cutout() {
  offset(r=-3,$fn=32) offset(delta=3) {
    translate([0,-8]) circle(d=8,$fn=128);
    square([4,20], center=true);
    translate([-10,0]) square([20,20]);
  }
}

module Base(xCount) {
  // Manually add slot or hinges.
  w = Width(xCount);
  translate([-w/2,0]) offset(r=gRoundness,$fn=32) offset(delta=-gRoundness) square([w,w]);
}

module Base2(xCount) {
  intersection() {
    Base(xCount);
    translate([-100,0]) square([200,60]);
  }
}
