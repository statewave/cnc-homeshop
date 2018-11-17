module SpikeBox(dims, cutter_dia, center=false, compression_mm=0.4) {
  // This is intentionally tighter than just doing the math; wood compresses.
  // The direction of compression_mm is from each edge, NOT a diagonal.
  // Really it's just a fudge factor.
  off = (sqrt(2) * cutter_dia / 4) + compression_mm;
  translate(center ? [0,0] : [dims[0]/2,dims[1]/2]) {
    hull() for(x_scale=[1,-1], y_scale=[1,-1]) scale([x_scale,y_scale])
      translate([dims[0]/2-off,dims[1]/2-off])
      polygon(points=[[0,0], [off,0], [0,off]], convexity=2);
    // To debug corner intersection...
    // # square(dims, center=true);
    for(x_scale=[1,-1], y_scale=[1,-1]) scale([x_scale,y_scale])
      translate([dims[0]/2-off, dims[1]/2-off])
      circle(d=cutter_dia,$fn=64);
  }
}
