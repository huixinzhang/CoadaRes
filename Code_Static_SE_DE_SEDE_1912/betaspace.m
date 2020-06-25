function [x_eff, beta_eff, s, H] = betaspace(A, x)
%   betaspace calculates beta_eff and x_eff by A and x.
%
%   [x_eff,beta_eff] = betaspace(A,x)
%
%   Inputs:
%       A : Adjacency matrix of the network
%       x : the steady state vector of all nodes
%
%   Outputs:
%       x_eff : x_eff of all nodes
%       beta_eff : beta_eff of the network
dbstop if error

s_out = sum(A);
x_nss = A*x;
if sum(sum(A)) == 0 % if the network has no connectivity
    % beta xnn are not well defined when there is no network
    beta_eff = 0;
    x_eff = 0;
    s = 0;
    H = 0;
else % the network has its connectivity
    beta_eff = full(sum(sum(A*A))/sum(sum(A))); 
    x_eff = sum(x_nss)/sum(s_out); 
    s = mean(s_out);
    H = mean(s_out.^2) / s - s;
end
