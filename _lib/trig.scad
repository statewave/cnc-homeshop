// TODO: remove unnecessary functions -- these were written before I noticed
// that openscad does vector/vector and vector/scalar operations natively.
function Magnitude(p) = sqrt((p[0]*p[0])+(p[1]*p[1]));
function Norm(p) = [p[0]/Magnitude(p), p[1]/Magnitude(p)];
function Rt(p) = [p[1], -p[0]];
function Lt(p) = Rt(Rt(Rt(p)));
function Bisect(p1, p2) = [(p1[0]+p2[0])/2, (p1[1]+p2[1])/2];
function Add(p1, p2) = [p1[0] + p2[0], p1[1] + p2[1]];
function Sub(p1, p2) = [p1[0] - p2[0], p1[1] - p2[1]];
function Mult(p, x) = [p[0]*x, p[1]*x];
function Lerp(a, b, p) = Add(a, Mult(Sub(b, a), p));

// TODO: use a rotation matrix
function Rot2d(p, theta) =
  [p[0]*cos(theta) - p[1]*sin(theta),
   p[1]*cos(theta) + p[0]*sin(theta)];

/* length of hypotenuse */ 
function Pyth(h, x) = sqrt((h*h)-(x*x));

/* See http://mathworld.wolfram.com/Circle-CircleIntersection.html */

function CircleIntersectionX(r1, r2, d) =
  ((d*d)-(r1*r1)+(r2*r2)) / (d*2);

function CircleIntersection(r1, r2, d, y_flag=1) =
  [CircleIntersectionX(r1, r2, d),
   sqrt(pow(r2, 2) - pow(CircleIntersectionX(r1, r2, d), 2)) * y_flag];

/* p1,p2=small circle pos, r_sm=small radius,
   r_lg=large radius, y_flag=[-1,1] for which solution
*/
function CircleCircleIntersection(p1, p2, r_sm, r_lg, y_flag=1) =
  /* todo: rotate */
  Add(p1, Rot2d(
    CircleIntersection(
      r_sm+r_lg, r_sm+r_lg,
      Magnitude(Sub(p1, p2)), y_flag),
    atan2(Sub(p2, p1)[1], Sub(p2, p1)[0])));

function CircleCircleIntersection3(p1, p2, r1, r2, r3, y_flag=1) =
  /* todo: rotate */
  Add(p1, Rot2d(
    CircleIntersection(
      r2+r3, r1+r3,
      Magnitude(Sub(p1, p2)), y_flag),
    atan2(Sub(p2, p1)[1], Sub(p2, p1)[0])));

function CircleCircleIntersectionPoint(p1, p2, r_sm, r_lg, pt_side, y_flag=1) =
  Lerp(pt_side, CircleCircleIntersection(p1, p2, r_sm, r_lg, y_flag), r_sm/(r_sm+r_lg));
