include <wing_lib.scad>;

translate(gTopOffset) difference() {
  offset(delta=10) hull() TopPocket();
  TopPocket();
}

