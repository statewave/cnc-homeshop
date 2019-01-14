include <v_block_lib.scad>;

gRep = 5;

translate(gZeroOff) for(i=[0:gRep-2])
  translate([0, (gHeight+gBitSize*1.5)*i]) Outline();

translate(gZeroOff)
  translate([gMaterialThickness+gWidth+(gBitSize*1.5),0]) Outline(true);

translate([120,gHeight+gWidth/2+60]) Base(gRep);
