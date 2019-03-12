include <copy_router_lib.scad>;

difference() {
  offset(delta=10) hull() BaseHoles();
  BaseHoles();
}
