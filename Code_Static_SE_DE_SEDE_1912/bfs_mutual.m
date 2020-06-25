function [vis_P,vis_A] = bfs_mutual(M,c,flag)
%   bfs searches the set of nodes can reach and can be reached by
%   node c using Breadth first search for undirected networks
%
%   vis = bfs(A,c)
%
%   Inputs:
%       A : Adjacency matrix of the network
%       c : the node
%
%   Outputs:
%       vis : the set of nodes can reach and can be reached by node c
%
%   See also bfs_strong.

%   NuRsEv1.0
%   $Id: bfs.m Created at 2015-10-22 13:45:29 $
%   by Jianxi Gao, Northeastern University, Boston
%   Copyright (c) 2012-2015 by Center for Complex Network Research (CCNR)

if flag == 0
    vis_P = c;
    vis_A = [];
    new_P = c;
    new_A = [];
end

if flag == 1
    vis_A = c;
    vis_P = [];
    new_A = c;
    new_P = [];
end


while 1
    
    tem = [];
    if flag == 0 % c is a plant
        if ~any(new_P)
            break;
        else
            for i = 1:length(new_P)
                tem0 = find(M(new_P(i),:) ~= 0); % to find its neighbour
                tem = union(tem,tem0);
                
            end
            flag = ~flag;
            new_A = setdiff(tem,vis_A); % setdiff(A,B):returns the values in A that are not in B with no repetitions
            vis_A = union(vis_A,tem); %  union(A,B): returns the combined values of the two vectors with no repetitions
        end
    else if flag == 1 % c is an animal
            if ~any(new_A)
                break;
            else
                for i = 1:length(new_A)
                    tem0 = find(M(:,new_A(i)) ~= 0);
                    tem = union(tem,tem0);
                    
                end
                flag = ~flag;
                new_P = setdiff(tem,vis_P); % setdiff(A,B):returns the values in A that are not in B with no repetitions
                vis_P = union(vis_P,tem); %  union(A,B): returns the combined values of the two vectors with no repetitions
            end
        end
    end
    
end
end

