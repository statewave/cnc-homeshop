gMaterialThick = 19;
gBitSize = 4;

CornerPos = [[50,-20],[15,20]];
CornerRadius = 12;

// [hole size, handle width]
TorxSet = [[9, 20], [8, 16], [7, 16], [6, 16],
           [5, 16], [5, 13], [4, 13], [4, 13]];

Zero = [CornerPos[0][0]+CornerRadius,-CornerPos[0][1]+CornerRadius];

function _offset(set, spacing, i) = (
  i == 0 ? 0 : spacing + set[i][1] + _offset(set, spacing, i-1));

module RackHoles(set, spacing, hole_extra=0.2) {
  for(i=[0:len(set)-1]) translate([0,_offset(set, spacing, i)])
    circle(d=set[i][0]+hole_extra, $fn=32);
}

module RackOutline(set, spacing) {
  length = _offset(set, spacing, len(set)-1);
  hull() for(x_scale=[1,-1]) scale([x_scale,1]) {
    translate(CornerPos[0]) circle(r=CornerRadius,$fn=256);
    translate([0,length]) translate(CornerPos[1]) circle(r=CornerRadius,$fn=256);
  }
}
