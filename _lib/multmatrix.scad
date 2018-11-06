// Rotation-Translation matrix
// r is angle around z
// t is translation (can be 2 or 3 numbers)
// intended for 2d though
function rtmatrix(r, t) = let(
    c=cos(r),
    s=sin(r)) [
    [c, -s, 0, t[0]],
    [s, c, 0, t[1]],
    [0, 0, 1, t[2]],
    [0,0,0,1]];

// Translation-Rotation matrix
function trmatrix(r, t) = let(
    c=cos(r),
    s=sin(r)) [
    [c, -s, 0, t[0]*c-t[1]*s],
    [s, c, 0, t[0]*s+t[1]*c],
    [0, 0, 1, t[2]],
    [0,0,0,1]];
            
