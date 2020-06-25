function [x1,y1,xCountMeanEff,yCountMeanEff,M] = removeNode_StructEvolve(M, M0, flag, updateCount)
%   node_removal calculates the results for node removal on real
%   networks with mutualistic dynamics

% flag=0 for low initial state
type = 1;
M = M_Rewire(M, M0, type);

[A, B] = bipartiteProjection(M);


t0      = 0;
tf      = 100;

options = [];
[SP,SA] = size(M);

if flag == 0
    x0 = 0.01*ones(SA,1);
    y0 = 0.01*ones(SP,1);
end

if flag == 1
    x0 = 10*ones(SA,1);
    y0 = 10*ones(SP,1);
end

    
[~,X_TimeSeries] = ode45(@abundanceEquation,[t0,tf],x0,options, A);
x = X_TimeSeries(end,:);
x1 = x';
[xeff, betaA, sA, HA] = betaspace(A, x1);
xCountMeanEff    = [updateCount, sA, HA, betaA, mean(x1), xeff, max(abs(x1 - x0))];

[~,Y_TimeSeries] = ode45(@abundanceEquation,[t0,tf],y0,options, B);
y = Y_TimeSeries(end,:);
y1 = y';
[yeff, betaB, sB, HB] = betaspace(B, y1);
yCountMeanEff    = [updateCount, sB, HB, betaB, mean(y1), yeff, max(abs(y1 - y0))];


end

