include <bezier.scad>;

points = bezier_points([[10,10], [30,20], [20,20], [20,10]], 0.01);
echo(points);
polygon(points=points, convexity=4);
