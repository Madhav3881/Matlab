function [A] = hw3a(f,a,b,n)
    R = sparse(n+1,n+1);
    R(1,1) = ((b-a)/2)*(feval(f,a)+feval(f,b));
    h = b-a;
    for i = 2:n+1
        temp = 0;
        h = h/2;
        for k = 1:(2^(i-2))
            temp = temp+feval(f,(a+((2*k-1)*h)));
        end
        R(i,1) = (R(i-1,1)/2)+(h*temp);
        for j = 2:i
            R(i,j) = ((4^(j-1))*R(i,j-1)-R(i-1,j-1))/((4^(j-1))-1);
        end
    end
    T = array2table(R)
    A = R(n+1,n+1);
end

        