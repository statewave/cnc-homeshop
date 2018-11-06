// This is ported from bezcompiler in tim-open-things
// since concat() and recursion works!

include <trig.scad>;

function _bezier_reduce(points, t) = (
  len(points) == 1 ?
    points[0] :
    _bezier_reduce(
      [for(i=[0:len(points)-2]) Lerp(points[i], points[i+1], t)], t));

function _bezier_recurse(points, low, high, max_error, first_time) =
  let(half=(high+low)/2,
      a=_bezier_reduce(points, low),
      b=_bezier_reduce(points, high),
      m=_bezier_reduce(points, half),
      dist=abs(LineDist(a, b, m)))
  ( dist > max_error || first_time ?
      concat(_bezier_recurse(points, low, half, max_error, false),
             _bezier_recurse(points, half, high, max_error, false)) :
      [b] );

// TODO: Verify that final point is always included
function bezier_points(points, max_error, begin=0, end=1) =
  concat([_bezier_reduce(points, begin)], _bezier_recurse(points, begin, end, max_error, true));
