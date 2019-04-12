//square([600,300]);
//translate([0,200]) offset(r=20,$fn=256) offset(delta=-20) square([600,200]);

intersection() {
  square([600,30]);
  translate([0,-20]) offset(r=20,$fn=256) offset(delta=-20) square([600,50]);
}
