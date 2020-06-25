%%
clear all
flag_node = 1;
flag_link = 0;

runs     = 1;
networks = dir('../source_data/foodWebs/*.mat');
%ids = [3,4,7,6,9];
ids = [1:7 9:27];
%%
% 3, 4, 7, 6, 9
for j = 1 : numel(ids)
    i = ids(j);
    % load network data
    %filename = strcat(networks(i).folder, '/', networks(i).name);
    filename = strcat('../source_data/foodWebs/', '/', networks(i).name);
    load(filename);
    tmp = strsplit(networks(i).name, '.');
    networkName = tmp{1};

    for k = 1 : 10
        
        tic
        
        M0 = file_data;
        [SP,SA] = size(M0);
        extinctionAnimal_list = randperm(SA);
        Ms = M0(:,extinctionAnimal_list);
        
        %% 
        flag = extinctionProcess(Ms,networkName,k,extinctionAnimal_list);

        toc
        
    end
    
end
