back_thickness = 18.05;
back_rabbet = 4;
vertical_thickness = 18.05;
lip_size = 4;

pole_dia = 3.75 * 25.4;
pole_spacing = vertical_thickness*2+10;

edge_spacing = 16;

w = pole_dia*2 + pole_spacing + lip_size * 3 + vertical_thickness;
h = back_thickness + lip_size + pole_dia;
inner_height = 40;
back_width = w + pole_dia;


module Profile() {
  difference() {
    translate([-back_width/2,0]) square([back_width,h]);
    for(x_scale=[1,-1]) scale([x_scale,1])
      for(x=[(pole_dia+pole_spacing)/2+lip_size, (pole_dia+pole_spacing)/2+vertical_thickness+pole_dia+lip_size*3])
        translate([x,0]) hull() {
      for(y=[pole_dia/2+back_thickness+lip_size,pole_dia+back_thickness+lip_size])
      translate([0,y])
        circle(d=pole_dia,$fn=256);
    }
  }
}

module Rabbets() {
  for(x_scale=[1,-1]) scale([x_scale,1]) {
    translate([pole_spacing/2+pole_dia+lip_size*2,0]) square([vertical_thickness,h+4]);
    translate([-pole_spacing/2,0]) square([vertical_thickness,h+4]);
  }
  translate([-back_width/2-4,0]) square([back_width+8,back_thickness]);
  translate([-pole_spacing/2,h-back_thickness])
    square([pole_spacing,back_thickness+4]);
}

module RabbetsHole() {
  t = pole_spacing-vertical_thickness*2;
  translate([-t/2,back_thickness]) square([t,h-back_thickness*2]);
}

module Vertical(center_cutout=true) {
  difference() {
    square([h-back_thickness-(center_cutout?vertical_thickness-back_rabbet:0)+back_rabbet,inner_height]);
  }
}

module Back() {
  difference() {
    translate([-back_width/2,0]) square([back_width,inner_height]);
    translate([0,inner_height/2]) circle(d=8,$fn=32);
    for(x_scale=[1,-1]) scale([x_scale,1]) {
      translate([(pole_dia+pole_spacing)/3,inner_height/2]) circle(d=6,$fn=32);
      translate([pole_dia+pole_spacing+vertical_thickness+lip_size*3,inner_height/2]) circle(d=6,$fn=32);
    }

    for(x_scale=[1,-1]) translate([16*25.4/2*x_scale,inner_height/2]) circle(d=6,$fn=32);
  }
}

module BackRabbets() {
  intersection() {
    translate([0,-30]) Rabbets();
    translate([-back_width/2,-5]) square([back_width,inner_height+10]);
  }
}

module Spinner() {
  r=pole_dia+pole_spacing/2;
  difference() {
    offset(r=8,$fn=32) offset(delta=-8) intersection() {
      circle(r=r,$fn=256);
      hull() {
        circle(d=pole_spacing,$fn=32);
        translate([r,10]) circle(d=pole_spacing,$fn=32);
        translate([-r,10]) circle(d=pole_spacing,$fn=32);
        translate([r,r]) circle(d=pole_spacing,$fn=32);
        translate([-r,r]) circle(d=pole_spacing,$fn=32);
      }
    }
    circle(d=8,$fn=32);
  }
}

module HBone(_w,_h,d) {
  _t=1.41*d/4;
  square([_w,_h]);
  for(x=[_t,_w-_t])
  for(y=[_t,_h-_t])
    translate([x,y]) circle(d=d,$fn=32);
}

module SpinnerPocket() {
  translate([-199/2,-19.3/2]) HBone(199,15.5,4.1);
}

module Front() {
  intersection() {
    Back();
    translate([-pole_spacing/2,0]) square([pole_spacing, inner_height]);
  }
}

module FrontRabbets() {
  intersection() {
    BackRabbets();
    translate([-pole_spacing/2,-5]) square([pole_spacing,inner_height+10]);
  }
}
