include <fillets.scad>;

LEFT_EDGE = 1;
RIGHT_EDGE = 2;
TAB = 3;  // tab defined by left edge and width
CTAB = 4; // tab defined by center and width

// Sample tabs are [[TAB, xpos1, width1], [TAB, xpos2, width2], ...]
// Y origin is bottom.  If you want them centered, offset yourself.
module MiddleSlots(bit, thick, tabs) {
  for(t=tabs) if(t[0] == TAB || t[0] == CTAB)
    translate([GetLeft(t, bit),0]) SpikeBox([t[2],thick], bit);
}

// Y origin is bottom (appropriate for bottom tabs); use 
// the TabsTo* modules to move them to other sides.
module EdgeTabF(bit, thick, tabs) {
  off = sqrt(2) * bit / 4;
  for(t=tabs) if(t[0]==TAB || t[0] == CTAB) {
    translate([GetLeft(t, bit),-bit]) SpikeBox([t[2], thick+bit], bit);
  }
}

function GetLeft(tab, bit) =
  (tab[0] == TAB ? tab[1] :
   (tab[0] == CTAB ? tab[1] - tab[2] / 2 :
    (tab[0] == LEFT_EDGE ? tab[1] - bit :
     (tab[0] == RIGHT_EDGE ? tab[1] + bit : "FAIL"))));

module EdgeTabM(bit, thick, tabs) {
  for(i=[0:len(tabs)-1]) {
    if(tabs[i][0] == TAB || tabs[i][0] == CTAB) {
      this_right = GetLeft(tabs[i], bit) + tabs[i][2];
      next_left = GetLeft(tabs[i+1], bit);
      translate([this_right, -bit])
        SpikeBox([next_left-this_right, thick+bit], bit);
    } else if (tabs[i][0] == LEFT_EDGE) {
      this_right = GetLeft(tabs[i], bit);
      next_left = GetLeft(tabs[i+1], bit);
      translate([this_right, -bit])
        SpikeBox([next_left-this_right, thick+bit], bit);
    }
  }
}

module TabsToLeft(box) {
  scale([-1,1]) rotate([0,0,90]) children();
}

module TabsToRight(box) {
  translate([box[0], 0]) rotate([0,0,90]) children();
}

module TabsToTop(box) {
  translate([0,box[1]]) scale([1,-1]) children();
}
