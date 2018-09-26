include <trig.scad>;

//$fs=0.5;
//$fn=300;

function PositivePos(count, main_r, i) =
  [cos(-360/count*i)*main_r, sin(-360/count*i)*main_r];

function FirstNegativePos(count, main_r, r1, r2) = 
    CircleCircleIntersection(
      PositivePos(count, main_r, 0),
      PositivePos(count, main_r, 1), r1, r2);

module Positive(count, main_r, r1, r2) {
  // a polygon, basically, of the points of intersection (since otherwise, you
  // can see flats).
  // TODO: this should be a proper polygon, rather than tiny circles -- find a
  // way to do this without 2015.03
  hull() for(i=[1:count]) {
    translate(CircleCircleIntersectionPoint(
      PositivePos(count, main_r, i),
      PositivePos(count, main_r, i+1), r1, r2,
      PositivePos(count, main_r, i)
    )) circle(r=0.1,$fn=6);
    translate(CircleCircleIntersectionPoint(
      PositivePos(count, main_r, i),
      PositivePos(count, main_r, i+1), r1, r2,
      PositivePos(count, main_r, i+1)
    )) circle(r=0.1,$fn=6);
  }
  // the outward-pointing circles
  for(i=[1:count])
    translate(PositivePos(count, main_r, i)) circle(r=r1);
}

module Negative(count, main_r, r1, r2) {
  // just the inward-pointing circles
  for(i=[1:count])
    rotate([0,0,360/count*i])
      translate(FirstNegativePos(count, main_r, r1, r2))
        circle(r=r2);
}

// r1=outward circle radius, r2=inward circle radius
module Lobes(count, main_r, r1, r2) {
  difference() {
    Positive(count, main_r, r1, r2);
    Negative(count, main_r, r1, r2);
  }
}
