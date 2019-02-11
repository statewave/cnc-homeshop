include <port_lib.scad>;

translate(gOffset) difference() {
  offset(delta=10) hull() InsetRabbet();
  InsetRabbet();
}
