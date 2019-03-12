module RouterLinkDemo(a1) {
  translate([sin(a1)*gLinkage[0],cos(a1)*gLinkage[0]])
  difference() {
    linear_extrude(height=gLinkThick) difference() {
      RouterLink();
      RouterLinkHoles();
    }
    translate([0,0,-gLinkThick+gPocketDepth]) linear_extrude(height=19,convexity=8)
      RouterLinkPocket();
  }
}

module LongLinkDemo() {
    difference() {
    linear_extrude(height=gLinkThick) difference() {
      LongLink();
      LongLinkHoles();
    }
    translate([0,0,-gLinkThick+gPocketDepth]) linear_extrude(height=19,convexity=4)
      #LongLinkPocket();
  }
}

module LinkDemo(a1, a2) {
  // TODO pivot is wrong
  rotate([0,0,a2]) {

    RouterLinkDemo(a1);
    linear_extrude(height=19)
      translate([sin(a1)*gLinkage[0],cos(a1)*gLinkage[0]])
      RouterClamp();

    LongLinkDemo();

    translate([0,0,-20]) rotate([0,0,90-a1])
    difference() {
      linear_extrude(height=gLinkThick) difference() {
        ShortLink();
        ShortLinkHoles();
      }
      translate([0,0,-gLinkThick+gPocketDepth]) linear_extrude(height=gLinkThick, convexity=4)
        ShortLinkPocket();
    }

    translate([gLinkage[1],0,-20]) rotate([0,0,90-a1]) translate([gLinkage[0],0]) difference() {
      linear_extrude(height=gLinkThick,convexity=6) difference() {
        HandleLink();
        HandleLinkHoles();
      }
      translate([0,0,-gLinkThick+gPocketDepth]) linear_extrude(height=19) HandleLinkPocket();
      // Fix origin first...
      //#translate([0,0,-19+4]) linear_extrude(height=19) ShortLinkPocket();
    }
  }
}

module RouterLink() {
  difference() {
    RouterLinkInner();
    if(gBulk>0)
      offset(r=3,$fn=32) offset(delta=-gBulk+3) RouterLinkInner();
  }
}

module RouterLinkInner() {
  difference() {
    hull() {
      for(x=[0,gLinkage[1]]) translate([x,0]) circle(d=gLinkageWidth,$fn=64);
      intersection() {
        translate([gLinkage[0],0]) circle(d=gRouterDia+gBulk*2,$fn=256);
        translate([0,-100]) square([1000,100]);
      }
    }
    translate([gLinkage[0],0]) circle(d=gRouterDia,$fn=256);
  }
}

module RouterLinkPocket() {
  translate([gLinkage[1]/2,0]) for(r=[-5,-90,180+5])
    rotate([0,0,r]) translate([gRouterDia/2+9,0])
    SpikeBox([gWebbingThick, 25], gBitSize, center=true);
}

module RouterLinkHoles() {
  // Until origins change, this is the same.
  LongLinkHoles();
}


module RouterClamp() {
  difference() {
    intersection() {
      hull() for(x=[-25,25]) translate([gLinkage[0]+x,gLinkageWidth/2])
        circle(d=80,$fn=256);
      // the 5 here is a reduction to allow clamping to deform that much
      translate([0,gLinkageWidth/2+5]) square([1000,100]);
    }
    // Slightly larger cutout here because it's expected to flex and become
    // smaller effective radius; this should cause center contact first.
    translate([gLinkage[0],0]) circle(d=gRouterDia+2,$fn=256);
  }
}


module LongLink() {
  hull()
    for(x=[0,gLinkage[1]]) translate([x,0]) circle(d=gLinkageWidth,$fn=64);
}

module LongLinkPocket() {
  x_inset = gWebsInset[1];
  translate([x_inset/2,-gWebbingThick/2])
    SpikeBox([gLinkage[1]-x_inset,gWebbingThick], gBitSize);
}

module LongLinkHoles() {
  for(x=[0,gLinkage[1]]) translate([x,0]) circle(d=gPivotSize,$fn=64);
}


module ShortLink() {
  hull()
    for(x=[0,gLinkage[0]]) translate([x,0]) circle(d=gLinkageWidth,$fn=64);
}

module ShortLinkPocket() {
  x_inset = gWebsInset[0];
  translate([x_inset/2,-gWebbingThick/2])
    SpikeBox([gLinkage[0]-x_inset,gWebbingThick], gBitSize);
}

module ShortLinkHoles() {
  for(x=[0,gLinkage[0]]) translate([x,0]) circle(d=gPivotSize,$fn=64);
}


module HandleLink() {
  translate([-gLinkage[0],0]) hull()
    for(x=[0,gLinkage[1]]) translate([x,0]) circle(d=gLinkageWidth,$fn=64);
}

module HandleLinkPocket() {
  translate([20,-19/3]) SpikeBox([gLinkage[1]-gLinkage[0],19], gBitSize);
}

module HandleLinkHoles() {
  translate([-gLinkage[0],0]) {
    for(x=[0, gLinkage[0]]) translate([x,0]) circle(d=gPivotSize,$fn=64);
    translate([gLinkage[1],0]) circle(d=gFollowerSize,$fn=64);
  }
}

