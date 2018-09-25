include <../../_lib/trig.scad>;

pipe_r = 6*25.4/2;
pipe_pos = [120,20];
bottom_r = 50;
bottom_pos = [0,-160];
negative_r = 200;
extra = 30;

/* These points are of a 3rd circle and its tangent-intersection points with
 * the other two above. */

negative_pos = CircleCircleIntersection3(
  bottom_pos, pipe_pos, bottom_r, pipe_r+extra, negative_r, -1);

intersection1_pos = Lerp(bottom_pos, negative_pos, negative_r/(negative_r+bottom_r));
intersection2_pos = Lerp(pipe_pos, negative_pos, negative_r/(negative_r+pipe_r+extra));


module Outline() {
  difference() {
    union() {
      translate(pipe_pos) circle(r=pipe_r+extra,$fn=256);
      translate(bottom_pos) circle(r=bottom_r,$fn=256);
      polygon(points=[[0,0],bottom_pos,negative_pos,pipe_pos]);
    }
    translate(negative_pos) circle(r=negative_r,$fn=256);
    translate(pipe_pos) circle(r=pipe_r,$fn=256);
    // back cutout
    hull()
      for(y=[-80,-120]) translate([0,y]) circle(r=25);
    // trim top/left
    square([1000,1000]);
    translate([-1000,-1000]) square([1000,1000]);
  }
}


