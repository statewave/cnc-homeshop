include <bezier.scad>;

points = bezier_points([[-20,-10],[-10,25],[0,0],[10,15],[20,8],[8,0]], 0.05);
echo(points);
polygon(points=points, convexity=4);
