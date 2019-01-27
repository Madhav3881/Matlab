function[sum] = pow
    sum = 0;
    for i = 2:355000
        if (fifthpow(i) == i)
            sum = sum+i;
        end
    end
end

function[s] = fifthpow(y)
    s = 0;
    for j = 6:-1:0
        p = power(10,j);
        m = floor(y/p);
        y = y-(m*p);
        s = s+power(m,5);
    end
end