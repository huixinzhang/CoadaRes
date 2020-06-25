%% Save the initial state of a network before evolution, which avoids the calculation for every iteration
% built by Huixin Zhang at SJTU, 27-Nov-2019 19:28:49

%%
clear all


runs     = 1;
networks = dir('../source_data/*.mat');
%ids = [3,6];
ids = [1,2,3,4,5,7];
%%
% 3, 4, 7, 6, 9
for j = 1 : numel(ids)
    i = ids(j);
    % load network data
    %filename = strcat(networks(i).folder, '/', networks(i).name);
    filename = strcat('../source_data/', '/', networks(i).name);
    load(filename);
    tmp = strsplit(networks(i).name, '.');
    networkName = tmp{1};
    
    [m, n] = size(M);
    tic
    
    low    = 0.001;
    high   = 6;
    lowX0  = ones(n, 1) * low;
    lowY0  = ones(m, 1) * low;
    highX0 = ones(n, 1) * high;
    highY0 = ones(m, 1) * high;
    
    [A, B] = bipartiteProjection(M);
    lowX = steadyStateAB(A, 0);
    [xeff, betaA, sA, HA] = betaspace(A, lowX);
    xx_low(1,:)     = [1, sA, HA, betaA, mean(lowX), xeff, max(abs(lowX - lowX0))];
    
    lowY = steadyStateAB(B, 0);
    [yeff, betaB, sB, HB] = betaspace(B, lowY);
    yy_low(1,:)     = [1, sB, HB, betaB, mean(lowY), yeff, max(abs(lowY - lowY0))];
    
    highX = steadyStateAB(A, 1);
    [xeff, betaA, sA, HA] = betaspace(A, highX);
    xx_high(1,:)     = [1, sA, HA, betaA, mean(highX), xeff, max(abs(highX - highX0))];
    
    highY = steadyStateAB(B, 1);
    [yeff, betaB, sB, HB] = betaspace(B, highY);
    yy_high(1,:)     = [1, sB, HB, betaB, mean(highY), yeff, max(abs(highY - highY0))];
    
    lowXName = strcat('../Results_Initial_Static_SE_DE_SEDE/',networkName,'_lowX');
    lowYName = strcat('../Results_Initial_Static_SE_DE_SEDE/',networkName,'_lowY');
    highXName = strcat('../Results_Initial_Static_SE_DE_SEDE/',networkName,'_highX');
    highYName = strcat('../Results_Initial_Static_SE_DE_SEDE/',networkName,'_highY');
    
    save(lowXName, 'lowX');
    save(lowYName,'lowY');
    save(highXName, 'highX');
    save(highYName,'highY');
   
    xx_lowName = strcat('../Results_Initial_Static_SE_DE_SEDE/',networkName,'_xx_low');
    yy_lowName = strcat('../Results_Initial_Static_SE_DE_SEDE/',networkName,'_yy_low');
    xx_highName = strcat('../Results_Initial_Static_SE_DE_SEDE/',networkName,'_xx_high');
    yy_highName = strcat('../Results_Initial_Static_SE_DE_SEDE/',networkName,'_yy_high');
    
    save(xx_lowName, 'xx_low');
    save(yy_lowName,'yy_low');
    save(xx_highName, 'xx_high');
    save(yy_highName,'yy_high');
    
    toc
    
    
end
