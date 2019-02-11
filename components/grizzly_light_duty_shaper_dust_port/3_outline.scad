include <port_lib.scad>;

translate(gOffset) difference() {
  Outline();
  Port();
}
