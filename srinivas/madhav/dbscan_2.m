function accuracy = dbscan_2(M,eps,min_pts,n)
    labels = zeros(2100,1);
    c = 0;
    figure(n);
    for i = 1:2100
        xi = M(i,1);
        yi = M(i,2);
        if (labels(i)== 0 && check_core(M,xi,yi,eps,min_pts,i) == 1)
            c = c+1;
            labels = grow_cluster(M,xi,yi,eps,min_pts,i,labels,c);
        elseif(labels(i) == 0)
            labels(i) = -1;
        end
    end
    A = M(M(:, end) == -1, :);
    plot(A(:,1),A(:,2),'.');
    drawnow;
    annotation('textbox', [0, 0.9, 0.1, 0.1], 'String', "epsilon is " + eps + " and min points are " + min_pts);
    hold off
    accuracy = (length(M(M(:, end) == labels, :))/2100)*100;
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

function labels = grow_cluster(M,xi,yi,eps,min_pts,k,labels,c)
    counter_1 = 0;
    counter_2 = 1;
    while(1)
        i = k;
        j = k;
        counter_2 = counter_2+1;
        if(labels(i) == 0)
            counter_1 = counter_1+1;
            mat(counter_1,1:2) = M(i,1:2);
            mat(counter_1,3) = i;
            labels(i) = c;
        end
        while(M(i,1) <= (xi+eps))
            i = i+1;    
            if(i == 2101)
                break
            end
            if(M(i,2)<= (yi+eps) && M(i,2)>= (yi-eps) && labels(i) == 0)
                if(pdist([xi,yi;M(i,1),M(i,2)],'euclidean') <= eps)
                    counter_1 = counter_1+1;
                    mat(counter_1,1:2) = M(i,1:2);
                    mat(counter_1,3) = i;
                    labels(i) = c;
                end
            end
        end
        while(M(j,1) >= (xi-eps))
            j = j-1;
            if(j == 0)
                break
            end
            if(M(j,2)<= (yi+eps) && M(j,2)>= (yi-eps) && labels(j) == 0)
                if(pdist([xi,yi;M(j,1),M(j,2)],'euclidean') <= eps)
                    counter_1 = counter_1+1;
                    mat(counter_1,1:2) = M(j,1:2);
                    mat(counter_1,3) = j;
                    labels(j) = c;
                end
            end
        end
        tmp = size(mat);
        sz = tmp(1);
        while (counter_2 <= sz)
            i = counter_2;
            if(check_core(M,mat(i,1),mat(i,2),eps,min_pts,mat(i,3)) == 1)
                k = mat(i,3);
                xi = mat(i,1);
                yi = mat(i,2);
                break
            end
            counter_2 = counter_2+1;
        end
        if(counter_2 > sz)
            break
        end
    end
    plot(mat(:,1),mat(:,2),'.');
    hold on
end