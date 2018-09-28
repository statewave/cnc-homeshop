module Pattern(x_count=1, y_count=1, x_pitch, y_pitch) {
  for(i=[0:x_count-1], j=[0:y_count-1])
    translate([i*x_pitch, j*y_pitch]) children();
}

module PatternX(count, pitch) {
  Pattern(x_count=count, x_pitch=pitch) children();
}

module PatternY(count, pitch) {
  Pattern(y_count=count, y_pitch=pitch) children();
}


// In this sense, bounding_box is [width, height]

module DiagonalFit(bounding_box) {
  children();
  translate(bounding_box) rotate([0,0,180]) children();
}

// 4th quadrant specific
module DiagonalFit4th(bounding_box) {
  translate([0,bounding_box[1]]) children();
  translate([bounding_box[0], 0]) rotate([0,0,180]) children();
}
