function R = dbscan(x,eps,min_pts)
    M = csvread(x);
    labels = zeros(2100,1);
    M = M(randperm(size(M, 1)), :);
    c=0;
    for i = 1:2100
        xi = M(i,1);
        yi = M(i,2);
        if (labels(i)== 0 && check_core(M,xi,yi,eps,min_pts) == 1)
            counter = 0;
            for j = 1:2100
                if(M(j,1)<= (xi+eps) && M(j,1)>= (xi-eps) && M(j,2)<= (yi+eps) && M(j,2)>= (yi-eps))
                    if(dist([xi,yi;M(j,1),M(j,2)]) <= eps)
                        counter = counter+1;
                        temp_mat(counter,1:2) = M(j,1:2);
                        temp_mat(counter,3) = j;
                    end
                end
            end
            c=c+1;
            labels(i) = c;
            for j = 1:counter
                labels(temp_mat(j,3)) = c;
            end
            for j =1:counter
                if(check_core(M,temp_mat(j,1),temp_mat(j,2),eps,min_pts) == 1)
                    
                end
            end
        else
            labels(i) = -1;
        end
    end
end

function check = check_core(M,xi,yi,eps,min_pts)
    counter = 0;
    for j = 1:2100
        if(M(j,1)<= (xi+eps) && M(j,1)>= (xi-eps) && M(j,2)<= (yi+eps) && M(j,2)>= (yi-eps))
            if(dist([xi,yi;M(j,1),M(j,2)]) <= eps)
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