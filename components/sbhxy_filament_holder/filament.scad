w = 35;
w2 = 24;
h = 30;

linear_extrude(height=h)
offset(r=2,$fn=32) offset(delta=-2)
polygon(points=[
  [-20, -12], [-10,-12], [w/2,-5], [w/2, 0], [w/2+7,0], [w/2+7, 6], [-w/2, 6], [-w/2,-6.5], [-30,-6.5],
]);

intersection() {
  translate([-w2/2,0,0]) linear_extrude(height=h)
    offset(r=2,$fn=32) offset(delta=-2)
    polygon(points=[
      [0,0], [w2,0], [w*0.4,100], [0,100],
    ]);
  union() {
    translate([20,0,h/2]) rotate([-90,0,0]) cylinder(d=60,h=120,$fn=128);
    translate([20,95,h/2]) rotate([-90,0,0]) cylinder(d=60+4,h=120,$fn=128);
    translate([20,-1,h/2]) rotate([-90,0,0]) cylinder(d=60+4,h=10,$fn=128);
  }
}
