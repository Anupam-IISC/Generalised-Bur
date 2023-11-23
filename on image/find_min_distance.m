function [dc,close_pt] = find_min_distance(black,root)
dc = Inf;
close_pt = black(1,:);

% Loop over all black points
for i = 1:size(black, 1)
    % Calculate the distance between the root point and the current black point
    distance = norm(root - black(i,:));
    
    % Update dc and closest_point if the distance is less than the current minimum distance
    if distance < dc
        dc = distance;
        close_pt = black(i,:);
    end
end

