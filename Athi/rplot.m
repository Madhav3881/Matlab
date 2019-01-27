function R = rplot(x)
    fid = fopen(x);
    fid1 = fopen(x);
    c = linecount(fid1);
    mat1 = strings([c,1]);
    mat = zeros(c,4);
    s = lc(mat1);
    angles = zeros(s,s);
    for i = 1:(c)
        l1 = fgets(fid);
        l2 = l1(1:4);
        if(l2(1:4) == "ATOM")
            if(l1(15) == ' ')
                mat1(i,1) = l1(14);
            elseif(l1(16) == ' ')
                mat1(i,1) = l1(14:15);
            else
                mat1(i,1) = l1(14:16);
            end
            if(l1(25) == ' ')
                mat(i,1) = str2double(l1(26));
            elseif(l1(24) == ' ')
                mat(i,1) = str2double(l1(25:26));
            else
                mat(i,1) = str2double(l1(24:26));
            end
            if(l1(33) == ' ')
                mat(i,2) = str2double(l1(34:38));
            elseif(l1(32) == ' ')
                mat(i,2) = str2double(l1(33:38));
            else
                mat(i,2) = str2double(l1(32:38));
            end
            if(l1(41) == ' ')
                mat(i,3) = str2double(l1(42:46));
            elseif(l1(40) == ' ')
                mat(i,3) = str2double(l1(41:46));
            else
                mat(i,3) = str2double(l1(40:46));
            end
            if(l1(49) == ' ')
                mat(i,4) = str2double(l1(50:54));
            elseif(l1(48) == ' ')
                mat(i,4) = str2double(l1(49:54));
            else
                mat(i,4) = str2double(l1(48:54));
            end
        end
    end
    for i = 1:c
        if(mat1(i) == 'CA')
            v1 = [mat(i,2)-mat(i-1,2) mat(i,3)-mat(i-1,3) mat(i,4)-mat(i-1,4)];
            v2 = [mat(i+1,2)-mat(i,2) mat(i+1,3)-mat(i,3) mat(i+1,4)-mat(i,4)];
            index = mat(i,1);
            k = i;
            while (index == mat(k,1))
                k = k+1;
            end
            v3 = [mat(k+1,2)-mat(i+1,2) mat(k+1,3)-mat(i+1,3) mat(k+1,4)-mat(i+1,4)];
            v4 = [mat(k+2,2)-mat(k+1,2) mat(k+2,3)-mat(k+1,3) mat(k+2,4)-mat(k+1,4)];
            
            n1 = cross(v1,v2);
            n2 = cross(v2,v3);
            n3 = cross(v3,v4);
            
            angles(mat(i,1),1) = atan2d(dot(cross(n1,v2),n2),dot(n1,n2));
            angles(mat(i,1),2) = atan2d(dot(cross(n2,v3),n3),dot(n2,n3));
        end
    end
    %R = angles;
    R = scatter(angles(:,2),angles(:,1));
end

function n = linecount(fid1)
    n = 0;
    tline = fgetl(fid1);
    while ischar(tline)
      tline = fgetl(fid1);
      n = n+1;
    end
end

function m = lc(P)
l = length(P);
    m = 0;
    for i = 1:l
        if(P(i) == "CA")
            m = m+1;
        end
    end
end