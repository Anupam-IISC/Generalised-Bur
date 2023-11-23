%% For a point robot
close all
clear
% ocd = 3;
% time_array = zeros(1,ocd);
% o=0;
% tic;
% for o =1:ocd;
% disp(o);
% close all
% 




map=map_definition(0);

start=[3.2 5.5]; %start point
goal = [24.2 10];

% start=[140 60]; %start point
% goal = [1100 840];

plot(start(1),start(2),'k<');
plot(goal(1),goal(2),'k>');
rrt_mode = 1;
avg_array = zeros(10,1);

for m = 1:1
if rrt_mode == 0
    k=100; % number of points along each spine
    N= 10; %number of spines or number of points on complete bubble
    max_iter = 500;
    thr_hold = 0.05;
    epsilon = 0.05;
    connected = 0;
    rrt_limit = 1000;
    turn = 1;
    
    GBur_goal = digraph();
    GBur_goal = addnode(GBur_goal,1);
    GBur_goal.Nodes.XData(1) = goal(1);
    GBur_goal.Nodes.YData(1) = goal(2);
    
    GBur_start = digraph();
    GBur_start = addnode(GBur_start,1);
    GBur_start.Nodes.XData(1) = start(1);
    GBur_start.Nodes.YData(1) = start(2);
    
    
    
    for i = 1:max_iter
        
        if connected == 1
              avg_array(m) = i;
    %         time_array(o) = toc;
            break
        else
            disp(i);
            [GBur,ss_flag,last_point_in_ss] = generalised_bur(goal,start,k,N,thr_hold,map,rrt_limit);  
            
            if turn == 1
            
                GBur_start = addtobur(GBur_start,GBur);
                if ss_flag == 1
                    nearest_point = last_point_in_ss;
                    nearest_point_idx = find_node_id(GBur_start,nearest_point);
                else
                    [nearest_point,nearest_point_idx]  =  findnearestpoint(GBur_start,goal); 
                end
            else
                GBur_goal  = addtobur(GBur_goal,GBur);
                if ss_flag == 1
                    nearest_point = last_point_in_ss;
                    nearest_point_idx = find_node_id(GBur_goal,nearest_point);
                else
                    [nearest_point,nearest_point_idx]  =  findnearestpoint(GBur_goal,goal);
                end              
            
            end
        
        
            if isempty(polyxpoly(map.obsx,map.obsy,[goal(1),nearest_point(1)],[goal(2),nearest_point(2)]))
                
                [flag,points_ss]=singlespinebur(map,goal,nearest_point,k,epsilon); %can change here i am dropping the spine 
                if flag ==  1
                    disp("PATH FOUND!")
                    path5(GBur_start,GBur_goal,turn,points_ss,nearest_point_idx); %plot the path 
    %                 path3(GBur_start,GBur_goal,turn,points_ss,nearest_point_idx);
    %                 path4(GBur_goal,GBur_start,points_ss,map)
                    connected = 1;
                else
                    [turn,start,goal] = swap(nearest_point,goal,turn); 
                end
                        
                    %OR
    
    %             path2(turn,GBur_goal,GBur_start,goal,nearest_point_idx);
    %             connected =1;
            else
                [turn,start,goal] =  swap(nearest_point,goal,turn);
            end
        end
        if connected ~= 1
            plot(GBur_start, 'XData', GBur_start.Nodes.XData, 'YData', GBur_start.Nodes.YData,'NodeColor','y','EdgeColor','k');
            plot(GBur_goal,'XData',GBur_goal.Nodes.XData,'YData',GBur_goal.Nodes.YData,'NodeColor','m','EdgeColor','g');
        end 
    end
    % end
    % close all
    % plot(time_array);
    % xlabel('Iteration');
    % ylabel('Execution Time (s)');
    % title('Execution Time vs Iteration');
else
    
    iter = rrt(start,goal,map);
    avg_array(m) = iter;

end
end

avg = round(sum(avg_array)/10);