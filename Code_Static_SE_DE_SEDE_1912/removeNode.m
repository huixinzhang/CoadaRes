function [outputX_S, outputY_S, outputX_SE, outputY_SE, outputX_DE, outputY_DE, outputX_SEDE, outputY_SEDE] = removeNode(M, type, networkName)
%   node_removal calculates the results for node removal on real
%   networks with mutualistic dynamics

[m, n] = size(M);
randm  = randperm(m);
randn  = randperm(n);
M      = M(randm, randn);
[A, B] = bipartiteProjection(M);

lowXName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_lowX');
lowYName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_lowY');
highXName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_highX');
highYName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_highY');

load(lowXName, 'lowX');
load(lowYName,'lowY');
load(highXName, 'highX');
load(highYName,'highY');

xx_lowName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_xx_low');
yy_lowName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_yy_low');
xx_highName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_xx_high');
yy_highName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_yy_high');

load(xx_lowName, 'xx_low');
load(yy_lowName,'yy_low');
load(xx_highName, 'xx_high');
load(yy_highName,'yy_high');

[m, n] = size(M);
if type == 1
    maxRemove = n - 1;
else
    maxRemove = m - 1;
end
outputX_S = cell(maxRemove + 1, 3);
outputY_S = cell(maxRemove + 1, 3);

outputX_SE = cell(maxRemove + 1, 3);
outputY_SE = cell(maxRemove + 1, 3);

outputX_DE = cell(maxRemove + 1, 3);
outputY_DE = cell(maxRemove + 1, 3);

outputX_SEDE = cell(maxRemove + 1, 3);
outputY_SEDE = cell(maxRemove + 1, 3);


outputX_S{1, 1} = 0;
outputY_S{1, 1} = 0;
outputX_S{1, 2} = {xx_low, A, M};
outputY_S{1, 2} = {yy_low, B, M};
outputX_S{1, 3} = {xx_high, A, M};
outputY_S{1, 3} = {yy_high, B, M};

outputX_SE{1, 1} = 0;
outputY_SE{1, 1} = 0;
outputX_SE{1, 2} = {xx_low, A, M};
outputY_SE{1, 2} = {yy_low, B, M};
outputX_SE{1, 3} = {xx_high, A, M};
outputY_SE{1, 3} = {yy_high, B, M};

outputX_DE{1, 1} = 0;
outputY_DE{1, 1} = 0;
outputX_DE{1, 2} = {xx_low, A, M};
outputY_DE{1, 2} = {yy_low, B, M};
outputX_DE{1, 3} = {xx_high, A, M};
outputY_DE{1, 3} = {yy_high, B, M};

outputX_SEDE{1, 1} = 0;
outputY_SEDE{1, 1} = 0;
outputX_SEDE{1, 2} = {xx_low, A, M};
outputY_SEDE{1, 2} = {yy_low, B, M};
outputX_SEDE{1, 3} = {xx_high, A, M};
outputY_SEDE{1, 3} = {yy_high, B, M};



% remove nodes
if type == 1
    M(:,end) = [];
    lowX(end) = [];
    highX(end) = [];
else
    M(end,:) = [];
    lowY(end) = [];
    highY(end) = [];
end

removed = 0;
%% remove nodes

while(isempty(M)==0 && length(M(1,:))>=2 && length(M(:,1))>=2)
    removed = removed + 1
    index = removed + 1;
    outputX_S{index, 1} = removed;
    outputY_S{index, 1} = removed;
    outputX_SE{index, 1} = removed;
    outputY_SE{index, 1} = removed;
    outputX_DE{index, 1} = removed;
    outputY_DE{index, 1} = removed;
    outputX_SEDE{index, 1} = removed;
    outputY_SEDE{index, 1} = removed;
    %%
    [outputX_S{index,2:3}, outputY_S{index,2:3}] = removeNode_Static(M, A, B, type, xx_low, yy_low, xx_high, yy_high, lowX, lowY, highX, highY);
    [outputX_SE{index,2:3}, outputY_SE{index,2:3}] = removeNode_StructEvolve(M, A, B, type, xx_low, yy_low, xx_high, yy_high, lowX, lowY, highX, highY);
    [outputX_DE{index,2:3}, outputY_DE{index,2:3}] = removeNode_DynamicEvolve(M, A, B, type, xx_low, yy_low, xx_high, yy_high, lowX, lowY, highX, highY);
    [outputX_SEDE{index,2:3}, outputY_SEDE{index,2:3}] = removeNode_SEDE(M, A, B, type, xx_low, yy_low, xx_high, yy_high, lowX, lowY, highX, highY);
    
    
    if type == 1
        M(:,end) = [];
        lowX(end) = [];
        highX(end) = [];
    else
        M(end,:) = [];
        lowY(end) = [];
        highY(end) = [];
    end
    
end
