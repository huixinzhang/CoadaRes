function [outputX, outputY] = changeWeight(M)
%   weight_changes_M calculates the results for weight perturbations.
[m, n]    = size(M);
randRatio = rand(m, n) * 2;
M 		  = M .* randRatio;
ratio 	  = sum(sum(randRatio));

low    = 0.001;
high   = 6;
lowX0  = ones(n, 1) * low;
lowY0  = ones(m, 1) * low;
highX0 = ones(n, 1) * high;
highY0 = ones(m, 1) * high;

outputX = cell(1, 3);
outputY = cell(1, 3);
outputX{1, 1} = ratio;
outputY{1, 1} = ratio;
% calculate the equilibrated x, y with dynamically evolved M
% low state
[xx, yy] = steadyStateM(M, lowX0, lowY0);	
outputX{1, 2} = xx;
outputY{1, 2} = yy;
clear xx yy AA BB MM

% high state
[xx, yy] = steadyStateM(M, highX0, highY0);	
outputX{1, 3} = xx;
outputY{1, 3} = yy;
clear xx yy AA BB MM
