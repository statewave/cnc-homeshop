gTipLength = 50;
module FixedProfile(hole_size=4, include_path=true, include_flexure=false) {
  difference() {
    offset(r=5,$fn=32) offset(delta=-5) square([60,60]);
    if(include_path) translate([-1,20]) square([100,30]);
    if(include_flexure) {
      points=[[25,45], [25,6], [45,6], [45,45]];
      for(i=[0:len(points)-2]) hull() {
        translate(points[i]) circle(d=3.2,$fn=32);
        translate(points[i+1]) circle(d=3.2,$fn=32);
      }
    }
    for(p=[[10,10], [50,10], [10,55], [50,55]]) translate(p) circle(d=hole_size,$fn=32);
    translate([35,16]) circle(d=6,$fn=32);
  }
}

module FixedJawProfile() {
  FixedProfile();
  polygon(points=[[0,55], [0,60+gTipLength], [20, 40+gTipLength], [20,65], [25, 60], [5, 60]]);
}

module MovableJawProfile() {
  square([450,30]);
  polygon(points=[[0,30], [0,20+gTipLength], [20,40+gTipLength], [20,30]]);
}
