include <toy_chest_lib.scad>;

difference() {
  hull() offset(delta=10) M();
  M();
}

N=4;

module M() {
  //for(j=[1]) translate([(L+8)*j,0])
  //  for(i=[0:N-1]) translate([0,(gSlatWidth+8)*i]) SlatPocket();
  for(i=[0:N]) translate([0,(gLidFrontWidth+6)*i]) LidFrontPocket();
}

module OM() {
  for(i=[0:10]) translate([0,gLidFrontWidth+8+(gSlatWidth+8)*i]) SlatPocket();
  for(y=[0,gLidFrontWidth+8+(gSlatWidth+8)*11]) translate([0,y]) LidFrontPocket();
}

