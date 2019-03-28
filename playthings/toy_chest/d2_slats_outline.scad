include <toy_chest_lib.scad>;

N=4;

M();

module M() {
  //for(j=[1]) translate([(L+8)*j,0])
  //  for(i=[0:N-1]) translate([0,(gSlatWidth+8)*i]) SlatOutline();
  for(i=[0:N]) translate([0,(gLidFrontWidth+6)*i]) LidFrontOutline();
}

//scale([-1,1]) rotate([0,0,90]) {
//  for(i=[0:10]) translate([0,gLidFrontWidth+8+(gSlatWidth+8)*i]) SlatOutline();
//  for(y=[0,gLidFrontWidth+8+(gSlatWidth+8)*11]) translate([0,y]) LidFrontOutline();
//}
