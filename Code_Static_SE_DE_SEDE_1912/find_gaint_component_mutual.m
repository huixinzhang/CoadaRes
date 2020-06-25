function [cluster_1,cluster_2] = find_gaint_component_mutual(M)
%   find_gaint_component returns the set of nodes in the
%   giant connected component of mutual network
%
%   cluster = find_gaint_component(A)
%
%   Inputs:
%       A : mutual matrix of the two networks
%
%   Outputs:
%       cluster : comprise of cluster1 and cluster2, the set of nodes in the giant strongly connected component
%
%   When cluster1 or cluster2 is full of nodes, it stops
 
%   Mutualv1.0
%   $Id: find_gaint_component.m Created at 2017-12-25 20:15 $
%   by Huixin Zhang, Shanghai Jiao Tong University
 
 
[n1,~] = size(M);
all_1 = 1:n1;

unvis_P = all_1;

cluster_1 = [];
cluster_2 = [];
 
 

num_max = 0;
flag = 0; % flag = 0 means c is plant, flag = 1 means c is animal
while any(unvis_P)
    
    c = unvis_P(1);
    [vis_P,vis_A] = bfs_mutual(M,c,flag);
    [mm,~] = size(vis_P);
    num = length(vis_P)+length(vis_A);
    if num>num_max
        cluster_1 = vis_P;
        cluster_2 = vis_A;
        num_max = num;
    end
    %check_P(num,1:(length(vis_P)+1)) = [length(vis_P),vis_P];
    unvis_P = setdiff(unvis_P,vis_P);
end

