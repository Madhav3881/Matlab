%BT2020 Assignment 1A
%Roll number : BS16B022
%Collaborators : None
%Time :1:20
function [val] =  hw1b(x,k)
    val = 0;
    j = 1;
    h = zeros(k,2);
    while j <= k
        val = val + (power(-1,(j+1))*(power(x,((2*j)-1)))/factorial(((2*j)-1)));
        true = sin(x);
        err = abs(abs(true) - abs(val))/abs(true);
        if(k<=10)
            h(j,1:2) = [j,err];
            disp(h);
            j = j+1;
        end
    end
    T = array2table(h);
    disp(T);
end