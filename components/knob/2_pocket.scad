include <knob_lib.scad>;

difference() {
  offset(delta=10) hull() Multiple() KnobPocket();
  Multiple() KnobPocket();
}
