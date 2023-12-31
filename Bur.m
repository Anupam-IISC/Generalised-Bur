function bur =Bur(root,dc,map,N)

%STEP 1 ---- > generate random points in the maps range
%specify the number of random points to generate
rand_points = zeros(N,2);
k=1;
while (k<=N)
    % generate random two number in range of map's border
   
    rx = map.xrange(1) + (map.xrange(2)-map.xrange(1))*rand(1,1);
    ry = map.yrange(1) + (map.yrange(2)-map.yrange(1))*rand(1,1);
    
    point = [rx ry];
    %check if the point is already in rand_points
    if ~ismember(point,rand_points,'rows')
        if norm(point - root) > dc
           % add this location to random points
            rand_points(k, :) = point;
            k=k+1;
        end
    end

end
 
%STEP2 ----> find the points on complete buble

% Calculate the direction vectors from each random point to the center point
directions = rand_points- root;


% Normalize the direction vectors to have unit length
norms = sqrt(sum(directions.^2, 2)); % calculate the norms of each row
unit_dirs = directions ./ norms; % divide each row by its corresponding norm

% Calculate the points at a distance of dc from point q on each line

offsets = unit_dirs * dc;
points_at_dist = root + offsets;

bur_points = [root;points_at_dist];



%STEP3------->from the bur_points create a graph

% Number of points in bur_points
n = size(bur_points, 1);

% Create a graph object with n nodes
bur = digraph();

% Add nodes to the graph

bur = addnode(bur, n);


% Add edges to the graph
for i = 2:n
    bur = addedge(bur, 1, i);
end

% Set the positions of the nodes based on their coordinates in bur_points


bur.Nodes.XData(1:n) = bur_points(:,1);
bur.Nodes.YData(1:n) = bur_points(:,2);

if bur.Nodes.XData(1) == bur.Nodes.XData(2) &&  bur.Nodes.YData(1) == bur.Nodes.YData(2)
    disp("yes");
end

% plot(bur,'XData',bur.Nodes.XData,'YData',bur.Nodes.YData,'NodeColor','k','EdgeColor','k');
end

