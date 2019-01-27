function [sum] = factsum(x)
    sum =0;
    a = factorial(x);
    str = int2str(a);
    b = length(str);
    for i = (b-1):-1:0
        p = power(10,i);
        m = floor(a/p);
        sum = sum+m;
        a = a-(m*p);
    end
end