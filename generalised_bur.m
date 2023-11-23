function [gbur,spine_flag,spine_point] = generalised_bur(goal,start,k,N,thr_hold,map,rrt_limit)

 root =start;
 spine_flag = 0;
 spine_point = [];

[dc,close_pt] = find_min_dist_to_obstacle(root,map); %select min distance to obstacle
dc = dc+0.00005;
if dc < thr_hold
    spine_flag =  1;
    gbur = rrt_bur(goal,root,close_pt,dc,map,rrt_limit); %escapes the edge after sampling few points
    %gbur = bur_rrt(goal,root,close_pt,dc,map,rrt_limit); % travels along the edges
    spine_point = [gbur.Nodes.XData(end) gbur.Nodes.YData(end)];
else
    gbur = Bur(root,dc,map,N);%  Initialize GBur to Bur
    
    for i = 1:N % Iterate through all spines
       
        for p = 1:k-1    %Iterate through all extensions in one direction
            
            [node_id,node] = findEndpoint(gbur,root, i);    % Find endpoint of GBur in direction 
    
            [dc,~] = find_min_dist_to_obstacle(node,map);
            dc=dc+0.0000;
            if dc < thr_hold
                break; %RRT MODE
            else
                gbur = updateGBur(gbur,root, node_id,node,dc,map); % Update GBur
            end 
        end
        
    end
end

end