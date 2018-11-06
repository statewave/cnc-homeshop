include <multmatrix.scad>;

module shape() {
    square([10,10]);
    circle(r=3,$fn=32);
}

multmatrix(rtmatrix(15, [10,0])) shape();

multmatrix(trmatrix(45, [-10,0])) shape();
