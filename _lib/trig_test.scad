include <trig.scad>

$fs=1;
r1 = 3;
r2 = 6;
spacing = 10;


translate([0,-20,0]) {
  circle(r=r1);
  translate([spacing,0,0]) circle(r=r1);
  translate(CircleIntersection(r1+r2, r1+r2, spacing))
    circle(r=r2);
}

translate([0,20,0]) {
    circle(r=r1);
    translate([2.5, 7, 0]) circle(r=r1);
    translate(CircleCircleIntersection(
      [0, 0], [2.5, 7], r1, r2)) circle(r=r2);
}


translate([0,60,0]) {
    translate([6, 0]) circle(r=r1);
    translate([0, 12]) circle(r=r1);
    translate(CircleCircleIntersection(
      [6, 0], [0, 12], r1, r2)) circle(r=r2);
}