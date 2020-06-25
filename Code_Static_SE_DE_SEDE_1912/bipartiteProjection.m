function [A, B] = bipartiteProjection(M)
%   Bipartite_to_projection_net returns the projection networks from
%   mutualistic bipartitie network
%
%   Bipartite_to_projection_net(M)
%
%   Inputs:
%       M : mutualistic bipartitie network
%
%   Outputs:
%       file_name : save a .mat file including all the network data
%       A : the projection flower network
%       B : the projection bee network
%       M : mutualistic bipartitie network
%
%   See also remove_one_effect_the_other

%   MATRESILIENCE1.0
%   $Id: iteration_real_M.m Created at 2015-10-23 13:45:29 $
%   by Jianxi Gao, Northeastern University, Boston
%   Copyright (c) 2012-2015 by Center for Complex Network Research (CCNR)

[m,n] = size(M);

% According to Eq. (25) in the SI to calculate the A matrix
A  = zeros(n);
kn = sum(M, 2); % a vector denoting the number of flowers each bee visits

for i = 1 : n - 1
    for j = i + 1 : n
        index = find(M(:,i) ~= 0 & M(:,j) ~= 0);
        if numel(index) ~=0
            A(i,j) = sum((M(index,i) + M(index,j)) ./ kn(index));
            A(j,i) = A(i,j);
        end
    end
end


% According to Eq. (25) in the SI to calculate the B matrix
B  = zeros(m); 
km = sum(M); 

for i = 1 : m - 1
    for j = i + 1 : m
        index = find(M(i,:) ~= 0 & M(j,:) ~= 0);
        if numel(index) ~=0
            B(i,j) = sum((M(i,index) + M(j,index)) ./ km(index));
            B(j,i) = B(i,j);
        end
    end
end

%save file_name A B M