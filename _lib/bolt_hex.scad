quarter_inch = [6.5, 11, 4.5];
five_sixteenths_inch = [8.0, 12.55, 5.6];

FLAT_SCALE = sin(60);  // approx 0.866

module OvercutHex(flats_size, bit_dia, fudge_in=0) {
  circle(d=flats_size / FLAT_SCALE, $fn=6);
  for(r=[0:60:359]) rotate([0,0,r])
    translate([flats_size/2/FLAT_SCALE-bit_dia/2-fudge_in,0])
    circle(d=bit_dia,$fn=64);
}
