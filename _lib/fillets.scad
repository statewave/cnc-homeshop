module SpikeBox(dims, cutter_dia, center=false) {
  off = 0.78 * cutter_dia / 2;
  translate(center ? [0,0] : [dims[0]/2,dims[1]/2]) {
    square(dims, center=true);
    for(x_scale=[1,-1], y_scale=[1,-1])
      translate([(dims[0]/2-off)*x_scale, (dims[1]/2-off)*y_scale])
      circle(d=cutter_dia,$fn=64);
  }
}
