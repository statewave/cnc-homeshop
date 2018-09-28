include <pipe_hanger_lib.scad>;

difference() {
  offset(delta=10) hull() Many() MiddleSection();
  Many() MiddleSection();
}
