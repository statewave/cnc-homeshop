include <../../_lib/trig.scad>;
include <../../_lib/bolt_hex.scad>;

gBoltDia = three_eighths_inch[0];
gBoltFlats = three_eighths_inch[1];
gBitSize = 4.0;
//TODO: bit is defined in bolt_hex.scad

r1 = 35;
r2 = 15;
r3 = 250;
xs = 120;

module KnobOutline() {
  pos1 = [0,0];
  pos2 = [xs,0];
  pos3 = CircleCircleIntersection3([0,0], [xs,0], r1, r2, r3);

  intersection13 = Lerp(pos1, pos3, r1/(r1+r3));
  intersection23 = Lerp(pos2, pos3, r2/(r2+r3));

  for(x_scale=[1,-1], y_scale=[1,-1]) scale([x_scale,y_scale])
  difference() {
    union() {
      translate(pos1) circle(r=r1,$fn=128);
      translate(pos2) circle(r=r2,$fn=64);
      polygon(points=[pos1, intersection13, intersection23, pos2]);
    }
    // Known issue in cammill when using the same 2nd parameter, which I
    // believe is a misbehavior on tiny segments in cammill
    // https://github.com/thatch/cammill/issues/20
    translate(pos3) circle(r=r3+0.1,$fn=1024);
  }
}

module KnobPocket() {
  OvercutHex(gBoltFlats, gBitSize);
}

module KnobHole() {
  circle(d=gBoltDia, $fn=256);
}

gPatX = 44;
gPatY = 60;
gOffX = 70;
gNumX = 1;
gNumY = 3;

module Multiple() {
  for(i=[0:gNumX-1], j=[0:gNumY-1])
    translate([i*gPatX+(j%2==0?0:gOffX),j*gPatY]) children();
}
