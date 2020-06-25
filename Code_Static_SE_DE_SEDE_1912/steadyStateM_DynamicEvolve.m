function [x1,y1, M, xx, yy, AA, BB, MM] = steadyStateM_DynamicEvolve(M, x0, y0, HighLow)

threshold   = 1E-3;
maxUpdate   = 20; % 1 means static M
updateCount = 1;

% calculate the steady state with dynamically evolved M
while updateCount <= maxUpdate
	% M -> A, B
    updateCount
	[A, B] = bipartiteProjection(M);
    MM{updateCount,1} = M;
    
	% A, B -> x, y
    clusterA              = findGiantComponent(A); 
    A                     = A(clusterA, clusterA);
    x0                    = x0(clusterA);
    x1                    = steadyStateAB(A, HighLow);
    [xeff, betaA, sA, HA] = betaspace(A, x1);
    xx(updateCount,:)     = [updateCount, sA, HA, betaA, mean(x1), xeff, max(abs(x1 - x0))];
    AA{updateCount,1}     = A;

    clusterB              = findGiantComponent(B);
    y0                    = y0(clusterB);
    B                     = B(clusterB, clusterB);
    y1                    = steadyStateAB(B, HighLow);
    [yeff, betaB, sB, HB] = betaspace(B, y1);
    yy(updateCount,:)     = [updateCount, sB, HB, betaB, mean(y1), yeff, max(abs(y1 - y0))];
    BB{updateCount,1}     = B;
    
    %if (mean((x1 - x0).^2) < threshold & mean((y1 - y0).^2) < threshold)
    %	break
    %end
    % x, y -> M
     M  = M(clusterB, clusterA);
     M  = updateM(M, x0, y0, x1, y1);
    x0 = x1;
    y0 = y1;
    updateCount = updateCount + 1;
    
    % collapse
    if (~any(mean(x1)) || ~any(mean(y1))) 
        break
    end

    % converge
    if (max(abs(x1 - x0)) < threshold && max(abs(y1 - y0)) < threshold ) %&& updateCount >= 5)
       break
    end


end