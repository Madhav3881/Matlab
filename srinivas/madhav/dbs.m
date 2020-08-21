function accuracy = dbs(x)
    eps = linspace(0.5,2,16);
    min_pts = linspace(5,9,5);
    accuracy = zeros(80,3);
    n = 1;
    M = csvread(x);
    M = sortrows(M,1);
    for i = 1:16
        for j = 1:5
            accuracy(n,:) = [eps(i),min_pts(j),dbscan_2(M,eps(i),min_pts(j),n)];
            n = n+1;
        end
    end
    figure(n)
    scatter3(accuracy(:,1),accuracy(:,2),accuracy(:,3),'.');
end