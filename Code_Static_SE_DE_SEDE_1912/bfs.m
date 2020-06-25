function visited = bfs(A,c)
%   bfs searches the set of nodes can reach and can be reached by
%   node c using Breadth first search for undirected networks
%
%   visited = bfs(A,c)
%
%   Inputs:
%       A : Adjacency matrix of the network
%       c : the node
%
%   Outputs:
%       visited : the set of nodes can reach and can be reached by node c 
%
%   See also bfs_strong. 

%   NuRsEv1.0
%   $Id: bfs.m Created at 2015-10-22 13:45:29 $
%   by Jianxi Gao, Northeastern University, Boston
%   Copyright (c) 2012-2015 by Center for Complex Network Research (CCNR)


visited = [];
toVisit = c;

while 1
    if ~any(toVisit)
        break;
    else
        [~, neighbors] = find(A(toVisit, :) ~= 0);
        visited = union(visited, toVisit);
        toVisit = setdiff(neighbors, visited);
    end
end

% ensure visited is a row vector
if (size(visited, 1) ~= 1)
	visited = visited';
end