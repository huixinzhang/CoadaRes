clear all

runs     = 2;
networks = dir('../source_data/*.mat');
%ids = [3,4,7,6,9];
ids = [1,2,5,4,7];
j = 1;
i = ids(j);
    % load network data
    %filename = strcat(networks(i).folder, '/', networks(i).name);
    filename = strcat('../source_data/', '/', networks(i).name);
    load(filename);
    tmp = strsplit(networks(i).name, '.');
    networkName = tmp{1};
type = 1;

[m, n] = size(M);
randm  = randperm(m);
randn  = randperm(n);
M      = M(randm, randn);

if type == 1
	maxRemove = n - 1;
else
	maxRemove = m - 1;
end
outputX = cell(maxRemove + 1, 3);
outputY = cell(maxRemove + 1, 3);

low    = 0.001;
high   = 6;
lowX0  = ones(n, 1) * low;
lowY0  = ones(m, 1) * low;
highX0 = ones(n, 1) * high;
highY0 = ones(m, 1) * high;

[A, B] = bipartiteProjection(M);
lowX = steadyStateAB(A, lowX0)
[xeff, betaA, sA, HA] = betaspace(A, lowX);
xx_low(1,:)     = [1, sA, HA, betaA, mean(lowX), xeff, max(abs(lowX - lowX0))];

lowY = steadyStateAB(B, lowY0)
[yeff, betaB, sB, HB] = betaspace(B, lowY);
yy_low(1,:)     = [1, sB, HB, betaB, mean(lowY), yeff, max(abs(lowY - lowY0))];

highX = steadyStateAB(A, highX0)
[xeff, betaA, sA, HA] = betaspace(A, highX);
xx_high(1,:)     = [1, sA, HA, betaA, mean(highX), xeff, max(abs(highX - highX0))];

highY = steadyStateAB(B, highY0)
[yeff, betaB, sB, HB] = betaspace(B, highY);
yy_high(1,:)     = [1, sB, HB, betaB, mean(highY), yeff, max(abs(highY - highY0))];


outputX{1, 1} = 0;
outputY{1, 1} = 0;
outputX{1, 2} = {xx_low, A, M};
outputY{1, 2} = {yy_low, B, M};
outputX{1, 3} = {xx_high, A, M};
outputY{1, 3} = {yy_high, B, M};

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
	outputX{index, 1} = removed;
	outputY{index, 1} = removed;
    
    if sum(isnan(lowX))>=1 ||sum(isnan(lowY))>=1 ||sum(isnan(highX))>=1 ||sum(isnan(highY))>=1
        highX
        highY
        M
        break
    end
    
	% calculate the equilibrated x, y with dynamically evolved M
	% low state
% 	[lowX1, lowY1, M, xx, yy, AA, BB, MM] = steadyStateM(M, lowX, lowY);	
% 	outputX{index, 2} = {xx, AA, MM};
% 	outputY{index, 2} = {yy, BB, MM};
% 	clear xx yy AA BB MM
%     lowX, lowY

	% high state
	[highX1, highY1, M, xx, yy, AA, BB, MM] = steadyStateM(M, highX, highY);	
	outputX{index, 3} = {xx, AA, MM};
	outputY{index, 3} = {yy, BB, MM};
	clear xx yy AA BB MM
    highX, highY
    
    if sum(isnan(lowX))>=1 ||sum(isnan(lowY))>=1 ||sum(isnan(highX))>=1 ||sum(isnan(highY))>=1
        highX
        highY
        M
        break
    end
    
    highX = highX1;
    highY = highY1;
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
    
end    