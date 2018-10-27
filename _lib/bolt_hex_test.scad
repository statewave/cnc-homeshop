include <bolt_hex.scad>;

module F() {
  OvercutHex(quarter_inch[1], 4.0);
  translate([0,16]) OvercutHex(five_sixteenths_inch[1], 4.0);
}

difference() {
  offset(delta=5) hull() F();
  F();
}

