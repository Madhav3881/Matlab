function accuracy = dbscan_1(x,eps,min_pts,n)
    M = csvread(x);
    M = sortrows(M,1);
    label = M(:,3);
    labels = zeros(2100,1);
    c=0;
    for i = 1:2100
        xi = M(i,1);
        yi = M(i,2);
        if (labels(i)== 0 && check_core(M,xi,yi,eps,min_pts,i) == 1)
            c=c+1;
            labels(i) = c;
            M(i,3) = -2;
            labels = points_mat(M,xi,yi,eps,min_pts,i,labels,c);
        elseif(labels(i) == 0)
            labels(i) = -1;
        end
    end
    M(:,3) = labels;
    figure(n);
    for i = 1:c
        A = M(M(:, end) == i, :);
        plot(A(:,1),A(:,2),'.');
        hold on
    end
    A = M(M(:, end) == -1, :);
    plot(A(:,1),A(:,2),'.');
    annotation('textbox', [0, 0.9, 0.1, 0.1], 'String', "epsilon is " + eps + " and min points are " + min_pts);
    hold off
    drawnow;
    accuracy = (length(M(M(:, end) == label, :))/2100)*100;
end

function check = check_core(M,xi,yi,eps,min_pts,k)
    counter = 1;
    i = k;
    j = k;
    while(M(i,1) <= (xi+eps))
        i = i+1;
        if(i == 2101)
            break
        end
        if(M(i,2)<= (yi+eps) && M(i,2)>= (yi-eps))
            if(pdist([xi,yi;M(i,1),M(i,2)],'euclidean') <= eps)
                counter = counter+1;
            end
        end
    end
    while(M(j,1) >= (xi-eps))
        j = j-1;
        if(j == 0)
            break
        end
        if(M(j,2)<= (yi+eps) && M(j,2)>= (yi-eps))
            if(pdist([xi,yi;M(j,1),M(j,2)],'euclidean') <= eps)
                counter = counter+1;
            end
        end
    end
    if(counter >= min_pts)
        check = 1;
    else
        check = 0;
    end
end

function labels = points_mat(M,xi,yi,eps,min_pts,k,labels,c)
    counter = 0;
    i = k;
    j = k;
    while(M(i,1) <= (xi+eps))
        i = i+1;    
        if(i == 2101)
            break
        end
        if(M(i,2)<= (yi+eps) && M(i,2)>= (yi-eps))
            if(pdist([xi,yi;M(i,1),M(i,2)],'euclidean') <= eps)
                counter = counter+1;
                mat(counter,1:2) = M(i,1:2);
                mat(counter,3) = i;
            end
        end
    end
    while(M(j,1) >= (xi-eps))
        j = j-1;
        if(j == 0)
            break
        end
        if(M(j,2)<= (yi+eps) && M(j,2)>= (yi-eps))
            if(pdist([xi,yi;M(j,1),M(j,2)],'euclidean') <= eps)
                counter = counter+1;
                mat(counter,1:2) = M(j,1:2);
                mat(counter,3) = j;
            end
        end
    end
    for i = 1:counter
        if(M(mat(i,3),3) ~= -2 && labels(mat(i,3)) ~= c)
            ch = check_core(M,mat(i,1),mat(i,2),eps,min_pts,mat(i,3));
            if(ch == 1)
                labels(mat(i,3)) = c;
                M(mat(i,3),3) = -2;
                labels = points_mat(M,mat(i,1),mat(i,2),eps,min_pts,mat(i,3),labels,c);
            end
        end
    end
    for i = 1:counter
        labels(mat(i,3)) = c;
    end
end