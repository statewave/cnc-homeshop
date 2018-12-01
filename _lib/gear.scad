module _RackTooth(pitch, pitch_angle, height) {
  o = tan(pitch_angle) * height/2;
  polygon(points=[
    [-pitch/4+o,-height/2],
    [pitch/4-o,-height/2],
    [pitch/4+o,height/2],
    [-pitch/4-o,height/2],
  ]);
}

module Rack(pitch, pitch_angle, height, length) {
  difference() {
    translate([0,-height/2-10]) square([length, height+10]);
    for(x=[0:pitch:length]) translate([x,0]) _RackTooth(pitch, pitch_angle, height);
  }
}

function PitchDia(pitch, num_teeth) = let(
  c = pitch * num_teeth,
  d = c / PI) [c,d];

module Gear(pitch, pitch_angle, height, num_teeth) {
  specs = PitchDia(pitch, num_teeth);
  difference() {
    circle(d=specs[1]+height,$fn=256);
    for(a=[0:1:360])
      rotate([0,0,a])
      translate([-a*specs[0]/360,-specs[1]/2]) render()
        Rack(pitch, pitch_angle, height, specs[0]);
  }
}
