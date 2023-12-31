function [d, closestPt] = point_to_line_distance(pt, v1, v2)
% Computes the shortest distance between a point pt and a line segment
% defined by two endpoints v1 and v2, and returns the closest point on the
% line segment as well.

% vector from v1 to v2
v = v2 - v1;

w = pt - v1;

% projection of w onto v
c = dot(w, v) / norm(v)^2;

% closest point on the line segment to pt
if c <= 0
    closestPt = v1;
elseif c >= 1
    closestPt = v2;
else
    closestPt = v1 + c*v;
end

% distance between pt and closestPt
d = norm(pt - closestPt);

end
