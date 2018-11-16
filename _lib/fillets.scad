module SpikeBox(dims, cutter_dia, center=false) {
  // This is intentionally tighter than just doing the math; wood compresses.
  off = 0.8 * cutter_dia / 2;
  translate(center ? [0,0] : [dims[0]/2,dims[1]/2]) {
    hull() for(x_scale=[1,-1], y_scale=[1,-1]) scale([x_scale,y_scale])
      translate([dims[0]/2-1,dims[1]/2-1])
      polygon(points=[[0,0], [1,0], [0,1]], convexity=2);
    // To debug corner intersection...
    // square(dims, center=true);
    for(x_scale=[1,-1], y_scale=[1,-1]) scale([x_scale,y_scale])
      translate([dims[0]/2-off, dims[1]/2-off])
      circle(d=cutter_dia,$fn=64);
  }
}
