function [flower, bee] = perturb(M, runs, networkName)

% row1 : remove nodes
% row2 : remove links
% row3 : change weights ## Not for now
flower = cell(8, runs); 
bee    = cell(8, runs);
% including S(static), SE(structure evolution), DE(dynamic evolution), SEDE(both); all for both link remove and node remove


flower1_S = cell(1, runs); % 1 for node remove
flower2_S = cell(1, runs); % 2 for link remove
bee1_S = cell(1, runs);
bee2_S = cell(1, runs);

flower1_SE = cell(1, runs);
flower2_SE = cell(1, runs);
bee1_SE = cell(1, runs);
bee2_SE = cell(1, runs);

flower1_DE = cell(1, runs);
flower2_DE = cell(1, runs);
bee1_DE = cell(1, runs);
bee2_DE = cell(1, runs);


flower1_SEDE = cell(1, runs);
flower2_SEDE = cell(1, runs);
bee1_SEDE = cell(1, runs);
bee2_SEDE = cell(1, runs);

% perturbation type 1 - remove nodes
% perturbation type 2 - remove links
for r = 1 : runs
    %[flower{1, r}, bee{2, r}] = removeNode(M, 1);
    %[flower{2, r}, bee{1, r}] = removeNode(M, 2);
    [flower1_S{1, r}, bee2_S{1, r}, flower1_SE{1, r}, bee2_SE{1, r}, flower1_DE{1, r}, bee2_DE{1, r}, flower1_SEDE{1, r}, bee2_SEDE{1, r}] = removeNode(M, 1, networkName);
    [flower2_S{1, r}, bee1_S{1, r}, flower2_SE{1, r}, bee1_SE{1, r}, flower2_DE{1, r}, bee1_DE{1, r}, flower2_SEDE{1, r}, bee1_SEDE{1, r}] = removeNode(M, 2, networkName);
end
flower(1, 1:runs) = flower1_S;
flower(2, 1:runs) = flower2_S;
flower(3, 1:runs) = flower1_SE;
flower(4, 1:runs) = flower2_SE;
flower(5, 1:runs) = flower1_DE;
flower(6, 1:runs) = flower2_DE;
flower(7, 1:runs) = flower1_SEDE;
flower(8, 1:runs) = flower2_SEDE;
bee(1, 1:runs) = bee1_S;
bee(2, 1:runs) = bee2_S;
bee(3, 1:runs) = bee1_SE;
bee(4, 1:runs) = bee2_SE;
bee(5, 1:runs) = bee1_DE;
bee(6, 1:runs) = bee2_DE;
bee(7, 1:runs) = bee1_SEDE;
bee(8, 1:runs) = bee2_SEDE;

% perturbation type 3 - change weights
% parfor r = 1 : runs
%     [flower{3, r}, bee{3, r}] = changeWeight(M);
% end

