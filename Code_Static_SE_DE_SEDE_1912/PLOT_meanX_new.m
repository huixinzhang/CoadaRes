clear
close all
i = 5; % ith network
%s = 1 + 20 * (i - 1); % number of results; start from s
s = 53;

matData = dir('../Results_Static_SE_DE_SEDE/*.mat');
%%
colorB = [0 115 193]./255;
colorR = [220 87 11]./255;
% Fnx
f(1) = figure(1); hold on; % static
f(3) = figure(3); hold on; % dynamic
% Fny
f(2) = figure(2); hold on; % static
f(4) = figure(4); hold on; % dynamic

for m = s : s + 9 %m represent the ending number of the files in dynamics folder
    nodeSample = 1;

    filenameB = strcat('../Results_Static_SE_DE_SEDE', '/', matData(m).name);
    filenameF = strcat('../Results_Static_SE_DE_SEDE', '/', matData(m+10).name);
    load(filenameB);
    load(filenameF);    

    runs = size(bee, 2); % #runs
    
    
    %bee{1,runs+1} = bee{1,nodeSample};
    %flower{2,runs+1} = flower{2,nodeSample};    

    for r = 1 : runs% + 1
        nB = length(find(~cellfun(@isempty,bee{1,r}(:,1))));
        
        % process data
        nodePerturb = zeros(nB, 5); 

        for j = 1 : nB
            nodePerturb(j,1) = bee{1,r}{j,1} / nB;         % Fnx
            nodePerturb(j,2) = bee{1,r}{j,2}{1,1}(1,5);    % <x>-static-low
            nodePerturb(j,3) = bee{1,r}{j,3}{1,1}(1,5);    % <x>-static-high
            nodePerturb(j,4) = bee{5,r}{j,2}{1,1}(end,5);  % <x>-dynamic-low
            nodePerturb(j,5) = bee{5,r}{j,3}{1,1}(end,5);  % <x>-dynamic-high, 5->SEDE
        end 
        nB_f = nB; %length(find(~cellfun(@isempty,flower{1,r}(:,1))));
        linkPerturb = zeros(nB_f, 5);
        for j = 1 : nB_f
            linkPerturb(j,1) = flower{2,r}{j,1} / nB_f;         % Fny
            linkPerturb(j,2) = flower{2,r}{j,2}{1,1}(1,5);    % <x>-static-low
            linkPerturb(j,3) = flower{2,r}{j,3}{1,1}(1,5);    % <x>-static-high
            linkPerturb(j,4) = flower{4,r}{j,2}{1,1}(end,5);  % <x>-dynamic-low 4->DE
            linkPerturb(j,5) = flower{4,r}{j,3}{1,1}(end,5);  % <x>-dynamic-high
        end 

        % plot
        figure(1); plot(nodePerturb(:,1),nodePerturb(:,2:3),'^-','Color',colorB,'MarkerFaceColor',colorB,'Linewidth',0.5);
        figure(3); plot(nodePerturb(:,1),nodePerturb(:,4:5),'^-','Color',colorB,'MarkerFaceColor',colorB,'Linewidth',0.5);
        figure(2); plot(linkPerturb(:,1),linkPerturb(:,2:3),'>-','Color',colorR,'MarkerFaceColor',colorR,'Linewidth',0.5);
        figure(4); plot(linkPerturb(:,1),linkPerturb(:,4:5),'>-','Color',colorR,'MarkerFaceColor',colorR,'Linewidth',0.5);

             
        %if m == 6 && r == 2 && i = 1
%%%%%%%%%%%%if m ==2 && r == 1 %%%%%%%% s=1, bee2 flower1 dynamic
        if m == s && r ==1    
            highlightNodePerturb = nodePerturb;
            highlightLinkPerturb = linkPerturb;    
            figure(1); plot(highlightNodePerturb(:,1),highlightNodePerturb(:,2:3),'k^-','MarkerFaceColor','k','Linewidth',1.5);
        end
    end
  %  clear flower bee
end

figure(1); plot(highlightNodePerturb(:,1),highlightNodePerturb(:,2:3),'k^-','MarkerFaceColor','k','Linewidth',1.5);
figure(3); plot(highlightNodePerturb(:,1),highlightNodePerturb(:,4:5),'k^-','MarkerFaceColor','k','Linewidth',1.5);
figure(2); plot(highlightLinkPerturb(:,1),highlightLinkPerturb(:,2:3),'k>-','MarkerFaceColor','k','Linewidth',1.5);
figure(4); plot(highlightLinkPerturb(:,1),highlightLinkPerturb(:,4:5),'k>-','MarkerFaceColor','k','Linewidth',1.5);

    %% combine plots
    f5 = figure(5)
    for i = 1 : 4
        h(i) = subplot(2,2,i);
        copyobj(allchild(get(f(i),'CurrentAxes')), h(i));
        set(h(i),'FontSize',14,'Linewidth',1,'Box','on','XLim',[0 1],'YLim',[0 12],'YTick',[0:4:12])
    end
    
    h(1).YLabel.String = '<x>';
    h(2).YLabel.String = '<y>';
    h(3).YLabel.String = '<x>';
    h(4).YLabel.String = '<y>';
    
    set(h(1),'XTick',[])
    set(h(2),'XTick',[])
    h(3).XLabel.String = 'f_n';
    h(4).XLabel.String = 'f_l';