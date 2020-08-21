function accuracy = dbscan
    eps = linspace(0.8,2,13);
    min_pts = linspace(5,9,5);
    accuracy = zeros(65,3);
    n = 1;
    for i = 1:13
        for j = 1:5
            accuracy(n,:) = [eps(i),min_pts(j),dbscan_1('dbscan.csv',eps(i),min_pts(j),n)];
            n = n+1;
        end
    end
    figure(n)
    scatter3(accuracy(:,1),accuracy(:,2),accuracy(:,3),'.');
end