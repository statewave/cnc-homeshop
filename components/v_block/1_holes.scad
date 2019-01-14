include <v_block_lib.scad>;

gRep = 5;

module H() {
  translate(gZeroOff) for(i=[0:gRep-2])
    translate([0, (gHeight+gBitSize*1.5)*i]) Holes();

  translate(gZeroOff)
    translate([gMaterialThickness+gWidth+(gBitSize*1.5),0]) Holes();
}

difference() {
  offset(delta=10) hull() H();
  H();
}
