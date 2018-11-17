include <../../_lib/bezier.scad>;

// Modeled after a shield used for taxidermy.

A = [0,130];
B = [80,123];
C = [88,104];
D = [85,0];
Da = [75,32];
Db = Add(D, Sub(D, Da));
E = [40,-52];
Ea = [50,-49.5];
Eb = Add(E, Sub(E, Ea));
F = [3,-78];
Fa = [20, -58];

gShieldSidePoints = concat(
  bezier_points([A, [40,130], [60,104], B], 0.1),
  bezier_points([C, [60, 52], Da, D], 0.1),
  bezier_points([D, Db, Ea, E], 0.1),
  bezier_points([E, Eb, Fa, F], 0.1)
);
gShieldPoints = concat(
  gShieldSidePoints,
  [for(i=[len(gShieldSidePoints)-1:-1:0]) [-gShieldSidePoints[i][0], gShieldSidePoints[i][1]]]);

module Shield() {
  polygon(points=gShieldPoints,convexity=4);
}
