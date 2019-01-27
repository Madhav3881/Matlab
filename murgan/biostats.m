function [min,max,range,m1,m2,m3,m4,beta1,beta2,f] = biostats(x,a,b)
    fid = fopen(x);
    fid1 = fopen(x);
    c = linecount(fid1);
    mat = zeros(c,1);
    for i = 1:c
        tline = fgets(fid);
        mat(i) = str2double(tline);
    end
    min = mat(a);
    max = mat(a);
    m1 = 0;
    m2 = 0;
    m3 = 0;
    m4 = 0;
    f = zeros(10,1);
    m = 0;
    for i = a:b
        m = m+mat(i);
    end
    m = m/100;
    for i = a:b
        if(mat(i)<min)
            min = mat(i);
        end
        if(mat(i)>max)
            max = mat(i);
        end
        m1 = m1+power((mat(i)-m),1);
        m2 = m2+power((mat(i)-m),2);
        m3 = m3+power((mat(i)-m),3);
        m4 = m4+power((mat(i)-m),4);
    end
    range = max-min;
    m1 = m1/100;
    m2 = m2/100;
    m3 = m3/100;
    m4 = m4/100;
    beta1 = power(m3,2)/power(m2,3);
    beta2 = m4/power(m2,2);
    %disp(min);
    %disp(max);
    %disp(range);
    %disp(m1);
    %disp(m2);
    %disp(m3);
    %disp(m4);
    %disp(beta1);
    %disp(beta2);
    feq = range/10;
    a1 = min;
    a2 = a1+feq;
    a3 = a2+feq;
    a4 = a3+feq;
    a5 = a4+feq;
    a6 = a5+feq;
    a7 = a6+feq;
    a8 = a7+feq;
    a9 = a8+feq;
    a10 = a9+feq;
    a11 = a10+feq;
    for i = a:b
        if(mat(i)>=a1 && mat(i)<a2)
            f(1)=f(1)+1;
        end
        if(mat(i)>=a2 && mat(i)<a3)
            f(2)=f(2)+1;
        end
        if(mat(i)>=a3 && mat(i)<a4)
            f(3)=f(3)+1;
        end
        if(mat(i)>=a4 && mat(i)<a5)
            f(4)=f(4)+1;
        end
        if(mat(i)>=a5 && mat(i)<a6)
            f(5)=f(5)+1;
        end
        if(mat(i)>=a6 && mat(i)<a7)
            f(6)=f(6)+1;
        end
        if(mat(i)>=a7 && mat(i)<a8)
            f(7)=f(7)+1;
        end
        if(mat(i)>=a8 && mat(i)<a9)
            f(8)=f(8)+1;
        end
        if(mat(i)>=a9 && mat(i)<a10)
            f(9)=f(9)+1;
        end
        if(mat(i)>=a10 && mat(i)<=a11)
            f(10)=f(10)+1;
        end
    end
end

function n = linecount(fid1)
    n = 0;
    tline = fgetl(fid1);
    while ischar(tline)
      tline = fgetl(fid1);
      n = n+1;
    end
end