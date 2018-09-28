include <../../_lib/trig.scad>;
include <../../_lib/repeat.scad>;

pipe_r = 6*25.4/2;
pipe_pos = [120,230];
bottom_r = 50;
bottom_pos = [0,50];
negative_r = 200;
extra = 30;
air_r = 16.75/2;

gMaterialThickness = 12.1;
gBitSize = 6.35;

h = 210;
mount = 60;
cutout_r = 25;
pair_bounding_box = [270,h];

/* These points are of a 3rd circle and its tangent-intersection points with
 * the other two above. */

negative_pos = CircleCircleIntersection3(
  bottom_pos, pipe_pos, bottom_r, pipe_r+extra, negative_r, -1);

intersection1_pos = Lerp(
  bottom_pos, negative_pos,bottom_r/(negative_r+bottom_r));

intersection2_pos = Lerp(
  pipe_pos, negative_pos, (pipe_r+extra)/(negative_r+pipe_r+extra));


module Outline() {
  difference() {
    union() {
      square([1,1]);
      translate(pipe_pos) circle(r=pipe_r+extra,$fn=256);
      translate(bottom_pos) circle(r=bottom_r,$fn=256);
      polygon(points=[bottom_pos, [0,h], pipe_pos, intersection2_pos, intersection1_pos]);
    }
    translate(negative_pos) circle(r=negative_r+0.1,$fn=256);
    translate(pipe_pos) circle(r=pipe_r,$fn=256);
    // back cutout
    hull()
      for(y=[mount+cutout_r,h-mount-cutout_r]) translate([0,y]) circle(r=cutout_r,$fn=128);
    translate([gMaterialThickness+air_r,30]) circle(r=air_r,$fn=128);
    // trim top/left
    translate([0,h]) square([1000,200]);
    translate([-200,0]) square([200,1000]);
    translate([0,-1]) square([1000,1.1]);
  }
}

// slight overlap with outline on left to avoid thin sliver
module Pocket() {
  for(y=[0,h-mount])
    translate([-1,y-gBitSize/2])
    square([gMaterialThickness+1,mount+gBitSize]);

  translate([pipe_pos[0]+pipe_r-gBitSize,h-gMaterialThickness])
    square([extra+gBitSize*1.5,gMaterialThickness+1]);
}

module Mount() {
  translate([0,-mount/2]) square([16,mount]);
}

module Mounts(count=4) {
  for(i=[0:count-1]) translate([i*25,0]) Mount();
}

module EmbeddedMounts() {
  translate([0,h/2]) Mount();
}

// This should be symmetrical, so calling Many() MiddleSection() is fine.
module MiddleSection() {
  // these numbers are hard to make parametric; ideally this should leave a
  // little bit for the outline to remove.
  offset(r=3) difference() {
    translate([pair_bounding_box[0]/2,pair_bounding_box[1]/2])
      rotate([0,0,30]) scale([5,1]) circle(d=25);
    DiagonalFit(pair_bounding_box) offset(delta=4) Outline();
  }
}

module Many() {
  DiagonalFit(pair_bounding_box) children();
  translate([0,h + gBitSize*2])
    DiagonalFit(pair_bounding_box)
    translate([0,h])
    scale([1,-1]) children();
}
