include <dust_gate_lib.scad>;

difference() {
  offset(delta=10) TopPocket();
  TopPocket();
}
