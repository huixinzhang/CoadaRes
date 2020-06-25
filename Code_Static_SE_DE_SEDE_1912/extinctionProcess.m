function [update_count] = extinctionProcess(M,networkName,k,extinctionAnimal_list)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
update_count = 1;

%[SP,SA] = size(M);

M_static_SE_DE_SEDE_process = cell(2,4);
xxyy_process = cell(2,16);

xCountMeanEff_low_static = zeros(2,7);
yCountMeanEff_low_static = zeros(2,7);
xCountMeanEff_high_static = zeros(2,7);
yCountMeanEff_high_static = zeros(2,7);

xCountMeanEff_low_SE = zeros(2,7);
yCountMeanEff_low_SE = zeros(2,7);
xCountMeanEff_high_SE = zeros(2,7);
yCountMeanEff_high_SE = zeros(2,7);

xCountMeanEff_low_DE = zeros(2,7);
yCountMeanEff_low_DE = zeros(2,7);
xCountMeanEff_high_DE = zeros(2,7);
yCountMeanEff_high_DE = zeros(2,7);

xCountMeanEff_low_SEDE = zeros(2,7);
yCountMeanEff_low_SEDE = zeros(2,7);
xCountMeanEff_high_SEDE = zeros(2,7);
yCountMeanEff_high_SEDE = zeros(2,7);

M_low = M;

while(isempty(M_low)==0 && length(M_low(1,:))>=2 && length(M_low(1,:))>=2)
    
    if update_count == 1 % initial the state of species
        
        lowXName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_lowX');
        lowYName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_lowY');
        highXName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_highX');
        highYName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_highY');
        
        load(lowXName, 'lowX');
        load(lowYName,'lowY');
        load(highXName, 'highX');
        load(highYName,'highY');
        
        x0_low_static = lowX(extinctionAnimal_list);
        y0_low_static = lowY;
        x0_high_static = highX(extinctionAnimal_list);
        y0_high_static = highY;
        
        x0_low_SE = lowX(extinctionAnimal_list);
        y0_low_SE = lowY;
        x0_high_SE = highX(extinctionAnimal_list);
        y0_high_SE = highY;
        
        x0_low_DE = lowX(extinctionAnimal_list);
        y0_low_DE = lowY;
        x0_high_DE = highX(extinctionAnimal_list);
        y0_high_DE = highY;
        
        x0_low_SEDE = lowX(extinctionAnimal_list);
        y0_low_SEDE = lowY;
        x0_high_SEDE = highX(extinctionAnimal_list);
        y0_high_SEDE = highY;
        
        xx_lowName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_xx_low');
        yy_lowName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_yy_low');
        xx_highName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_xx_high');
        yy_highName = strcat('../Results_Initial_Static_SE_DE_SEDE/foodWebs/',networkName,'_yy_high');
        
        load(xx_lowName, 'xx_low');
        load(yy_lowName,'yy_low');
        load(xx_highName, 'xx_high');
        load(yy_highName,'yy_high');
        
        xCountMeanEff_low_static(update_count,:) = xx_low;
        yCountMeanEff_low_static(update_count,:) = yy_low;
        xCountMeanEff_high_static(update_count,:) = xx_high;
        yCountMeanEff_high_static(update_count,:) = yy_high;
        
        xCountMeanEff_low_SE(update_count,:) = xx_low;
        yCountMeanEff_low_SE(update_count,:) = yy_low;
        xCountMeanEff_high_SE(update_count,:) = xx_high;
        yCountMeanEff_high_SE(update_count,:) = yy_high;
        
        xCountMeanEff_low_DE(update_count,:) = xx_low;
        yCountMeanEff_low_DE(update_count,:) = yy_low;
        xCountMeanEff_high_DE(update_count,:) = xx_high;
        yCountMeanEff_high_DE(update_count,:) = yy_high;
        
        xCountMeanEff_low_SEDE(update_count,:) = xx_low;
        yCountMeanEff_low_SEDE(update_count,:) = yy_low;
        xCountMeanEff_high_SEDE(update_count,:) = xx_high;
        yCountMeanEff_high_SEDE(update_count,:) = yy_high;
        
        
        M_low = M;
        M_SE_low = M;
        M_DE_low = M;
        M_SEDE_low = M;
        
        M_high = M;
        M_SE_high = M;
        M_DE_high = M;
        M_SEDE_high = M;
        
    else
        
        M_low(:,1) = [];
        %giant = find_gaint_component_mutual(M_low);
       % M_low = M_low(giant,giant);
        
        M_SE_low(:,1) = [];
       % giant = find_gaint_component_mutual(M_SE_low);
       % M_SE_low = M_SE_low(giant,giant);
        
        M_DE_low(:,1) = [];
        %giant = find_gaint_component_mutual(M_DE_low);
       % M_DE_low = M_DE_low(giant,giant);
        
        M_SEDE_low(:,1) = [];
      %  giant = find_gaint_component_mutual(M_SEDE_low);
      %  M_SEDE_low = M_SEDE_low(giant,giant);
        
        
        M_high(:,1) = [];
       % giant = find_gaint_component_mutual(M_high);
       % M_high = M_high(giant,giant);
        
        M_SE_high(:,1) = [];
      %  giant = find_gaint_component_mutual(M_SE_high);
      %  M_SE_high = M_SE_high(giant,giant);
        
        M_DE_high(:,1) = [];
      %  giant = find_gaint_component_mutual(M_DE_high);
      %  M_DE_high = M_DE_high(giant,giant);
        
        M_SEDE_high(:,1) = [];
      %  giant = find_gaint_component_mutual(M_SEDE_high);
      %  M_SEDE_high = M_SEDE_high(giant,giant);
        
        
        
        %% low initial state
        % static
        [x0_low_static,y0_low_static,xCountMeanEff_low_static(update_count,:),yCountMeanEff_low_static(update_count,:)] = removeNode_Static(M_low, 0, update_count);
        
        % SE
        % MAB_process{update_count-1,2} = M0_SE
        [x0_low_SE, y0_low_SE, xCountMeanEff_low_SE(update_count,:),yCountMeanEff_low_SE(update_count,:),M_SE_low] = removeNode_StructEvolve(M_SE_low, M_static_SE_DE_SEDE_process{update_count-1,2}, 0, update_count);
        
        % DE
        % xxyy_process{update_count,3} = x0_low_DE;    xxyy_process{update_count,11} = y0_low_DE;
        x0_DE = xxyy_process{update_count-1,3};
        y0_DE = xxyy_process{update_count-1,11};
        x0_DE(1) = [];
        [x0_low_DE, y0_low_DE, xCountMeanEff_low_DE(update_count,:),yCountMeanEff_low_DE(update_count,:),M_DE_low] = removeNode_DynamicEvolve(M_DE_low, x0_DE, y0_DE, 0, update_count);
        
        % SEDE
        % xxyy_process{update_count,4} = x0_low_SEDE; xxyy_process{update_count,12} = y0_low_SEDE; 
        % M_static_SE_DE_SEDE_process{update_count,4} = M_SEDE;
        x0_SEDE = xxyy_process{update_count-1,4};
        y0_SEDE = xxyy_process{update_count-1,12};
        x0_SEDE(1) = [];
        [x0_low_SEDE,y0_low_SEDE,xCountMeanEff_low_SEDE(update_count,:),yCountMeanEff_low_SEDE(update_count,:),M_SEDE_low] = removeNode_SEDE(M_SEDE_low, M_static_SE_DE_SEDE_process{update_count-1,4}, x0_SEDE, y0_SEDE, 0, update_count);
        
        
        
        %% high initial state
        % static
        [x0_high_static,y0_high_static,xCountMeanEff_high_static(update_count,:),yCountMeanEff_high_static(update_count,:)] = removeNode_Static(M_high, 1, update_count);
        
        % SE
        % M_static_SE_DE_SEDE_process{update_count,6} = M_SE_high;
        [x0_high_SE, y0_high_SE, xCountMeanEff_high_SE(update_count,:),yCountMeanEff_high_SE(update_count,:),M_SE_high] = removeNode_StructEvolve(M_SE_high, M_static_SE_DE_SEDE_process{update_count-1,6}, 1, update_count);
        
        % DE
        % xxyy_process{update_count,7} = x0_high_DE;    xxyy_process{update_count,15} = y0_high_DE;
        x0_DE = xxyy_process{update_count-1,7};
        y0_DE = xxyy_process{update_count-1,15};
        x0_DE(1) = [];
        [x0_high_DE, y0_high_DE, xCountMeanEff_high_DE(update_count,:),yCountMeanEff_high_DE(update_count,:),M_DE_high] = removeNode_DynamicEvolve(M_DE_high, x0_DE, y0_DE, 1, update_count);
        
        % SEDE
        % xxyy_process{update_count,8} = x0_high_SEDE; xxyy_process{update_count,16} = y0_high_SEDE; 
        % M_static_SE_DE_SEDE_process{update_count,8} = M_SEDE_high
        x0_SEDE = xxyy_process{update_count-1,8};
        y0_SEDE = xxyy_process{update_count-1,12};
        x0_SEDE(1) = [];
        [x0_high_SEDE,y0_high_SEDE,xCountMeanEff_high_SEDE(update_count,:),yCountMeanEff_high_SEDE(update_count,:),M_SEDE_high] = removeNode_SEDE(M_SEDE_high, M_static_SE_DE_SEDE_process{update_count-1,8}, x0_SEDE, y0_SEDE, 1, update_count);  
        
    end
    
    M_static_SE_DE_SEDE_process{update_count,1} = M_low;
    M_static_SE_DE_SEDE_process{update_count,2} = M_SE_low;
    M_static_SE_DE_SEDE_process{update_count,3} = M_DE_low;
    M_static_SE_DE_SEDE_process{update_count,4} = M_SEDE_low;
    
    M_static_SE_DE_SEDE_process{update_count,5} = M_high;
    M_static_SE_DE_SEDE_process{update_count,6} = M_SE_high;
    M_static_SE_DE_SEDE_process{update_count,7} = M_DE_high;
    M_static_SE_DE_SEDE_process{update_count,8} = M_SEDE_high;
    
    
    xxyy_process{update_count,1} = x0_low_static;
    xxyy_process{update_count,2} = x0_low_SE;
    xxyy_process{update_count,3} = x0_low_DE;
    xxyy_process{update_count,4} = x0_low_SEDE;
    xxyy_process{update_count,5} = x0_high_static;
    xxyy_process{update_count,6} = x0_high_SE;
    xxyy_process{update_count,7} = x0_high_DE;
    xxyy_process{update_count,8} = x0_high_SEDE;
    
    xxyy_process{update_count,9} = y0_low_static;
    xxyy_process{update_count,10} = y0_low_SE;
    xxyy_process{update_count,11} = y0_low_DE;
    xxyy_process{update_count,12} = y0_low_SEDE;
    xxyy_process{update_count,13} = y0_high_static;    
    xxyy_process{update_count,14} = y0_high_SE;    
    xxyy_process{update_count,15} = y0_high_DE;    
    xxyy_process{update_count,16} = y0_high_SEDE;
    
    update_count = update_count + 1;
    
end


%% save networks, x_CountMeanEff, y_CountMeanEff

% Networks in process
MABName = strcat('../Results/foodWebs/M/',networkName,'_M_repeat',num2str(k));
save(MABName, 'M_static_SE_DE_SEDE_process');

% xxyy for all species in process
xxyyName = strcat('../Results/foodWebs/M/',networkName,'_MAB_repeat',num2str(k));
save(xxyyName, 'xxyy_process');

% static
xCountMeanEff_low_staticName = strcat('../Results/foodWebs/static/',networkName,'_xCountMeanEff_low_static_repeat',num2str(k));
save(xCountMeanEff_low_staticName, 'xCountMeanEff_low_static');
yCountMeanEff_low_staticName = strcat('../Results/foodWebs/static/',networkName,'_yCountMeanEff_low_static_repeat',num2str(k));
save(yCountMeanEff_low_staticName, 'yCountMeanEff_low_static');
xCountMeanEff_high_staticName = strcat('../Results/foodWebs/static/',networkName,'_xCountMeanEff_high_static_repeat',num2str(k));
save(xCountMeanEff_high_staticName, 'xCountMeanEff_high_static');
yCountMeanEff_high_staticName = strcat('../Results/foodWebs/static/',networkName,'_yCountMeanEff_high_static_repeat',num2str(k));
save(yCountMeanEff_high_staticName, 'yCountMeanEff_high_static');

% SE
xCountMeanEff_low_SEName = strcat('../Results/foodWebs/SE/',networkName,'_xCountMeanEff_low_SE_repeat',num2str(k));
save(xCountMeanEff_low_SEName, 'xCountMeanEff_low_SE');
yCountMeanEff_low_SEName = strcat('../Results/foodWebs/SE/',networkName,'_yCountMeanEff_low_SE_repeat',num2str(k));
save(yCountMeanEff_low_SEName, 'yCountMeanEff_low_SE');
xCountMeanEff_high_SEName = strcat('../Results/foodWebs/SE/',networkName,'_xCountMeanEff_high_SE_repeat',num2str(k));
save(xCountMeanEff_high_SEName, 'xCountMeanEff_high_SE');
yCountMeanEff_high_SEName = strcat('../Results/foodWebs/SE/',networkName,'_yCountMeanEff_high_SE_repeat',num2str(k));
save(yCountMeanEff_high_SEName, 'yCountMeanEff_high_SE');

% DE
xCountMeanEff_low_DEName = strcat('../Results/foodWebs/DE/',networkName,'_xCountMeanEff_low_DE_repeat',num2str(k));
save(xCountMeanEff_low_DEName, 'xCountMeanEff_low_DE');
yCountMeanEff_low_DEName = strcat('../Results/foodWebs/DE/',networkName,'_yCountMeanEff_low_DE_repeat',num2str(k));
save(yCountMeanEff_low_DEName, 'yCountMeanEff_low_DE');
xCountMeanEff_high_DEName = strcat('../Results/foodWebs/DE/',networkName,'_xCountMeanEff_high_DE_repeat',num2str(k));
save(xCountMeanEff_high_DEName, 'xCountMeanEff_high_DE');
yCountMeanEff_high_DEName = strcat('../Results/foodWebs/DE/',networkName,'_yCountMeanEff_high_DE_repeat',num2str(k));
save(yCountMeanEff_high_DEName, 'yCountMeanEff_high_DE');

% SEDE
xCountMeanEff_low_SEDEName = strcat('../Results/foodWebs/SEDE/',networkName,'_xCountMeanEff_low_SEDE_repeat',num2str(k));
save(xCountMeanEff_low_SEDEName, 'xCountMeanEff_low_SEDE');
yCountMeanEff_low_SEDEName = strcat('../Results/foodWebs/SEDE/',networkName,'_yCountMeanEff_low_SEDE_repeat',num2str(k));
save(yCountMeanEff_low_SEDEName, 'yCountMeanEff_low_SEDE');
xCountMeanEff_high_SEDEName = strcat('../Results/foodWebs/SEDE/',networkName,'_xCountMeanEff_high_SEDE_repeat',num2str(k));
save(xCountMeanEff_high_SEDEName, 'xCountMeanEff_high_SEDE');
yCountMeanEff_high_SEDEName = strcat('../Results/foodWebs/SEDE/',networkName,'_yCountMeanEff_high_SEDE_repeat',num2str(k));
save(yCountMeanEff_high_SEDEName, 'yCountMeanEff_high_SEDE');


end

