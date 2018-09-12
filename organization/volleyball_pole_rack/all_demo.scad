include <volleyball_pole_rack.scad>;

module F() {
  difference() {
    translate([0,0,-back_thickness+back_rabbet]) linear_extrude(height=back_thickness,convexity=20) Profile();
    linear_extrude(height=10,convexity=20) offset(r=2) offset(delta=-2) Rabbets();
  }
}

module G() {
  difference() {
    linear_extrude(height=vertical_thickness) Front();
    translate([0,0,vertical_thickness-back_rabbet]) linear_extrude(height=10) FrontRabbets();
  }
}

module H() {
  difference() {
    translate([0,0,-back_thickness]) linear_extrude(height=back_thickness) Back();
    translate([0,0,-10-back_thickness+back_rabbet]) linear_extrude(height=10) BackRabbets();
  }
}

module I() {
  linear_extrude(height=back_thickness) Spinner();
}

F();
translate([0,0,inner_height]) scale([1,1,-1]) F();

translate([0,h,0]) rotate([90,0,0]) G();

//rotate([90,0,0]) H();

translate([0,h+2,inner_height/2]) rotate([-90,0,0]) I();
