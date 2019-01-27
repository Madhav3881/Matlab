function[sum] = amicable(x)
    sum = 0;
    for k = 1:x
        a = sumdiv(k);
        if (k == sumdiv(a) && a~= k)
            sum = sum+k;
        end
    end
end

function[s] = sumdiv(y)
    s = 0;
    for i = 1:(y/2)
        if(rem(y,i) == 0)
            s = s+i;
        end
    end
end