function bur = BUR(root,dc,N,height,width)
rand_points = zeros(N,2);
k=1;
while k < N
    rx = width *rand(1,1);
    ry= height*rand(1,1);
    point = [rx ry];
    if ~ismember(point,rand_points,'rows')
        if norm(point - root) > dc
           % add this location to random points
            rand_points(k, :) = point;
            k=k+1;
        end
    end
end
directions = rand_points- root;
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


% for i=1:n
%     bur.Nodes.XData(i) = bur_points(i,1);
%     bur.Nodes.YData(i) = bur_points(i,2);
% end

bur.Nodes.XData(1:n) = bur_points(:,1);
bur.Nodes.YData(1:n) = bur_points(:,2);

plot(bur,'XData',bur.Nodes.XData,'YData',bur.Nodes.YData,'NodeColour','r','EdgeColour','g');
end
