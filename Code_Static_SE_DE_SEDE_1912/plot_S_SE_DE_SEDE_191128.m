clear
close all
i = 5; % ith network
s = 1 + 20 * (i - 1); % number of results; start from s
%s = 53;

matData = dir('../Results_Static_SE_DE_SEDE/*.mat');
%%

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
        nodePerturb = zeros(nB, 9);
        
        for j = 1 : nB
            nodePerturb(j,1) = bee{1,r}{j,1} / nB;         % Fnx
            nodePerturb(j,2) = bee{1,r}{j,2}{1,1}(1,5);    % <x>-static-low
            nodePerturb(j,3) = bee{1,r}{j,3}{1,1}(1,5);    % <x>-static-high
            nodePerturb(j,4) = bee{3,r}{j,2}{1,1}(1,5);    % <x>-SE-low
            nodePerturb(j,5) = bee{3,r}{j,3}{1,1}(1,5);    % <x>-SE-high
            nodePerturb(j,6) = bee{5,r}{j,2}{1,1}(1,5);    % <x>-dynamic-low
            nodePerturb(j,7) = bee{5,r}{j,3}{1,1}(1,5);    % <x>-dynamic-high
            nodePerturb(j,8) = bee{7,r}{j,2}{1,1}(1,5);    % <x>-SEDE-low
            nodePerturb(j,9) = bee{7,r}{j,3}{1,1}(1,5);    % <x>-SEDE-high
        end
        nB_f = nB; %length(find(~cellfun(@isempty,flower{1,r}(:,1))));
        linkPerturb = zeros(nB_f, 9);
        for j = 1 : nB_f
            linkPerturb(j,1) = flower{2,r}{j,1} / nB_f;         % Fny
            linkPerturb(j,2) = flower{2,r}{j,2}{1,1}(1,5);    % <x>-static-low
            linkPerturb(j,3) = flower{2,r}{j,3}{1,1}(1,5);    % <x>-static-high
            linkPerturb(j,4) = flower{4,r}{j,2}{1,1}(1,5);    % <x>-SE-low
            linkPerturb(j,5) = flower{4,r}{j,3}{1,1}(1,5);    % <x>-SE-high
            linkPerturb(j,6) = flower{6,r}{j,2}{1,1}(1,5);    % <x>-dynamic-low
            linkPerturb(j,7) = flower{6,r}{j,3}{1,1}(1,5);    % <x>-dynamic-high
            linkPerturb(j,8) = flower{8,r}{j,2}{1,1}(1,5);    % <x>-SEDE-low
            linkPerturb(j,9) = flower{8,r}{j,3}{1,1}(1,5);    % <x>-SEDE-high
        end
        
        % plot
        
        if m == s+9
            colorB = [0 0 0]./255;
            colorR = [0 0 0]./255;
        else
            colorB = [0 115 193]./255;
            colorR = [220 87 11]./255;
        end
        
        figure(1);
        
        subplot(2,2,1)
        hold on
        plot(nodePerturb(:,1),nodePerturb(:,2:3),'^-','Color',colorB,'MarkerFaceColor',colorB,'Linewidth',0.5);
        
        subplot(2,2,2)
        hold on
        plot(nodePerturb(:,1),nodePerturb(:,4:5),'^-','Color',colorB,'MarkerFaceColor',colorB,'Linewidth',0.5);
        
        subplot(2,2,3)
        hold on
        plot(nodePerturb(:,1),nodePerturb(:,6:7),'^-','Color',colorB,'MarkerFaceColor',colorB,'Linewidth',0.5);
        
        subplot(2,2,4)
        hold on
        plot(nodePerturb(:,1),nodePerturb(:,8:9),'^-','Color',colorB,'MarkerFaceColor',colorB,'Linewidth',0.5);
        
        figure(2);
        subplot(2,2,1)
        hold on
        plot(linkPerturb(:,1),linkPerturb(:,2:3),'>-','Color',colorR,'MarkerFaceColor',colorR,'Linewidth',0.5);
        
        subplot(2,2,2)
        hold on
        plot(linkPerturb(:,1),linkPerturb(:,4:5),'>-','Color',colorR,'MarkerFaceColor',colorR,'Linewidth',0.5);
        
        subplot(2,2,3)
        hold on
        plot(linkPerturb(:,1),linkPerturb(:,6:7),'>-','Color',colorR,'MarkerFaceColor',colorR,'Linewidth',0.5);
        
        subplot(2,2,4)
        hold on
        plot(linkPerturb(:,1),linkPerturb(:,8:9),'>-','Color',colorR,'MarkerFaceColor',colorR,'Linewidth',0.5);
        
    end
    %  clear flower bee
    
end

figure(1)

subplot(2,2,1)
xlabel('f_n')
ylabel('<x>')
title('static')
box on

subplot(2,2,2)
xlabel('f_n')
ylabel('<x>')
title('SE')
box on

subplot(2,2,3)
xlabel('f_n')
ylabel('<x>')
title('DE')
box on

subplot(2,2,4)
xlabel('f_n')
ylabel('<x>')
title('SEDE')
box on
suptitle(['bee in Network', num2str(i)])

figure(2)

subplot(2,2,1)
xlabel('f_l')
ylabel('<x>')
title('static')
box on

subplot(2,2,2)
xlabel('f_l')
ylabel('<x>')
title('SE')
box on

subplot(2,2,3)
xlabel('f_l')
ylabel('<x>')
title('DE')
box on

subplot(2,2,4)
xlabel('f_l')
ylabel('<x>')
title('SEDE')
box on

suptitle(['flower in Network', num2str(i)])
%{
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
%}