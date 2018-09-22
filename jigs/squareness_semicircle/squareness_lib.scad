// Four semicircular holes in a square, this is their distance between opposing
// faces.

// This must be greater than your bit size, ideally 2-3x.
gSemicircleDia = 12;
gDiagonal = 200;

module PinHoles() {
  dist = gDiagonal*sqrt(2)/4+gSemicircleDia;
  translate([dist,dist])
  for(a=[0+45,90+45,180+45,270+45]) rotate([0,0,a])
    translate([-gDiagonal/2,0]) difference() {
      circle(gSemicircleDia,$fn=128);
      translate([0,-50]) square([100,100]);
    }
}
