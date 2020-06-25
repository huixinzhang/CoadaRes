%%
clear all

runs     = 10;
networks = dir('../source_data/*.mat');
%ids = [3,4,7,6,9];
ids = [1,2,5,4,7];
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

    for k = 1 : 10
        tic
        flowerName = strcat('../Results_Static/ALL/',networkName,'_flower',num2str(k));
        beeName = strcat('../Results_Static/ALL/',networkName,'_bee',num2str(k));   

        [flower, bee] = perturb(M, runs);
        save(flowerName, 'flower');
        save(beeName,'bee');
        clear flower bee
        toc
    end
end
