include <fillets.scad>;

SBR16 = [
  16, // 0: rod dia
  40, // 1: rail mounting (pocket) width
  30, // 2: z to center of rod (this plus next = 45)
  15, // 3: z from center to top of bearing block
  [30, 30, 5.5], // 4: bearing block mounting pattern/size
  [50, 50], // 5: bearing block mounting (pocket) size
  [30, 150, 6.35], // 6: rail mounting hole spacing/size
];

module RailProfile(spec) {
  rail_height = 5; // TODO put in spec
  // base
  translate([-spec[1]/2,0]) square([spec[1], rail_height]);
  hull() {  // TODO make this prettier if universal
    translate([0,spec[2]]) circle(d=spec[0]*0.5,$fn=32);
    translate([-spec[0]*1.3/2,0]) square([spec[0]*1.3, rail_height+1]);
  }
  // rod
  translate([0,spec[2]]) circle(d=spec[0],$fn=32);
}

module RailDemo(spec, length) {
  rotate([90,0,0]) translate([0,0,-length])
    linear_extrude(height=length, convexity=4) RailProfile(spec);
}

// TODO slot or oversize hole; you should register off the pocket
module RailHoles(spec, length) {
  LinearHolePattern(spec[6][1], length)
    translate([spec[6][0]/2,0])
      circle(d=spec[6][2],$fn=32);
}

// 
module LinearHolePattern(y_spacing, total_dist) {
  // TODO this rule should be simplified. Basically we don't want to put holes
  // at 0
  extra = total_dist % y_spacing;
  num_holes = floor(total_dist / y_spacing) - (extra == 0 ? 1 : 0);
  extra2 = (extra == 0 ? y_spacing : extra);
  for(i=[0:num_holes])
    for(x_scale=[1,-1]) scale([x_scale,1])
    translate([0,i*y_spacing+extra2/2])
      children();
}

module RailPocket(spec, length, bit_size) {
  translate([0,length/2]) SpikeBox([spec[1], length], bit_size, center=true);
}

module RailBlockDemo(spec, y) {
  translate([0,y,spec[2]]) cube([spec[5][0], spec[5][1], spec[3]*2], center=true);
}

module RailBlockHoles(spec, y) {
  translate([0,y]) for(x_scale=[1,-1],y_scale=[1,-1]) scale([x_scale,y_scale])
    translate([spec[4][0]/2,spec[4][1]/2]) circle(d=spec[4][2],$fn=32);
}
