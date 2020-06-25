function M = M_Rewire(M, M0, type)
[m, n] = size(M);
if type == 1
    SimilarVector = zeros(m,m);
    %%%%%%  Calculte the similarity between Bees
    for i_Similar = 1:(m-1)
        for j_Similar = i_Similar+1 : m
            CommonPlants = M(i_Similar,:).*M(j_Similar,:);
            UnionPlants  = M(i_Similar,:)+M(j_Similar,:);
            SimilarVector(i_Similar, j_Similar) = numel(find(CommonPlants))/numel(find(UnionPlants));
            SimilarVector(j_Similar, i_Similar) = SimilarVector(i_Similar, j_Similar);
        end
    end
    
    cost = 1;
    %%%%%% Change Weights and Rewire
    [a,~] = find(M0(:,1) ~= 0);
    [link_count,~] = size(a);
    for i = 1 :link_count
        Weight_removed = M0(a(i),1);
       % M(a(i),removed) = 0;
        OtherLinks = find(M(a(i),:));
        if numel(OtherLinks) ~= 0
            M(a(i),OtherLinks) = M(a(i),OtherLinks) + Weight_removed/length(OtherLinks);
        else
            Max_Similar = max(SimilarVector(a(i), :)); %% the orignal program may be not correct
            if Max_Similar ~=0
                Max_idx = find(SimilarVector(a(i), :) == Max_Similar);
                if numel(Max_idx) ~= 0
                    Similar_Bee = Max_idx(randi(length(Max_idx), 1));
                    M(a(i),:) = cost*M(Similar_Bee,:);
                end
            end
        end
    end
    
else
    SimilarVector = zeros(n,n);
    %%%%%%  Calculte the similarity between Bees
    for i_Similar = 1:(n-1)
        for j_Similar = i_Similar+1 : n
            CommonBees = M(:,i_Similar).*M(:,j_Similar);
            UnionBees = M(:,i_Similar,:)+M(:,j_Similar);
            SimilarVector(i_Similar, j_Similar) = numel(find(CommonBees))/numel(find(UnionBees));
            SimilarVector(j_Similar, i_Similar) = SimilarVector(i_Similar, j_Similar);
        end
    end
    
    cost = 1;
    %%%%%% Change Weights and Rewire
    [a,~] = find(M(removed,:) ~= 0);
    [~,link_count] = size(a);
    for i = 1 :link_count
        Weight_removed = M(removed,a(i));
        M(removed,a(i)) = 0;
        OtherLinks = find(M(:,a(i)));
        if numel(OtherLinks) ~= 0
            M(OtherLinks,a(i)) = M(OtherLinks,a(i)) + Weight_removed/length(OtherLinks);
        else
            Max_Similar = max(SimilarVector(:,a(i)));
            if Max_Similar ~=0
                Max_idx = find(SimilarVector(:,a(i)) == Max_Similar);
                if numel(Max_idx) ~= 0
                    Similar_Plant = Max_idx(randi(length(Max_idx), 1));
                    M(:,a(i)) = cost*M(:,Similar_Plant);
                end
            end
        end        
    end
end
