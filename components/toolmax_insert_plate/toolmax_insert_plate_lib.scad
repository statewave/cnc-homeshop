// Stock shaper plate: 191mm dia, 60mm hole, 4mm thick
// Stock saw plate: 391x113.9mm, 25mm radius on corners, 4.9mm thick
//
SawPlateSize = [113.9,391];
SawPlateRadius = 25;
SawPlateFingerHole = 19;
SawPlateFingerHoleSpacing = 15;

module SawPlate() {
  difference() {
    offset(r=SawPlateRadius,$fn=256) offset(delta=-SawPlateRadius)
      square(SawPlateSize);

    // finger hole
    translate([SawPlateFingerHole/2+SawPlateFingerHoleSpacing,
            SawPlateFingerHole/2+SawPlateFingerHoleSpacing])
      circle(d=SawPlateFingerHole,$fn=256);
  }
}
