// Four pins in a square, this is their distance between centers.

gPinDia = 8;
gDiagonal = 200;

module PinHoles() {
  dist = gDiagonal*sqrt(2)/4+gPinDia;
  translate([dist,dist])
  for(a=[0+45,90+45,180+45,270+45]) rotate([0,0,a])
    translate([-gDiagonal/2,0])
      circle(gPinDia,$fn=32);
}
