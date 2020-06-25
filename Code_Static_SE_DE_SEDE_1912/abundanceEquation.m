function Fv = abundanceEquation(t,x,A)
%   M_system describes the mutualistic dynamic
%
%   Fv = M_system(t,x,A)
%
%   Inputs:
%       t : The time
%       x : The state vector of all nodes
%       A : Adjacency matrix of the network
%
%   Outputs:
%       Fv : the derivative of state x
%
%
%   See also R_system. 
%
%   NuRsEv1.0
%   $Id: M_system.m Created at 2015-10-23 13:45:29 $
%   by Jianxi Gao, Northeastern University, Boston
%   Copyright (c) 2012-2015 by Center for Complex Network Research (CCNR)
 
%load ode_A
%---Parameters for mutualistic dynamics-----------
B = 0.1; K = 5; C = 1; D = 5; E = 0.9; H =0.1;
%---Parameters for mutualistic dynamics-----------


[i,j,s] = find(A);
% The Alle afect self dynamic
Fv = B + x .* (1 - x / K) .* (x / C - 1); 
% the interaction term
for steps = 1 : length(i)
    Fv(i(steps)) = Fv(i(steps)) + s(steps)*x(i(steps))*x(j(steps))/(D+E*x(i(steps)) + H*x(j(steps)) );
end
