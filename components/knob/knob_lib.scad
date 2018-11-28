include <../../_lib/lobes.scad>;
include <../../_lib/bolt_hex.scad>;

gMaterialThick = 12;
gCutDepth = -(gMaterialThick+0.4);
gPocketDepth = quarter_inch[2]+0.5;
gBitSize = 4.0;

gBoltDia = quarter_inch[0];
gBoltFlats = quarter_inch[1];

module KnobOutline() {
  difference() {
    Positive(5, 16, 6, 11, $fn=128);
    // Known issue in cammill when using the same 2nd parameter, which I
    // believe is a misbehavior on tiny segments in cammill
    // https://github.com/thatch/cammill/issues/20
    Negative(5, 15.9, 6, 11, $fn=128);
  }
}

module KnobPocket() {
  OvercutHex(gBoltFlats, gBitSize*1.05);
}

module KnobHole() {
  circle(d=gBoltDia, $fn=256);
}

gPatX = 44;
gPatY = 44;
gNumX = 3;
gNumY = 3;

module Multiple() {
  for(i=[0:gNumX-1], j=[0:gNumY-1])
    translate([i*gPatX,j*gPatY]) rotate([0,0,j%2==0?0:180]) children();
}
