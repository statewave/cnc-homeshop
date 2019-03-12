include <copy_router_lib.scad>;

module M() {
  translate([gLinkageWidth/2,135]) rotate([0,0,90]) HandleLinkHoles();
  translate([gLinkageWidth*1.5+5,gLinkageWidth/2]) rotate([0,0,90]) LongLinkHoles();
  translate([gLinkageWidth*2.5+10,gLinkageWidth/2]) rotate([0,0,90]) ShortLinkHoles();
  translate([gLinkageWidth*3.5+15,gLinkageWidth/2]) rotate([0,0,90]) RouterLinkHoles();
}

difference() {
  offset(r=10) hull() M();
  M();
}

