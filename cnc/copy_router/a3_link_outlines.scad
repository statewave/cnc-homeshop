include <copy_router_lib.scad>;

translate([gLinkageWidth/2,135]) rotate([0,0,90]) HandleLink();
translate([gLinkageWidth*1.5+5,gLinkageWidth/2]) rotate([0,0,90]) LongLink();
translate([gLinkageWidth*2.5+10,gLinkageWidth/2]) rotate([0,0,90]) ShortLink();
translate([gLinkageWidth*3.5+15,gLinkageWidth/2]) rotate([0,0,90]) RouterLink();
translate([207,95]) rotate([0,0,125]) RouterClamp();
