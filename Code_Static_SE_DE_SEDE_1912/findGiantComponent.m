function giant = findGiantComponent(A)
%   findGiantComponent returns the set of nodes in the
%   giant connected component of undirected networks
%
%   cluster = findGiantComponent(A)
%
%   Inputs:
%       A : Adjacency matrix of the network
%
%   Outputs:
%       cluster : the set of nodes in the giant strongly connected component
%
%   See also findGiantComponent_strong. 

%   NuRsEv1.0
%   $Id: findGiantComponent.m Created at 2015-10-22 13:45:29 $
%   by Jianxi Gao, Northeastern University, Boston
%   Copyright (c) 2012-2015 by Center for Complex Network Research (CCNR)


n       = length(A);
all     = 1 : n;
unvis   = all;
cluster = [];
num     = 0;

while any(unvis)
    num = num + 1;
    c   = unvis(1);
    vis = bfs(A, c);
    
    cluster(num, 1 : (length(vis) + 1)) = [length(vis), vis];
    unvis = setdiff(unvis,vis);
end

[~, index] = max(cluster(:, 1));
giant      = cluster(index, 2 : end);