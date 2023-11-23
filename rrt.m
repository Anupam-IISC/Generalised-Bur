function iter = rrt(start,goal,map)
iter = 0;

max_iter = 100000;
connected = 0;
count = 0;
thr_hold = 1;
rrt_g = digraph();
rrt_g = addnode(rrt_g, 1);
rrt_g.Nodes.XData(1) = start(1);
rrt_g.Nodes.YData(1) = start(2);

while count < max_iter
    disp(count)
    while true
        rx = map.xrange(1) + (map.xrange(2) - map.xrange(1)) * rand(1, 1);
        ry = map.yrange(1) + (map.yrange(2) - map.yrange(1)) * rand(1, 1);
        point = [rx ry];
        if ~inpolygon(rx, ry, map.obsx, map.obsy)
            break
        end
    end


    near_p = findnearestpoint(rrt_g, point);
    near_p = near_p(1,:);
    near_p_id = find_node_id(rrt_g,near_p);
    
    
    if isempty(polyxpoly(map.obsx, map.obsy, [point(1),near_p(1)],[point(2),near_p(2)]))

        rrt_g = addnode(rrt_g, 1);
        e = numnodes(rrt_g);
        rrt_g.Nodes.XData(e) = point(1);
        rrt_g.Nodes.YData(e) = point(2);
        rrt_g = addedge(rrt_g, near_p_id, e);

        nearest_point_to_goal = findnearestpoint(rrt_g,goal);
        nearest_point_to_goal = nearest_point_to_goal(1,:);
        nearest_point_to_goal_id = find_node_id(rrt_g,nearest_point_to_goal);

        
        
        if norm(nearest_point_to_goal - goal) < thr_hold
            connected = 1;
            rrt_g = addnode(rrt_g, 1);
            j = numnodes(rrt_g);
            rrt_g.Nodes.XData(j) = goal(1);
            rrt_g.Nodes.YData(j) = goal(2);
            rrt_g = addedge(rrt_g, nearest_point_to_goal_id, j);
            iter = count;
            break
        else 
            count = count + 1;
        end
    end
end

if connected == 1
    darkmagenta = [139, 0, 139] / 255;
    chartreuse = [0, 255, 0] / 255;
    path = shortestpath(rrt_g, 1, numnodes(rrt_g));
    p = plot(rrt_g, 'XData', rrt_g.Nodes.XData, 'YData', rrt_g.Nodes.YData, 'NodeColor', darkmagenta, 'EdgeColor', darkmagenta);
    highlight(p, path, 'LineWidth', 2, 'EdgeColor', chartreuse);
else
    plot(rrt_g, 'XData', rrt_g.Nodes.XData, 'YData', rrt_g.Nodes.YData, 'NodeColor', 'y', 'EdgeColor', 'y');
end
end


